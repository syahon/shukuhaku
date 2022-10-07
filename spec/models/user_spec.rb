require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { build(:user) }

  describe "valid" do
    context "全ての値が正常な場合" do
      it "データが有効であること" do
        expect(user).to be_valid
      end
    end

    context "user_nameが空の場合" do
      it "user_nameが無効であること" do
        user.user_name = " "
        expect(user).to_not be_valid
      end
    end

    context "mailが空の場合" do
      it "mailが無効であること" do
        user.mail = " "
        expect(user).to_not be_valid
      end
    end

    context "mailの値が既に使われている場合" do
      it "mailが無効であること" do
        user.save
        duplicate_user = user.dup
        expect(duplicate_user).to_not be_valid
      end
    end

    context "mailの値に@が含まれていない場合" do
      it "mailが無効であること" do
        user.mail = "user_example.com"
        expect(user).to_not be_valid
      end
    end

    context "mailの末尾が.の場合" do
      it "mailが無効であること" do
        user.mail = "user@example."
        expect(user).to_not be_valid
      end
    end

    context "mailのドメイン部分で.が連続している場合" do
      it "mailが無効であること" do
        user.mail = "user@example..com"
        expect(user).to_not be_valid
      end
    end

    context "mailの値に大文字が含まれていた場合" do
      it "小文字に変換して保存すること" do
        uppercase_mail = "USER@examplE.CoM"
        user.mail = uppercase_mail
        user.save
        expect(user.reload.mail).to eq uppercase_mail.downcase
      end
    end

    context "passwordの値が空の場合" do
      it "passwordが無効であること" do
        user.password = user.password_confirmation = " " * 8
        expect(user).to_not be_valid
      end
    end

    context "passwordの値が八文字以上の場合" do
      it "passwordが有効であること" do
        user.password = user.password_confirmation = "a" * 8
        expect(user).to be_valid
      end
    end

    context "passwordの値が七文字以下の場合" do
      it "passwordが有効であること" do
        user.password = user.password_confirmation = "a" * 7
        expect(user).to_not be_valid
      end
    end

  end

  # 複数のブラウザでログイン時に一方でログアウトし、もう一方ではブラウザを閉じて再度アクセスした場合を想定する
  describe "authenticated?" do
    context "remember_digestが空の場合" do
      it "falseを返すこと" do
        expect(user.authenticated?(" ")).to be_falsy
      end
    end
  end
end
