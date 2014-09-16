class CompanyType < ActiveRecord::Base

  include HasLocalizedNames

  has_many :companies

  validates_presence_of :name_en, :sort_order

end
