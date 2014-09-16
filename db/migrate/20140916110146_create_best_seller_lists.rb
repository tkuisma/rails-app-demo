class CreateBestSellerLists < ActiveRecord::Migration
  def up
    create_table :best_seller_lists do |t|
      t.string      :display_name
      t.string      :encoded_name
      t.date        :oldest_published_date
      t.date        :newest_published_date
      t.string      :update_frequency
      t.timestamps
    end

    lists = NewYorkTimesInterface.fetch_best_seller_list_names

    puts "Creating best seller lists"

    lists.each do |list|
      print '.'
      BestSellerList.create(
          :display_name => list['display_name'],
          :encoded_name => list['list_name_encoded'],
          :oldest_published_date => list['oldest_published_date'],
          :newest_published_date => list['newest_published_date'],
          :update_frequency => list['updated']
      )
    end

    puts "\nDone."
  end

  def down
    drop_table :best_seller_lists
  end
end
