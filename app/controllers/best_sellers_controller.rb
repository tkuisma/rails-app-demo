class BestSellersController < ApplicationController

  def index
    respond_to do |format|
      format.html {
        @page = 1
        @search = BestSeller.search(params[:q])
        @companies = @search.result.order(:title).paginate(:page => @page, :per_page => 10)
      }
      format.json { render json: BestSellersDatatable.new(view_context) }
    end
  end

end
