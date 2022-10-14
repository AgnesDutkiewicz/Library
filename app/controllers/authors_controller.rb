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
    prepare_create_response(Authors::Create.new(author_params.to_h), 'Author successfully created!')
  end

  def edit
    @author = Author.find(params[:id])
    authorize @author
  end

  def update
    @author = Author.find(params[:id])
    authorize @author
    prepare_update_response(@author, Authors::Update.new(current_user, @author, author_params.to_h),
                            'Author successfully updated!')
  end

  def destroy
    @author = Author.find(params[:id])
    authorize @author
    @author.destroy
    redirect_to authors_url, alert: 'Author successfully deleted!'
  end

  private

  def author_params
    params.require(:author).permit(:name, :birth_date)
  end
end
