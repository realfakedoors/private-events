class InvitationsController < ApplicationController
  
  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitation = Invitation.save(invitation_params)
  end
  
  def index
    @invitations = Invitation.all
  end
  
  def destroy
    Invitation.find(params[:id]).destroy
  end
  
  private
  
    def invitation_params
      params.require(:invitation).permit(:attended_event_id, :guest_id)
    end
  
end
