class CompaniesController < ApplicationController

  before_action :set_company, only: [:show, :edit, :update]

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

  def show

  end

  def edit

  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to @company
    else
      render action: 'new'
    end
  end

  def update
    if @company.update(company_params)
      redirect_to @company
    else
      render action: 'edit'
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :company_type_id, :address, :zip, :city, :state_abbr, :website, :email, :phone, :duns_number, :info, :credit_rating, :credit_rating_checked)
  end

end
