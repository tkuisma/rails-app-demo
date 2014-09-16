class CreateCompanies < ActiveRecord::Migration
  def up
    create_table :companies do |t|
      t.string    :name, :limit => 100, :null => false
      t.integer   :company_type_id, :null => false

      t.string    :website, :limit => 255
      t.string    :email, :limit => 100
      t.string    :phone, :limit => 20
      t.string    :duns_number, :limit => 20

      t.string    :address, :limit => 50
      t.string    :zip, :limit => 20
      t.string    :city, :limit => 50
      t.string    :state_abbr, :limit => 2

      t.decimal   :latitude, :precision => 10, :scale => 7
      t.decimal   :longitude, :precision => 10, :scale => 7
      t.text      :info

      t.timestamps
    end

    Company.create_test_data(1000)
  end

  def down
    drop_table :companies
  end
end
