module HasLocalizedNames

  extend ActiveSupport::Concern

  def localized_name
    locale_field = "name_#{I18n.locale}".to_sym
    if self.respond_to?(locale_field) && !self.send(locale_field).blank?
      self.send(locale_field)
    else
      self.name_fi
    end
  end

  def name
    localized_name
  end

  def to_s
    localized_name
  end

end
