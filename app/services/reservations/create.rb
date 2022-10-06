module Reservations
  class Create < ApplicationService
    def initialize(user, book)
      @user = user
      @book = book
      @errors = []
    end

    def call
      return unless authorized?

      create_reservation
    end

    private

    attr_reader :user, :book, :errors

    def authorized?
      if user.nil?
        errors << { user: 'must be present' }
      else
        true
      end
    end

    def create_reservation
      book.reservations.create(user: user)
    end
  end
end
