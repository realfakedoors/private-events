class EventsController < ApplicationController
  
  include EventsHelper
  
  before_action only: [:edit, :update, :destroy] do
    correct_user?(Event.find_by(params[:id]).host_id)
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    
    if current_user
      @event.write_attribute(:host_id, current_user.id)
    end
    
    if @event.save
      add_host(current_user, @event)
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
    redirect_to dashboard_path
  end
  
  private
  
    def event_params
      params.require(:event).permit(:name, :location, :datetime, :host_id)
    end
  
end