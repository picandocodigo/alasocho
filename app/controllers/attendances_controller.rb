class AttendancesController < ApplicationController
  before_filter :load_event_and_attendance

  def create
    if @event.slots_available?
      flash[:notice] = t("attendance.message.confirm", :event_name => @event.name)
      @attendance.confirm!
    else
      flash[:notice] = t("attendance.message.waitlist", :event_name => @event.name)
      @attendance.waitlist!
    end
    redirect_to @event
  end

  def destroy
  end

private
  def load_event_and_attendance
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.where(:user => current_user).first
  end
end
