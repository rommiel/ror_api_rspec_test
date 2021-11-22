FactoryBot.define do
  factory :user do
    username { "test" }
    password { "test1234" }

    # used if has a relationship to other table
    #company { association(:company) }
    
    # mix and match, can be added to different traits (for combination of different attributes)
    # trait :customer_role do
    #   role { "customer" }
    # end

    # used to override the main attributes of the main factory
    # factory :admin_user do
    #   role { "admin" }
    # end

    # factory :user_with_customer_role, trait: [:customer_role]
  end
end