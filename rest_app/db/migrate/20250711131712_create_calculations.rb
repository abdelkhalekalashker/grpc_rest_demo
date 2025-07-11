class CreateCalculations < ActiveRecord::Migration[7.2]
  def change
    create_table :calculations do |t|
      t.integer :result

      t.timestamps
    end
  end
end
