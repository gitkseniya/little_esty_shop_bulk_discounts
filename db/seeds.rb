20.times do
  FactoryBot.create(:discount, merchant_id: (1..100).to_a.sample)
end
