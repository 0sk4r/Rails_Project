class NotificationWorker
  include Sidekiq::Worker
  # queue_as :default

  def perform(author_id, post_id)
    post = Post.find(post_id)
    author = Author.find(author_id)
    NotificationMailer.notify(author.email, post).deliver
  end
end
