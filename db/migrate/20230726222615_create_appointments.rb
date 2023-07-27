class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :slot, null: false, foreign_key: true
      t.belongs_to :student, null: false, foreign_key: true
      t.integer :satisfaction
      t.text :notes
      t.datetime :completed_at

      t.timestamps
    end
  end
end
