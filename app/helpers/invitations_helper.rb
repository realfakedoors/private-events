module InvitationsHelper
  
  #Checks if a guest has already accepted an invitation to this event.
  def guest_already_attending?(guest, event)
    true if event.invitations.any? do |inv|
      inv.guest_id == guest.id && inv.accepted?
    end
  end
  
end
