class AuthorsProvider

  attr_reader :results

  def initialize(key)
    @results = Author.all
    filter_by_key(key)
  end

  def filter_by_key(key)
    @results = if key.blank?
                 []
               else
                 @results.where('lower(nick) like ?', "%#{key.downcase}%")
               end
  end
end