class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_for_current_course, only: [:show]

  def show
  end


  def update
  end
  
  private


  def require_enrollment_for_current_course
    if  !current_user.enrolled_in?(current_lesson.section.course) 
      redirect_to course_path(current_lesson.section.course), alert: 'You must be enrolled in this Course to view the lesson'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video)
  end
  
end
