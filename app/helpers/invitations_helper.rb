module InvitationsHelper
  
  #Checks if a guest has already accepted an invitation to this event.
  def guest_already_attending?(guest, event)
    return true if event.guest_list.split(",").any?{|x| x.strip.to_i == guest.id}
  end
  
end
