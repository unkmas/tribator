class Task < Sequel::Model
  one_to_many :answers

  # Just exists in the DB
  NOT_PROCESSING = 0
  # Selected for processing
  PROCESSING = 1
  # Processed
  SOLVED = 2

  # Public: selects task for work
  #
  # Returns Task
  def self.choose
    self.where(status: PROCESSING).first
  end
end