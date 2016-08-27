Sequel.migration {
  up do
    add_column :tasks, :status, Integer, default: 0
    add_index  :tasks, :status
  end

  down do
    drop_index :tasks, :status
    drop_column :tasks, :status
  end
}