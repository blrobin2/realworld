FactoryBot.define do
  factory :jwt_deny_list do
    jti { 'MyString' }
    exp { '2022-11-22 14:16:55' }
  end
end
