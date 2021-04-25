FactoryBot.define do
   factory :discount, class: Discount do
     percent_off { Faker::Number.decimal(l_digits: 2) }
        min_threshold { [10, 15, 20].sample }
        status { ["active", "inactive"].sample }
        merchant
   end
 end
