RSpec.describe AuthorsController, type: :request do
  context 'when user is signed in' do
    describe '#index' do
      subject(:view_authors) { get '/authors' }

      let!(:author1) { create :author }
      let!(:author2) { create :author, name: 'Frank', birth_date: '01-01-2020' }

      it 'render index template' do
        view_authors

        expect(response).to render_template(:index)
      end

      it 'returns 200 status code' do
        view_authors

        expect(response.code).to eq('200')
      end

      it 'returns both authors' do
        view_authors

        expect(response.body).to include(author1.name, author2.name)
      end
    end

    describe '#show' do
      subject(:view_authors) { get '/authors/1' }

      let!(:author1) { create :author }
      let!(:author2) { create :author, name: 'Frank', birth_date: '01-01-2020' }

      it 'render show template' do
        view_authors

        expect(response).to render_template(:show)
      end

      it 'returns 200 status code' do
        view_authors

        expect(response.code).to eq('200')
      end

      it 'returns one author' do
        view_authors

        expect(response.body).to include(author1.name)
      end
    end

    # describe '#create' do
    #   it "creates an author and redirects to the author's page" do
    #     get '/authors/new'
    #     expect(response).to render_template(:new)
    #
    #     post '/authors', :params => { :author => { :name => 'Frank', :birth_date => '01-01-2020' } }
    #
    #     expect(response).to redirect_to(assigns(:author))
    #     follow_redirect!
    #     expect(response).to render_template(:show)
    #     expect(response.body).to include("Author successfully created!")
    #   end
    # end
  end
end
