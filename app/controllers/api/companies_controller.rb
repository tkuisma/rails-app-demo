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

end
