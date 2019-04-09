module EventsHelper
  
  def guest_list(event)
    guests = event.invitations.where(accepted: true).collect{|inv| inv.guest_id}.uniq || []
    guests.map{|id| User.find_by(id: id)}
  end
  
  def guests_attending?(event)
    event.invitations.where(accepted: true).any?
  end
  
end