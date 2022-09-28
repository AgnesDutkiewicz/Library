module Publishers
  class PublisherEditor < ApplicationService
    def initialize(publisher, params)
      @publisher = publisher
      @params = params
    end

    def call
      contract = Publishers::UpdateContract.new
      result = contract.call(@params)
      update_publisher if result.success?
    end

    private

    def update_publisher
      @publisher.update(**@params)
    end
  end
end
