class BestSellersDatatable < BaseDatatable

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalDisplayRecords: best_sellers.total_entries,
        aaData: data
    }
  end

  private

  def data
    best_sellers.map do |best_seller|
      array = []
      array << image_tag(best_seller.book_image, height: '100',)
      array << best_seller.title.titleize
      array << best_seller.author
      array << best_seller.description
      array << best_seller.best_seller_list.display_name
      array << (best_seller.amazon_product_url.blank? ? '' : link_to(best_seller.primary_isbn13, best_seller.amazon_product_url, :target => '_blank'))
    end
  end

  def best_sellers
    @companies ||= fetch_best_sellers
  end

  def fetch_best_sellers
    search = BestSeller.search(:title_cont => params[:sSearch])
    companies = search.result.joins(:best_seller_list).order("#{sort_column} #{sort_direction}").paginate(:page => page, :per_page => per_page)
    companies
  end

  def sort_column
    columns = %w[id title author description display_name]
    columns[params[:iSortCol_0].to_i]
  end

end
