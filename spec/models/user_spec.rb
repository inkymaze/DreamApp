# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryGirl.build(:user, username: "someusername", password: "password") }

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do

  end

  describe '::find_by_credentials' do
    it 'should return user if credentials exists' do
      expect(User.find_by_credentials("someusername", "password")).to eq(user)
    end

    it 'should return nil if credentials does not exist' do
      expect(User.find_by_credentials("wrong_someusername", "wrong_password")).to be nil
    end 
  end

  describe '#reset_session_token' do

  end

  describe '#is_password?' do

  end

  describe '#password=' do

  end
end
