class AddPhoneToLeads < ActiveRecord::Migration[5.1]
  def change
    add_column :leads, :phone, :string
  end
end
