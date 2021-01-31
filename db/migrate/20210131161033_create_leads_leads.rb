class CreateLeadsLeads < ActiveRecord::Migration[6.1]
  def change
    create_table :leads_leads do |t|
      t.string :uid
      t.string :full_name
      t.string :phone_number
      t.string :source
      t.string :status

      t.timestamps
    end
    add_index :leads_leads, :uid
  end
end
