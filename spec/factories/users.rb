FactoryBot.define do
  factory :user do #factory :testuser, class: User do のようにクラスを明示するとモデル名以外のデータも作成できる
    name { "test" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testuser" }
  end
end
