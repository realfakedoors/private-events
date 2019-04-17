class InvitationsController < ApplicationController
  
  include InvitationsHelper
  include EventsHelper
  
  # ensures only the event's host can send invitations.
  before_action only: [:create] do
    correct_user?(event_host)
  end
  
  # and that only the proper guest can accept or decline them.
  before_action only: [:accept, :decline] do
    correct_user?(event_guest)
  end
  
  def new
    @invitation = Invitation.new
  end
  
  def create
    event_id = invitation_params[:attended_event_id]
    guests = invitation_params[:guest_id]
    
    guests.reject! { |g| g.empty? }
    
    invitations = guests.map do |guest_id|
      Invitation.new(attended_event_id: event_id, guest_id: guest_id)
    end
    
    if invitations.any?(&:invalid?)
      flash[:error] = "Failed to save!"
      redirect_to new_invitation_path
    else
      invitations.each(&:save!)
      flash[:success] = "Invitation(s) sent!"
      redirect_to event_path(Event.find(event_id))
    end    
  end
  
  def accept
    event = Event.find(params[:event])
    guest = User.find(params[:guest])
      
    if guest_list(event) && !guest_already_attending?(guest, event)
      Invitation.where(attended_event_id: event.id, guest_id: guest.id).find_each do |inv|
        inv.update_attribute(:accepted, true)
      end
    end
    
    flash[:success] = "Invitation accepted!"
    redirect_to event_path(event)
  end
  
  def decline
    Invitation.where(attended_event_id: params[:event], guest_id: params[:guest]).destroy_all
    
    flash.now[:success] = "Invitation declined!"
    redirect_to dashboard_path
  end
  
  private
  
    def invitation_params
      params.require(:invitation).permit(:attended_event_id, :guest_id => [])
    end
    
    def event_host
      Event.find(params[:invitation][:attended_event_id]).host_id
    end
    
    def event_guest
      User.find(params[:guest])
    end
  
end