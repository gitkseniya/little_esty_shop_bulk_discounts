class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.references :merchant, foreign_key: true
      t.decimal :percent_off
      t.integer :min_threshold
    end
  end
end
