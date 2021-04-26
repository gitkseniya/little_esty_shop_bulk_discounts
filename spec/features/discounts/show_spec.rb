require 'rails_helper'

RSpec.describe 'discounts index page', type: :feature do
  before :each do
    @merchant1 = create(:merchant)

    @discount1 = create(:discount, merchant: @merchant1)
  end

  it 'can show a discount record with its attributes' do
    visit  merchant_discount_path(@merchant1, @discount1)

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@discount1.percent_off)
    expect(page).to have_content(@discount1.min_threshold)

    expect(page).to have_button("Back to All Discounts")

    click_link "Back to All Discounts"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts")
  end
end
