class Task < ActiveRecord::Base
  has_many :comments
  
  def make_new_task(title, description)
    task = Task.new
    task.title = title
    task.description = description
    task.task_finished = false
    task.save
  end

  def set_done(task)
    task.task_finished = true
    task.save
  end
end
