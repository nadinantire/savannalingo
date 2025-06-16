class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
  if current_user&.publisher?
    @books = Book.includes(:user, :category_book)
                 .where("status = ? OR (status = ? AND user_id = ?)",
                        Book.statuses[:published], Book.statuses[:pending], current_user.id)
                 .order(created_at: :desc)
  else
    @books = Book.includes(:user, :category_book)
                 .where(status: Book.statuses[:published])  # <= make sure this is integer value (1)
                 .order(created_at: :desc)
  end

  @recent_books = Book.where(status: "published").order(created_at: :desc).limit(4)
  @recent_posts = Post.where(status: "published").order(published_at: :desc).limit(4)
end

  # GET /books/1 or /books/1.json
  def show
  @book = Book.find(params[:id])

  if @book.rejected?
    redirect_to books_path, alert: "This book has been removed."
  elsif @book.pending? && @book.user != current_user
    redirect_to books_path, alert: "This book is not published yet."
  elsif @book.published?
    if @book.not_yet_paid? && (!current_user || !current_user.publisher?)
      redirect_to books_path, alert: "Please complete payment to access this book by calling this number +250789171755 ."
    end
  end
end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)
     @book.user = current_user

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_path, status: :see_other, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :writer, :description, :price, :user_id, :category_book_id, :pdf, :image,)
    end
end
