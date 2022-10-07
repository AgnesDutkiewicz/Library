require 'pundit/rspec'

describe UserPolicy do
  subject { described_class }
  let!(:user) { create :user, admin: false }
  let!(:current_user) { create :user, name: 'current_user', admin: false }
  let!(:current_user_admin) { create :user, name: 'current_user_admin', admin: true }

  permissions :index? do
    it 'denies access if user is not signed in' do
      expect(subject).not_to permit
    end

    it 'grants access if user is not an admin' do
      expect(subject).to permit(current_user)
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(current_user_admin)
    end
  end

  permissions :show?, :update?, :edit?, :destroy? do
    it 'denies access if user is not signed in' do
      expect(subject).not_to permit(nil)
    end

    it 'denies access if user is not an admin, and updates/destroys another user account' do
      expect(subject).not_to permit(current_user, user)
    end

    it 'grants access if user is not an admin, and updates/destroys his user account' do
      expect(subject).to permit(current_user, current_user)
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(current_user_admin, user)
    end
  end

  permissions :create?, :new? do
    it 'grants access if user is not signed in' do
      expect(subject).to permit
    end

    it 'grants access if user is not an admin' do
      expect(subject).to permit(current_user)
    end

    it 'grants access if user is an admin' do
      expect(subject).to permit(current_user_admin)
    end
  end
end
