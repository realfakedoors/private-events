class EventsController < ApplicationController
  
  before_action only: [:edit, :update, :destroy] do
    correct_user?(params[:host_id])
  end
  
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
  
  def edit
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated!"
      redirect_to @event
    else
      render 'edit'
    end
  end
  
  def index
    @events = Event.all
  end
  
  def destroy
    Event.find(params[:id]).destroy
  end
  
  private
  
    def event_params
      params.require(:event).permit(:name, :location, :datetime, :host_id)
    end
  
end