class Answer < Sequel::Model
  many_to_one :task
end