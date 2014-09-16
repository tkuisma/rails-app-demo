class Api::CompaniesController < ApiController

  def index
    count_limit = (params[:limit].blank? ? 10 : params[:limit].to_i)
    companies = Company.limit(count_limit)

    fields = [:id, :name, :address, :zip, :city, :email, :phone, :duns_number]

    respond_to do |format|
      format.xml  { render :xml => companies.to_xml( :only => fields ) }
      format.json { render :json => companies.to_json( :only => fields ) }
    end
  end

  def create
    company = Company.new(company_params)
    unless company.save
      raise ApiErrorHandling::Exceptions::ResourceNotFoundException, "Company creation didn't succeed: #{company.errors.full_messages.to_sentence}"
    end

    respond_to do |format|
      format.xml  { render :xml => company.to_xml }
      format.json { render :json => company.to_json }
    end
  end

  def update
    company = Company.find_by_id(params[:id])
    raise ApiErrorHandling::Exceptions::ResourceNotFoundException, "No company found with ID #{params[:id]}" unless company

    unless company.update(company_params)
      raise ApiErrorHandling::Exceptions::ResourceNotFoundException, "Company update didn't succeed: #{company.errors.full_messages.to_sentence}"
    end

    respond_to do |format|
      format.xml  { render :xml => company.to_xml }
      format.json { render :json => company.to_json }
    end
  end

  private

  def company_params
    begin
      params.require(:company).permit(:name, :company_type_id, :address, :zip, :city, :state_abbr, :website, :email, :phone, :duns_number, :info)
    rescue => e
      raise ApiErrorHandling::Exceptions::MissingParametersError, e.to_s
    end
  end

end
