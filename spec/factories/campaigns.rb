FactoryGirl.define do
  factory :campaign do
    # This will enable us to pass a user object when creating a campaign object
    # through the factory. If you don't pass in a user, a user object will
    # automatically be created, for example:
    # If I do: FactoryGirl.create(:campaign)
    # it will create a user record, then a campaign record associated with that user
    # If I do: FactoryGirl.create(:campaign, user: User.first)
    # it will create only a campaign record associated with User.first
    association :user, factory: :user
    sequence(:title)        { |n| "#{Faker::Company.bs}-#{n}" }
    sequence(:description)  { Faker::Lorem.paragraph }
    sequence(:goal)         { 10 + rand(10000000) }
    sequence(:end_date)     { Time.now + 30.days }
  end
end
