require 'dry/monads'

class AuthorsController < ApplicationController
  include Dry::Monads[:result]

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
    # prepare_create_response(Authors::Create.new(author_params.to_h), 'Author successfully created!')

    result = Authors::Create.new(author_params.to_h).call

    case result
    when Success
      redirect_to Author.last, notice: 'Author successfully created!'
    when Failure
      flash.now[:error] = render_error_message(result.failure)
      render :new
    else
      flash.now[:error] = "Oops! Author couldn't be created."
    end
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

  def render_error_message(result)
    result.flatten.map { |k, v| ("#{k} #{v}") }.join(' ')
  end

  def author_params
    params.require(:author).permit(:name, :birth_date)
  end
end
