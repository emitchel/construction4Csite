class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.string :email
      t.string :name
      t.text :message
      t.string :source

      t.timestamps
    end
  end
end
