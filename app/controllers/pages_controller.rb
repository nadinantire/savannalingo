# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def home
  end

  def about
  end

  def stories
    # Get all published posts with their categories and users
    @posts = Post.includes(:category, :user)
                 .where(status: 1)  # Use integer value for published
                 .order(published_at: :desc)

    # Get recent posts for sidebar (limit to 3)
    @recent_posts = Post.includes(:category, :user)
                        .where(status: 1)  # Use integer value for published
                        .order(published_at: :desc)
                        .limit(3)

    # Get recent books for sidebar (limit to 4)
    @recent_books = Book.includes(:user)
                    .where(status: Book.statuses[:published])
                    .order(created_at: :desc)
                    .limit(4)

    # Get all categories with post counts
    @categories = Category.joins(:posts)
                          .where(posts: { status: 1 })  # Use integer value
                          .group('categories.id, categories.name')
                          .select('categories.*, COUNT(posts.id) as posts_count')
                          .order(:name)

    # Get total posts count for "All" category
    @total_posts = Post.where(status: 1).count
  end
end