FactoryGirl.define do
  factory :user do
    sequence(:first_name) { Faker::Name.first_name }
    sequence(:last_name)  { Faker::Name.last_name }
    # sequence(:email)      { |n| "#{n}-#{Faker::Internet.email}" }
    sequence(:email)      { "#{first_name.downcase}.#{last_name.downcase}@#{ Faker::Company.name.gsub(/\W+/,'').downcase}.com"}
    password              Faker::Internet.password
  end
end
