class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.integer :product_id
      t.integer :quantity
    end
  end
end
