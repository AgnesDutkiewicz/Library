require 'pundit/rspec'

describe AuthorPolicy do
  subject { described_class }
  let!(:user) { create :user, admin: false }
  let!(:admin) { create :user, admin: true }


  permissions :index?, :show? do
    it 'grants access if user is not signed in' do
      expect(subject).to permit
    end

    it 'grants access if user is not an admin' do
      expect(subject).to permit(user)
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin)
    end
  end

  permissions :create?, :new?, :update?, :edit?, :destroy? do
    it 'denies access if user is not signed in' do
      expect(subject).not_to permit
    end

    it 'denies access if user is not an admin' do
      expect(subject).not_to permit(user)
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(admin)
    end
  end
end
