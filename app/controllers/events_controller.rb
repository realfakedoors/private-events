class EventsController < ApplicationController
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event
    else
      flash[:failed] = "Event failed to save!"
      redirect_to new_event_path
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def index
    @events = Event.all
  end
  
  private
  
    def event_params
      params.require(:event).permit(:name, :location, :datetime)
    end
  
end