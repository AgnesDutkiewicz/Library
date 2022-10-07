class PublishersController < ApplicationController
  def index
    @publishers = Publisher.all
    authorize @publishers
  end

  def show
    @publisher = Publisher.find(params[:id])
    authorize @publisher
  end

  def new
    @publisher = Publisher.new
    authorize @publisher
  end

  def create
    @publisher = Publisher.new
    authorize @publisher
    service_object = Publishers::Create.new(current_user, publisher_params.to_h)
    result = service_object.call
    if service_object.success?
      @publisher = result
      redirect_to @publisher, notice: 'Publisher successfully created!'
    else
      service_object.error_messages
      render :new
    end
  end

  def edit
    @publisher = Publisher.find(params[:id])
    authorize @publisher
  end

  def update
    @publisher = Publisher.find(params[:id])
    authorize @publisher
    service_object = Publishers::Update.new(current_user, @publisher, publisher_params.to_h)
    service_object.call
    if service_object.success?
      redirect_to @publisher, notice: 'Publisher successfully updated!'
    else
      service_object.error_messages
      render :edit
    end
  end

  private

  def publisher_params
    params.require(:publisher).permit(:name, :origin)
  end
end
