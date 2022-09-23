module Publishers
  class PublisherCreator < ApplicationService
    def initialize(params)
      @name = params[:name]
      @origin = params[:origin]
    end

    def call
      execute
    end

    private

    def execute
      contract = Publishers::UpdateContract.new
      result = contract.call(name: @name, origin: @origin)
      create_publisher if result.success?
    end

    def create_publisher
      if @publisher = Publisher.create!(name: @name, origin: @origin)
        @publisher
      else
        render :new
      end
    end
  end
end
