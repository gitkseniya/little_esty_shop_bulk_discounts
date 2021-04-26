require 'rails_helper'

RSpec.describe 'discounts index page', type: :feature do
  before :each do
    @merchant1 = create(:merchant)

    @discount1 = create(:discount, merchant: @merchant1, percent_off: 0.77, min_threshold: 77)
    @discount2 = create(:discount, merchant: @merchant1)
    @discount3 = create(:discount, merchant: @merchant1)
  end

  it 'can delete a discount record' do
    visit  merchant_discounts_path(@merchant1)

    expect(page).to have_content(@merchant1.name)

    within "#discount-#{@discount1.id}" do

    expect(page).to have_content(@discount1.percent_off)
    expect(page).to have_content(@discount1.min_threshold)

    expect(page).to have_button("Delete")

    click_button "Delete"

    expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts")
  end

    expect(page).not_to have_content(@discount1.percent_off)
    expect(page).not_to have_content(@discount1.min_threshold)
  end
end
