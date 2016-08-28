class Answer < Sequel::Model
  many_to_one :task

  # Internal: updates status of task if there are 2 or more equal answers
  #
  # Returns nothing
  def after_create
    if DB.select(1).where(Answer.where(task_id: task.id).group_and_count(:answer).where { count > 1 }.exists)
      task.update(status: Task::SOLVED)
    end
  end
end