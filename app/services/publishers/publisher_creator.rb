module Publishers
  class PublisherCreator < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      contract = Publishers::UpdateContract.new
      result = contract.call(@params)
      create_publisher if result.success?
    end

    private

    def create_publisher
      Publisher.create(**@params)
    end
  end
end
