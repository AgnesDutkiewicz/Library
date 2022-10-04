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
    service_object = Publishers::Create.new(current_user, publisher_params.to_h)
    result = service_object.call
    if service_object.success?
      @publisher = result
      redirect_to @publisher, notice: 'Publisher successfully created!'
    else
      service_object.error_messages
      @publisher = Publisher.new
      render :new
    end
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def update
    @publisher = Publisher.find(params[:id])
    service_object = Publishers::Edit.new(current_user, @publisher, publisher_params.to_h)
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
