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
    prepare_create_response('Publisher', Publishers::Create.new(publisher_params.to_h),
                            'Publisher successfully created!')
  end

  def edit
    @publisher = Publisher.find(params[:id])
    authorize @publisher
  end

  def update
    @publisher = Publisher.find(params[:id])
    authorize @publisher
    prepare_update_response(@publisher, Publishers::Update.new(current_user, @publisher, publisher_params.to_h),
                            'Publisher successfully updated!')
  end

  def destroy
    @publisher = Publisher.find(params[:id])
    authorize @publisher
    @publisher.destroy
    redirect_to publishers_url, alert: 'Publisher successfully deleted!'
  end

  private

  def publisher_params
    params.require(:publisher).permit(:name, :origin)
  end
end
