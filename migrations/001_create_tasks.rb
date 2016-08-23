Sequel.migration {
  up do
    create_table(:tasks) do
      primary_key :id
      String :hypernym, null: false
      String :description, null: false
    end
  end

  down do
    drop_table(:tasks)
  end
}