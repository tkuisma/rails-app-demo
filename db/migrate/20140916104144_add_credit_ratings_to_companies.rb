class AddCreditRatingsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :credit_rating, :string, :limit => 3
    add_column :companies, :credit_rating_checked, :date
  end
end
