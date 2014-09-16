class CreateCompanyTypes < ActiveRecord::Migration
  def up
    create_table :company_types do |t|
      t.string :name_en, :limit => 50
      t.integer :sort_order
      t.timestamps
    end

    CompanyType.create!(:name_en => 'Prospect', :sort_order => 1)
    CompanyType.create!(:name_en => 'Customer', :sort_order => 2)
    CompanyType.create!(:name_en => 'Subcontractor', :sort_order => 3)
    CompanyType.create!(:name_en => 'Reseller', :sort_order => 4)
    CompanyType.create!(:name_en => 'Partner', :sort_order => 5)
    CompanyType.create!(:name_en => 'Competitor', :sort_order => 6)
  end

  def down
    drop_table :company_types
  end
end
