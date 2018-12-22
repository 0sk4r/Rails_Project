class PostsProvider
  attr_reader :results

  def initialize(key)
    @results = Post.all
    filter_by_key(key)
  end

  def filter_by_key(key)
    @results = if key.blank?
                 []
               else
                 @results.where('lower(title) like ?', "%#{key.downcase}%")
               end
  end
end
