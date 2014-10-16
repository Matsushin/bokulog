require 'rails_helper'

RSpec.describe User, :type => :model do
  before(:all) do
    create(:user)
  end

  describe 'validation' do
    describe '#username' do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }
    end

    describe '#email' do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
    end

    describe '#encrypted_password' do
      it { should validate_presence_of(:encrypted_password) }
    end

    describe '#uid' do
      it { should validate_uniqueness_of(:uid) }
    end
  end

  describe 'find_or_create_by_oauth method' do
    context 'incorrect parameter case' do
      it 'user id should be nil' do
        auth = Auth.new('mixi')
        user = User.find_or_create_by_oauth(auth)
        expect(user.id.nil?).to eq true
      end
    end

    context 'user already exists' do
      it 'user should be not empty' do
        auth = Auth.new('twitter', 'uid1')
        user = User.find_or_create_by_oauth(auth)
        expect(user.username).to eq 'test1'
      end
    end

    context 'user does not exists' do
      it 'user should be not empty' do
        auth = Auth.new('twitter')
        auth.uid = 'test99'
        user = User.find_or_create_by_oauth(auth)
        expect(user.username).to eq 'twitter_nickname'
      end
    end
  end

  describe 'build_oauth_user method' do
    context 'incorrect parmeter case' do
      it 'username should be nil' do
        auth = Auth.new('mixi')
        user_data = User.build_oauth_user(auth)
        expect(user_data[:username].nil?).to eq true
      end
    end

    context 'twitter case' do
      it 'username should not be nil' do
        auth = Auth.new('twitter')
        user_data = User.build_oauth_user(auth)
        expect(user_data[:username]).to eq 'twitter_nickname'
      end
    end
  end

  describe 'create_unique_string method' do
    it {
      expect(User.create_unique_string).to be_an_instance_of(String)
    }
  end

  describe 'create_unique_email' do
    it {
      expect(User.create_unique_email).to a_collection_including('@')
    }
  end
end

class Auth
  attr_accessor :provider, :uid, :info
  def initialize(provider, uid = 1)
    @provider = provider
    @uid = uid
    @info = Info.new
  end
end

class Info
  attr_accessor :nickname, :image
  def initialize
    @nickname = 'twitter_nickname'
    @image = 'twitter_image'
  end
end