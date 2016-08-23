class Task < Sequel::Model
  one_to_many :answers

  def self.choose
    self.where('id not in (select distinct(task_id) from answers)').first
  end
end