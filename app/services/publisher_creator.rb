class PublisherCreator < ApplicationService
  def initialize(name:, origin:)
    @name = name
    @origin = origin
  end

  def call
    create_publisher
  end

  private

  def create_publisher
    @publisher = Publisher.create!(name: @name, origin: @origin)
  end
end
