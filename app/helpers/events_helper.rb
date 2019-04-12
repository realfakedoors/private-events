module EventsHelper
  
  #Returns an array of confirmed guests for a given event.
  def guest_list(event)
    guests = event.invitations.where(accepted: true).collect{|inv| inv.guest_id}.uniq || []
    guests.map{|id| User.find_by(id: id)}
  end
  
  #Automatically invites and accepts the host upon creating an event.
  def add_host(host, event)
    Invitation.create(attended_event_id: event.id, guest_id: host.id, accepted: true)
  end
  
end