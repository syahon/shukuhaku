require 'rails_helper'

RSpec.describe "Reservations", type: :system do
  let!(:user) { create(:user, :main) }
  let!(:room) { create(:room, :main) }
  let!(:reservation) { build(:reservation) }

  def reservation_new
    user_login
    visit room_path(room)
    fill_in "開始日", with: reservation.start_date
    fill_in "終了日", with: reservation.end_date
    fill_in "人数", with: reservation.sum_people
    click_on "確認画面に進む"
  end

  describe "ルームの予約" do
    context "無効な値を送信した場合" do
      it "予約に失敗すること" do
        user_login
        visit room_path(room)

        next_date = Date.new.next_day

        fill_in "開始日", with: next_date
        fill_in "終了日", with: next_date
        fill_in "人数", with: 2

        click_on "確認画面に進む"

        within ".error-container" do
          expect(page).to have_content "日帰りでの予約はできません"
        end
      end
    end

    context "有効な値を送信した場合" do
      it "予約に成功すること" do
        reservations = Reservation.all
        expect(reservations.count).to eq 0

        reservation_new

        expect(current_path).to eq new_reservation_path
        expect(page).to have_field "開始日", with: reservation.start_date
        expect(page).to have_field "終了日", with: reservation.end_date
        expect(page).to have_field "人数", with: reservation.sum_people

        click_on "予約を確定する"

        expect(current_path).to eq reservations_path
        expect(reservations.count).to eq 1
        expect(page).to have_content "予約しました"
      end
    end

    context "確認画面でルーム詳細に戻るボタンを押した場合" do
      it "ルーム詳細ページに戻ること"do
        reservation_new

        click_on "ルーム詳細に戻る"

        expect(page).to have_css ".reservation-field"
        expect(page).to have_css ".room-image"
      end
    end
  end
end
