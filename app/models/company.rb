class Company < ActiveRecord::Base

  belongs_to :company_type

  validates_presence_of :name, :company_type

  def self.create_test_data(count = 1)
    max_company_type_id = CompanyType.last.id

    puts "Creating #{count} companies"

    count.times do |number|
      print '.'
      Company.create!(
          :name => Faker::Company.name,
          :company_type_id => rand(max_company_type_id) + 1,
          :website => Faker::Internet.url,
          :email => Faker::Internet.email,
          :phone => Faker::PhoneNumber.cell_phone,
          :duns_number => Faker::Company.duns_number,
          :address => Faker::Address.street_address,
          :zip => Faker::Address.zip,
          :city => Faker::Address.city,
          :state_abbr => Faker::Address.state_abbr,
          :latitude => Faker::Address.latitude,
          :longitude => Faker::Address.longitude,
          :info => Faker::Company.catch_phrase
      )
    end

    puts "\nDone."
  end

  def self.credit_ratings
    ['AAA','AA+','AA','AA-','A+','A','A-','BBB','BB+','BB','BB-','B+','B','B-','CCC']
  end

end
