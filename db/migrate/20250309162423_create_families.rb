class CreateFamilies < ActiveRecord::Migration[7.2]
  def change
    create_table :families do |t|
      t.string :prénom
      t.string :nom
      t.integer :age

      t.timestamps
    end
  end
end
