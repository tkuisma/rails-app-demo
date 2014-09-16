# encoding: utf-8

class AddLocalizedCompanyTypes < ActiveRecord::Migration
  def up
    add_column :company_types, :name_fi, :string, :limit => 50
    add_column :company_types, :name_sv, :string, :limit => 50

    CompanyType.reset_column_information

    CompanyType.where(:name_en => 'Prospect').first.update_columns(:name_fi => 'Prospekti', :name_sv => 'Eventuell kund')
    CompanyType.where(:name_en => 'Customer').first.update_columns(:name_fi => 'Asiakas', :name_sv => 'Kund')
    CompanyType.where(:name_en => 'Subcontractor').first.update_columns(:name_fi => 'Alihankkija', :name_sv => 'Underleverantör')
    CompanyType.where(:name_en => 'Reseller').first.update_columns(:name_fi => 'Jälleenmyyjä', :name_sv => 'Återförsäljare')
    CompanyType.where(:name_en => 'Partner').first.update_columns(:name_fi => 'Kumppani', :name_sv => 'Partner')
    CompanyType.where(:name_en => 'Competitor').first.update_columns(:name_fi => 'Kilpailija', :name_sv => 'Konkurrent')
  end

  def down
    remove_column :company_types, :name_sv
    remove_column :company_types, :name_fi
  end
end
