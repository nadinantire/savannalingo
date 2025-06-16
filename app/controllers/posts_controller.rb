class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_post_owner, only: [:edit, :update, :destroy]

  # GET /posts or /posts.json
   def index
  @posts = current_user.posts.includes(:category, images_attachments: :blob)
  
  if params[:status].present?
    case params[:status]
    when 'published'
      @posts = @posts.where.not(published_at: nil)
    when 'draft'
      @posts = @posts.where(published_at: nil)
    end
  end

  @posts = @posts.order(created_at: :desc)
end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find_by(slug: params[:id]) || Post.find_by(id: params[:id])
    @recent_posts = Post.published.order(published_at: :desc).limit(5)
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end
   def new_content_block
    @post_content_block = PostContentBlock.new
    render partial: "post_content_block_fields", locals: { f: form_builder_stub }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by(slug: params[:id]) || Post.find_by(id: params[:id]) || not_found
    end

    def not_found
      raise ActiveRecord::RecordNotFound, "Post not found"
    end
    def ensure_blogger_role
    unless current_user&.user_role == 'blogger'
      redirect_to root_path, alert: 'Access denied. You must be a blogger to access this page.'
    end
  end

  def ensure_post_owner
    unless @post.user == current_user
      redirect_to posts_path, alert: 'You can only access your own posts.'
    end
  end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :status, :slug, :published_at, :user_id, :category_id, images: [],
      post_content_blocks_attributes: [:id, :content_type, :content, :image, :position, :_destroy])
    end
    def form_builder_stub
    # You can use a FormBuilder with nil object or similar
    # Or just render raw partial with form fields and string interpolation replaced
  end
end
