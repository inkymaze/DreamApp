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

  describe 'associations'

  describe '::find_by_credentials' do
    before { user.save! }
    it 'should return user if credentials exists' do
      expect(User.find_by_credentials("someusername", "password")).to eq(user)
    end

    it 'should return nil if credentials does not exist' do
      expect(User.find_by_credentials("wrong_someusername", "wrong_password")).to be nil
    end
  end

  describe '#reset_session_token' do
    it 'reset the user session token' do
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(old_session_token)

    end
  end

  describe '#is_password?' do
    context 'if correct password' do
      it 'it returns true' do
        expect(user.is_password?("password")).to be true
      end
    end

    context 'if incorrect password'do
      it 'it returns false' do
        expect(user.is_password?("bad_password")).to be false
      end
    end
  end
end
