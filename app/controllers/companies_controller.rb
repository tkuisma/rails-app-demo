class CompaniesController < ApplicationController

  def index
    respond_to do |format|
      format.html {
        @page = 1
        @search = Company.search(params[:q])
        @companies = @search.result.order(:name).paginate(:page => @page, :per_page => 10)
      }
      format.json { render json: CompaniesDatatable.new(view_context) }
    end
  end

end
