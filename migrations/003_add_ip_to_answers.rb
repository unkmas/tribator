Sequel.migration {
  up do
    add_column :answers, :ip, String
    add_index  :answers, [:task_id, :ip], unique: true
  end

  down do
    drop_index :answers, [:task_id, :ip]
    drop_column :answers, :ip
  end
}