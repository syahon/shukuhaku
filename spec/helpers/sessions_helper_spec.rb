require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let!(:user) { create(:user, :main) }

  describe "current_user" do
    context "セッションがnilの場合" do
      it "正しいユーザーを返すこと" do
        remember(user)
        expect(current_user).to eq user
      end
    end

    context "クッキーのremember_tokenとdbのremember_digestの値が一致しない場合" do
      it "current_userがnilを返すこと" do
        remember(user)
        user.update_attribute(:remember_digest, User.digest(User.new_token))
        expect(current_user).to eq nil
      end
    end
  end
end
