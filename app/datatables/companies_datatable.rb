class CompaniesDatatable < BaseDatatable

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalDisplayRecords: companies.total_entries,
        aaData: data
    }
  end

  private

  def data
    companies.map do |company|
      array = []
      array << link_to(company.name, company)
      array << company.address
      array << company.zip
      array << company.city
      array << (company.website.blank? ? '' : link_to(company.website, company.website, :target => '_blank'))
    end
  end

  def companies
    @companies ||= fetch_companies
  end

  def fetch_companies
    search = Company.search(:name_cont => params[:sSearch])
    companies = search.result.order("#{sort_column} #{sort_direction}").paginate(:page => page, :per_page => per_page)
    companies
  end

  def sort_column
    columns = %w[name address zip city]
    columns[params[:iSortCol_0].to_i]
  end

end
