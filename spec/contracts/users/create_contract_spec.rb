require 'rails_helper'
require 'dry-validation'

describe Users::CreateContract do
  subject(:create_object) { Users::CreateContract.new }

  context '#name' do
    it {
      expect(create_object.call({ email: 'agnes@example.com', password_digest: 'dadadas', admin: false,
                                  name: '' }).success?).to eq false
    }
    it {
      expect(create_object.call({ email: 'agnes@example.com', password_digest: 'dadadas', admin: false,
                                  name: nil }).success?).to eq false
    }
    it {
      expect(create_object.call({ email: 'agnes@example.com', password_digest: 'dadadas',
                                  admin: false }).success?).to eq false
    }
    it {
      expect(create_object.call({ email: 'agnes@example.com', password_digest: 'dadadas', admin: false,
                                  name: 777 }).success?).to eq false
    }
    it {
      expect(create_object.call({ email: 'agnes@example.com', password_digest: 'dadadas', admin: false,
                                  name: Time.now }).success?).to eq false
    }
    it {
      expect(create_object.call({ email: 'agnes@example.com', password_digest: 'dadadas', admin: false,
                                  name: [] }).success?).to eq false
    }
    it {
      expect(create_object.call({ email: 'agnes@example.com', password_digest: 'dadadas', admin: false,
                                  name: ['Luiza'] }).success?).to eq false
    }
    it {
      expect(create_object.call({ email: 'agnes@example.com', password_digest: 'dadadas', admin: false,
                                  name: 'Luiza' }).success?).to eq true
    }
  end

  context '#email' do
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: '' }).success?).to eq false
    }
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: nil }).success?).to eq false
    }
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: 777 }).success?).to eq false
    }
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: Time.now }).success?).to eq false
    }
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: [] }).success?).to eq false
    }
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: ['agnes@example.com'] }).success?).to eq false
    }
    it { expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza' }).success?).to eq false }
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: '@example.com' }).success?).to eq false
    }
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: 'agnesexample.com' }).success?).to eq false
    }
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: 'agnes@.com' }).success?).to eq false
    }
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: 'agnes@examplecom' }).success?).to eq false
    }
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: 'agnes@example.' }).success?).to eq false
    }
    it {
      expect(create_object.call({ password_digest: 'dadadas', admin: false, name: 'Luiza',
                                  email: 'agnes@example.com' }).success?).to eq true
    }
  end

  context '#password_digest' do
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', admin: false,
                                  password_digest: '' }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', admin: false,
                                  password_digest: nil }).success?).to eq false
    }
    it { expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', admin: false }).success?).to eq false }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', admin: false,
                                  password_digest: 777 }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', admin: false,
                                  password_digest: Time.now }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', admin: false,
                                  password_digest: [] }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', admin: false,
                                  password_digest: ['Luiza'] }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', admin: false,
                                  password_digest: 'dadadas' }).success?).to eq true
    }
  end

  context '#admin' do
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', password_digest: 'dadadas',
                                  admin: '' }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', password_digest: 'dadadas',
                                  admin: nil }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com',
                                  password_digest: 'dadadas' }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', password_digest: 'dadadas',
                                  admin: 777 }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', password_digest: 'dadadas',
                                  admin: Time.now }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', password_digest: 'dadadas',
                                  admin: [] }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', password_digest: 'dadadas',
                                  admin: ['Luiza'] }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', password_digest: 'dadadas',
                                  admin: true }).success?).to eq false
    }
    it {
      expect(create_object.call({ name: 'Luiza', email: 'agnes@example.com', password_digest: 'dadadas',
                                  admin: false }).success?).to eq true
    }
  end
end
