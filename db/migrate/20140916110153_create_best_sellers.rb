class CreateBestSellers < ActiveRecord::Migration
  def up
    create_table :best_sellers do |t|
      t.string      :title
      t.integer     :best_seller_list_id, :null => false
      t.text        :description
      t.string      :author
      t.string      :publisher
      t.string      :primary_isbn13, :limit => 13
      t.string      :primary_isbn10, :limit => 10
      t.string      :book_image
      t.string      :amazon_product_url
      t.timestamps
    end

    puts "Creating best seller books"

    BestSellerList.order(:display_name).each do |list|
      books = NewYorkTimesInterface.fetch_best_sellers_for(list.encoded_name)
      puts "Fetching #{list.display_name} books #{books.size}"

      books.each do |book|
        existing_book = BestSeller.find_by_primary_isbn13(book['primary_isbn13'])
        unless existing_book
          print '.'
          b = BestSeller.new(book.symbolize_keys.select { |k,v| [:title,:description,:author,:publisher,:primary_isbn13,:primary_isbn10,:book_image,:amazon_product_url].include?(k) })
          b.best_seller_list = list
          b.save!
        end
      end

      puts "\n"
    end

    puts "\nDone."
  end

  def down
    drop_table :best_sellers
  end
end
