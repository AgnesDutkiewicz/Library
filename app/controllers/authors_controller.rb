class AuthorsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

  def new
    @author = Author.new
  end

  def create
    @author = Authors::AuthorCreator.call(author_params.to_h)
    if @author
      redirect_to @author, notice: 'Author successfully created!'
    else
      @author = Author.new
      render :new
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    Authors::AuthorEditor.call(@author, author_params.to_h)
    if @author
      redirect_to @author, notice: 'Author successfully updated!'
    else
      render :edit
    end
  end

  private

  def author_params
    params.require(:author).permit(:name, :birth_date)
  end
end
