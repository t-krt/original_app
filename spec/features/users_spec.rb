require 'rails_helper'

RSpec.feature "Users", type: :feature do
  given(:user) { FactoryBot.build(:user) }
  let(:sample_user) { FactoryBot.create(:sample_user) }

  # scenario "user creates a new account" do
  #   visit root_path
  #   click_link "新規登録"
  #   expect {
  #     fill_in 'user_nickname', with: user.nickname
  #     fill_in 'user_email', with: user.email
  #     fill_in 'user_password', with: user.password
  #     fill_in 'user_password_confirmation', with: user.password
  #     click_on('登録する')
  #   }.to change(User, :count).by(1)
  #   expect(page).to have_content "アカウント登録が完了しました。"
  # end

  scenario "user can edit nickname" do
    sign_in_as(sample_user)
    click_on('ユーザー情報編集')
    fill_in 'user_nickname', with: "update_name"
    fill_in 'user_current_password', with: sample_user.password
    click_on "更新"
    expect(page).to have_content "アカウント情報を変更しました。"
  end
end
