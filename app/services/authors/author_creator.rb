module Authors
  class AuthorCreator < ApplicationService
    def initialize(name:, birth_date:)
      @name = name
      @birth_date = birth_date
    end

    def call
      create_author
    end

    private

    def create_author
      @author = Author.create!(name: @name, birth_date: @birth_date)
    end
  end
end
