class AuthorsController < ApplicationController
  def index
    @authors = Author.all
    authorize @authors
  end

  def show
    @author = Author.find(params[:id])
    authorize @author
    @books = @author.books
  end

  def new
    @author = Author.new
    authorize @author
  end

  def create
    @author = Author.new
    authorize @author
    service_object = Authors::Create.new(current_user, author_params.to_h)
    result = service_object.call
    if service_object.success?
      @author = result
      redirect_to @author, notice: 'Author successfully created!'
    else
      service_object.error_messages
      render :new
    end
  end

  def edit
    @author = Author.find(params[:id])
    authorize @author
  end

  def update
    @author = Author.find(params[:id])
    authorize @author
    service_object = Authors::Update.new(current_user, @author, author_params.to_h)
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
