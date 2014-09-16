class CompanyType < ActiveRecord::Base

  has_many :companies

  validates_presence_of :name_en, :sort_order

end
