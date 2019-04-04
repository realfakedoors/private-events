class InvitationsController < ApplicationController
  
  before_action only: [:create] do
    correct_user?(event_host)
  end
  
  def new
    @invitation = Invitation.new
  end
  
  def create
    event_id = invitation_params[:attended_event_id]
    invitations = invitation_params[:guest_ids].split(",").collect do |guest_id|
      guest_id.strip!
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
  
  private
  
    def invitation_params
      params.require(:invitation).permit(:attended_event_id, :guest_ids)
    end
    
    def event_host
      Event.find(params[:invitation][:attended_event_id]).host_id
    end
  
end