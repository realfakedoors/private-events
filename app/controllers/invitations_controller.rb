class InvitationsController < ApplicationController
  
  before_action only: [:create] do
    correct_user?(params[:invitation][:host_id])
  end
  
  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitations = invitation_params[:guest_ids].split(",").collect do |guest_id|
      guest_id.strip!
      Invitation.new(
        attended_event_id: invitation_params[:attended_event_id],
        guest_id: guest_id
        )
    end
    
    if @invitations.any?(&:invalid?)
      flash.now[:error] = "Failed to save!"
      redirect_to new_invitation_path
    else
      @invitations.each(&:save!)
      flash.now[:success] = "Invitation(s) sent!"
      redirect_to root_path
    end    
  end
  
  private
  
    def invitation_params
      params.require(:invitation).permit(:attended_event_id, :guest_ids)
    end
  
end
