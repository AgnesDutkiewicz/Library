module Reservations
  class Create < ApplicationService
    def initialize(user, book)
      @user = user
      @book = book
      @errors = []
    end

    def call
      create_reservation
    end

    private

    attr_reader :user, :book, :errors

    def create_reservation
      book.reservations.create(user: user)
    end
  end
end
