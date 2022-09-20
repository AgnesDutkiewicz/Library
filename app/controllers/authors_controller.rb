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
    contract = Authors::CreateContract.new
    result = contract.call(params)
    if result.success?
      @author = Author.new(author_params)
      if @author.save
        redirect_to @author, notice: 'Author successfully created!'
      else
        render :new
      end
    else
      puts result.errors.to_h
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
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
