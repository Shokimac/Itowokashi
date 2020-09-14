require 'rails_helper'

describe 'ユーザー認証のテスト' do
    describe 'ユーザー新規登録' do
        before do
            visit new_user_registration_path
        end
        context '新規登録画面に遷移' do
            it '新規登録に成功する' do
                fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
                fill_in 'user[email]', with: Faker::Internet.email
                fill_in 'user[password]', with: 'password'
                fill_in 'user[password_confirmation]', with: 'password'
                click_botton '登録'

                expect(page).to have_content 'successfully'
            end
            it '新規登録に失敗する' do
                fill_in 'user[name]', with: ''
                fill_in 'user[email]', with:''
                fill_in 'user[password]', with:''
                fill_in 'user[password_confirmation]', with:''
                click_button '登録'

                expect(page).to have_content 'error'
            end
        end
    end
end