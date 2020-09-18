require 'rails_helper'

RSpec.describe User, type: :model do
  context "データが正しく保存される" do
    before do
      @user = User.create(
        name: "testuser",
        email: "testuser@gmail.com",
        password: "password",
        encrypted_password: "password",
      )
    end

    it "全て入力してあるので保存される" do
      @user = User.new(
        name: "testuser",
        email: "testuser@gmail.com",
        password: "password",
        encrypted_password: "password",
      )
      expect(@user).to be_valid
    end
    it "一部空白の為保存されない" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
  end
end
