class PublishersController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @publishers = Publisher.all
  end

  def show
    @publisher = Publisher.find(params[:id])
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publishers::PublisherCreator.call(publisher_params.to_h)
    if @publisher
      redirect_to @publisher, notice: 'Publisher successfully created!'
    else
      @publisher = Publisher.new
      render :new
    end
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def update
    @publisher = Publisher.find(params[:id])
    Publishers::PublisherEditor.call(@publisher, publisher_params.to_h)
    if @publisher
      redirect_to @publisher, notice: 'Publisher successfully updated!'
    else
      render :edit
    end
  end

  private

  def publisher_params
    params.require(:publisher).permit(:name, :origin)
  end
end
