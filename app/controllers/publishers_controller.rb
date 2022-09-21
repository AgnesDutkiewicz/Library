class PublishersController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  # before_action :require_admin, except: [:index, :show]

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
    contract = Publishers::UpdateContract.new
    result = contract.call(publisher_params.to_h)
    if result.success?
      if @publisher = PublisherCreator.call(name: publisher_params[:name], origin: publisher_params[:origin])
        redirect_to @publisher, notice: 'Publisher successfully created!'
      else
        render :new
      end
    else
      puts result.errors.to_h
    end
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def update
    contract = Publishers::UpdateContract.new
    result = contract.call(publisher_params.to_h)
    if result.success?
      @publisher = Publisher.find(params[:id])
      if @publisher.update(publisher_params)
        redirect_to @publisher, notice: 'Publisher successfully updated!'
      else
        render :edit
      end
    else
      puts result.errors.to_h
    end
  end

  private

  def publisher_params
    params.require(:publisher).permit(:name, :origin)
  end
end
