FactoryBot.define do
   factory :discount, class: Discount do
     percent_off { [0.20, 0.15, 0.10, 0.30].sample }
        min_threshold { [10, 15, 20].sample }
        merchant
   end
 end
