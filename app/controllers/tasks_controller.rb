class TasksController < ApplicationController
  
  def create
    @project = Project.find(params[:task][:project_id])
    unless current_user.can_view?(@project)
      redirect_to new_user_session_path
      return
    end
    @project.tasks.create(title: params[:task][:title],
      size: params[:task][:size], project_order: @project.next_task_order,
      user_id: current_user.id)
    redirect_to @project
  end
  
  def update
    @task = Task.find(params[:id])
    completed = params[:task].delete(:completed)
    params[:task][:completed_at] = Time.current if completed
    if @task.update_attributes(params[:task].permit(:size, :completed_at))
      TaskMailer.task_completed_email(@task).deliver if completed
      redirect_to @task, notice: "'project was successfully updated.'"
    else
      render action: 'edit'
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def up
    @task = Task.find(params[:id])
    @task.move_up
    redirect_to @task.project
  end
  
  def down
    @task = Task.find(params[:id])
    @task.move_down
    redirect_to @task.project
  end
end