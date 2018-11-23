class ListPosts < ActiveInteraction::Base
  def execute
    top_post = Post.joins(:votes).group(:post_id, :id).select('posts.id, count(post_id) as count').order('count asc').last

    top_post = if !top_post.nil?
                 Post.find(top_post.id)
               else
                 Post.last
               end

    posts = Post.where.not(id: top_post)

    return top_post, posts
  end
end