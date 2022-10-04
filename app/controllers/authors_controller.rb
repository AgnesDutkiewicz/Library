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
    service_object = Authors::Create.new(current_user, author_params.to_h)
    result = service_object.call
    if service_object.success?
      @author = result
      redirect_to @author, notice: 'Author successfully created!'
    else
      service_object.error_messages
      @author = Author.new
      render :new
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    service_object = Authors::Edit.new(current_user, @author, author_params.to_h)
    service_object.call
    if service_object.success?
      redirect_to @author, notice: 'Author successfully updated!'
    else
      service_object.error_messages
      render :edit
    end
  end

  private

  def author_params
    params.require(:author).permit(:name, :birth_date)
  end
end
