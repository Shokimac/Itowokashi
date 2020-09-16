require 'rails_helper'

describe "エピソード" do
    let(:user) { create(:user) }

    before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
    end

    describe "エピソード投稿" do
        let!(:episode) { create(:episode, user: user) }
        before do
            visit new_episode_path
        end

        context "投稿画面の表示確認" do
            it '「エピソード投稿」と表示される' do
                expect(page).to have_content('エピソード投稿') 
            end

            it 'ラベルに「タイトル」と表示される' do
                expect(page).to have_content('タイトル') 
            end

            it 'タイトル入力フォームが表示される' do
                expect(page).to have_field 'episode[title]' 
            end

            it 'ラベルに「内容」と表示される' do
                expect(page).to have_content('内容')
            end

            it '内容入力フォームが表示される' do
                expect(page).to have_field 'episode[body]'
            end

            it '投稿ボタンが表示される' do
                expect(page).to have_button '投稿する' 
            end
        end

        context "投稿テスト" do
            it '投稿に成功する' do
                fill_in "episode[title]",	with: episode.title 
                fill_in "episode[body]",	with: episode.body
                click_button '投稿する'
                expect(page).to have_content('エピソードを投稿しました')
            end

            it 'フォームが空白のままだと投稿に失敗する' do
                fill_in "episode[title]",	with: ""
                fill_in "episode[body]",	with: ""
                click_button '投稿する'
                expect(page).to have_content("can't be blank")
            end
        end
    end
    
    describe "投稿編集" do
        let!(:user2) { create(:user) }
        let!(:episode) { create(:episode, user: user) }
        let!(:episode2) { create(:episode, user: user2) }

        context "編集画面へのアクセス" do
            it '自分が投稿したエピソードの編集画面にアクセスできる' do
                visit edit_episode_path(episode)
                expect(page).to have_content('エピソード編集') 
            end

            it '他人が投稿したエピソードの編集画面にはアクセスできない' do
                visit edit_episode_path(episode2)
                expect(current_path).to eq user_path(user)
            end
        end

        context "編集画面の表示確認" do
            before do
                visit edit_episode_path(episode)
            end

            it '「エピソード編集」と表示されている' do
                expect(page).to have_content('エピソード編集') 
            end

            it 'ラベルに「タイトル」と表示されている' do
                expect(page).to have_content('タイトル') 
            end

            it 'フォームにタイトルが入っている' do
                expect(page).to have_field 'episode[title]', with: episode.title 
            end

            it 'ラベルに「内容」と表示されている' do
                expect(page).to have_content('内容')
            end

            it 'フォームに内容が入っている' do
                expect(page).to have_field 'episode[body]', with: episode.body 
            end

            it '更新ボタンが表示されている' do
                expect(page).to have_button '更新する' 
            end
        end

        context "編集テスト" do
            before do
                visit edit_episode_path(episode)
            end

            it '編集が成功する' do
                fill_in "episode[title]",	with: episode.title 
                fill_in "episode[body]",	with: episode.body
                click_button '更新する'
                expect(current_path).to eq episode_path(episode) 
            end

            it 'フォーム空白で編集が失敗する' do
                fill_in "episode[title]",	with: ""
                fill_in "episode[body]",	with: ""
                click_button '更新する'
                expect(page).to have_content("can't be blank") 
            end
        end
    end

    describe "エピソード詳細" do
        let!(:user2) { create(:user) }
        let!(:episode) { create(:episode, user: user) }
        let!(:episode2) { create(:episode, user: user2) }

        context "編集＆削除ボタンの表示" do
            it '自分の投稿へアクセス時、ボタンが表示される' do
                visit episode_path(episode)
                expect(page).to have_link '編集する' 
                expect(page).to have_link '削除する' 
            end

            it '他人の投稿へアクセス時、ボタンが表示されない' do
                visit episode_path(episode2)
                expect(page).to have_no_link '編集する'
                expect(page).to have_no_link '削除する'
            end
        end

        context "詳細画面の表示確認" do
            before do
                visit episode_path(episode)
            end

            it '「エピソード詳細」と表示されている' do
                expect(page).to have_content('エピソード詳細') 
            end

            it '投稿者のユーザー名が表示されている' do
                expect(page).to have_content user.name
            end

            
        end

    end
    
end
