class NotificationWorker
  include Sidekiq::Worker
  # queue_as :default

  def perform(args)
    author_id = args["author_id"]
    post_id = args["post_id"]
    post = Post.find(post_id)
    author = Author.find(author_id)
    NotificationMailer.notify(author.email, post).deliver
    # Do something
  end
end
