FactoryBot.define do
  factory :user do #factory :testuser, class: User do のようにクラスを明示するとモデル名以外のデータも作成できる
    name { "test" }
    email { Faker::Internet.email }
    password { "testuser" }
  end
end
