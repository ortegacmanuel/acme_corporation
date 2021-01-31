class AddEmailToLeadsLeads < ActiveRecord::Migration[6.1]
  def change
    add_column :leads_leads, :email, :string
  end
end
