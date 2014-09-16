class NewYorkTimesInterface

  API_URI = 'http://api.nytimes.com/svc/books/v2/lists/'

  def self.get_uri_for(action)
    "#{API_URI}#{action}.json?api-key=#{Rails.application.secrets.new_york_times["best_seller_list_api_key"]}"
  end

  def self.fetch_best_sellers_for(list)
    response = RestClient.get self.get_uri_for(list)
    result = JSON.parse(response.to_s)
    books = []
    result['results'].each do |book| books << book['book_details'].first end
    books
  end

  def self.fetch_best_seller_list_names
    response = RestClient.get self.get_uri_for('names')
    result = JSON.parse(response.to_s)
    result['results']
  end

end
