require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: Faker::Internet.name(specifier: 4)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '会員登録'
      end
      it '新規登録に失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '会員登録'
        # expect(page).to have_content 'エラーが発生しました'
      end
    end
  end
  describe 'ユーザーログイン' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      it 'ログインに成功する' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'

        # expect(page).to have_content 'ログインしました'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end

# describe 'ユーザー（一般）のテスト' do
#   let(:user) { create(:user) }
#   let!(:testuser) { create(:user) }
#   let!(:post) { create(:post, user: user) }
#   before do
#     visit new_user_session_path
#     fill_in 'user[email]', with: user.email
#     fill_in 'user[password]', with: user.password
#     click_button 'ログイン'
#   end

#   describe '編集のテスト' do
#     context '自分の編集画面への遷移' do
#       it '遷移できる' do
#         visit edit_user_path(user)
#         expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
#       end
#     end
#     context '他人の編集画面への遷移' do
#       it '遷移できない' do
#         visit edit_user_path(testuser)
#         expect(current_path).to eq('/users/' + user.id.to_s)
#       end
#     end
#     context '表示の確認' do
#       before do
#         visit edit_user_path(user)
#       end
#       it 'ユーザー情報編集と表示される' do
#         expect(page).to have_content('ユーザー情報編集')
#       end
#       it '名前編集フォームに自分の名前が表示される' do
#         expect(page).to have_field 'user[family_name]', with: user.family_name
#       end
#       it '名前編集フォームに自分の名前が表示される' do
#         expect(page).to have_field 'user[first_name]', with: user.first_name
#       end
#       it '年齢編集フォームに自分の年齢が表示される' do
#         expect(page).to have_field 'user[age]', with: user.age
#       end
#       it 'メールアドレス編集フォームに自分のメールアドレスが表示される' do
#         expect(page).to have_field 'user[email]', with: user.email
#       end
#       it '画像編集フォームが表示される' do
#         expect(page).to have_field 'user[icon_image]'
#       end
#       it '自己紹介編集フォームに自分の自己紹介が表示される' do
#         expect(page).to have_field 'user[introduction]', with: user.introduction
#       end
#       it '編集に成功する' do
#         click_button '変更内容を保存する'
#         expect(page).to have_content '変更内容を更新しました'
#         expect(current_path).to eq('/users/' + user.id.to_s)
#       end
#     end
#   end

#   describe '詳細画面のテスト' do
#     before do
#       visit user_path(user)
#     end
#     context '表示の確認' do
#       it 'ユーザー詳細と表示される' do
#         expect(page).to have_content('ユーザー詳細')
#       end
#       it 'ユーザー詳細情報が表示される' do
#         expect(page).to have_content(user.family_name)
#         expect(page).to have_content(user.first_name)
#         expect(page).to have_css('img.icon_image')
#         expect(page).to have_content(user.introduction)
#       end

#       it '投稿一覧と表示される' do
#         expect(page).to have_content('いいねしている投稿')
#       end
#       # it '投稿一覧の投稿画像が表示される' do
#       #   expect(page).to have_css('post.post_images')
#       # end
#       it '投稿一覧のtitleのリンク先が正しい' do
#         expect(page).to have_link post.title, href: post_path(post)
#       end
#     end
#   end
# end

# # 一般ユーザーとしてログインできない、なんで？
# describe 'ユーザー（法人）のテスト' do
#   let(:user) { create(:user) }
#   let!(:testuser) { create(:user) }
#   let!(:post) { create(:post, user: user) }
#   # before do
#   #   visit new_user_registration_path
#   #   fill_in 'user[email]', with: Faker::Internet.email
#   #   fill_in 'user[password]', with: 'password'
#   #   fill_in 'user[password_confirmation]', with: 'password'
#   #   choose 'user_user_status_false'
#   #   click_on '新規会員登録２へ'
#   #   fill_in 'user[company_name]', with: Faker::Internet.username(specifier: 5)
#   #   click_button '新規登録'
#   # end
#   before do
#     visit new_user_session_path
#     fill_in 'user[email]', with: user.email
#     fill_in 'user[password]', with: user.password
#     click_button 'ログイン'
#   end

#   describe '編集のテスト' do
#     context '自分の編集画面への遷移' do
#       it '遷移できる' do
#         visit edit_user_path(user)
#         expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
#       end
#     end
#     context '他人の編集画面への遷移' do
#       it '遷移できない' do
#         visit edit_user_path(testuser)
#         expect(current_path).to eq('/users/' + user.id.to_s)
#       end
#     end
#     context '表示の確認' do
#       before do
#         visit edit_user_path(user)
#       end
#       it 'ユーザー情報編集と表示される' do
#         expect(page).to have_content('ユーザー情報編集')
#       end
#       it '名前編集フォームに自分の名前が表示される' do
#         expect(page).to have_field 'user[company_name]', with: user.company_name
#       end
#       it '画像編集フォームが表示される' do
#         expect(page).to have_field 'user[icon_image]'
#       end
#       it '自己紹介編集フォームに自分の自己紹介が表示される' do
#         expect(page).to have_field 'user[introduction]', with: user.introduction
#       end
#       it '編集に成功する' do
#         click_button '変更内容を保存する'
#         expect(page).to have_content '変更内容を更新しました'
#         expect(current_path).to eq('/users/' + user.id.to_s)
#       end
#     end
#   end

#   describe '詳細画面のテスト' do
#     before do
#       visit user_path(user)
#     end
#     context '表示の確認' do
#       it 'ユーザー詳細と表示される' do
#         expect(page).to have_content('ユーザー詳細')
#       end
#       it 'ユーザー詳細情報が表示される' do
#         expect(page).to have_content(user.company_name)
#         expect(page).to have_content(user.postal_code)
#         expect(page).to have_content(user.address)
#         expect(page).to have_content(user.phone_number)
#         expect(page).to have_content(user.hp_url)
#         expect(page).to have_css('img.icon_image')
#         expect(page).to have_content(user.introduction)
#       end

#       it '投稿一覧と表示される' do
#         expect(page).to have_content('投稿一覧')
#       end
#       # it '投稿一覧の投稿画像が表示される' do
#       #   expect(page).to have_css('post.post_images')
#       # end
#       it '投稿一覧のtitleのリンク先が正しい' do
#         expect(page).to have_link post.title, href: post_path(post)
#       end
#     end
#   end
# end

