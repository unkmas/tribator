Sequel.migration {
  up do
    create_table(:answers) do
      primary_key :id
      foreign_key :task_id, :tasks
      String :answer
    end
  end

  down do
    drop_table(:answers)
  end
}