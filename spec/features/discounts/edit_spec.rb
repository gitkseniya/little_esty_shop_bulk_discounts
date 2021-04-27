require 'rails_helper'

RSpec.describe 'merchant discount edit page' do
  it 'allows to update discount info' do
    merchant1 = create(:merchant)

    discount1 = create(:discount, merchant: merchant1)
    discount2 = create(:discount, merchant: merchant1)

    visit merchant_discount_path(merchant1, discount2)

    expect(page).to have_content(merchant1.name)
    expect(page).to have_content(discount2.percent_off)
    expect(page).to have_content(discount2.min_threshold)

    expect(page).to have_link("Edit Discount")

    click_on "Edit Discount"

    expect(page).to have_current_path(edit_merchant_discount_path(merchant1, discount2))

    expect(find('form')).to have_content("Percent off")
    expect(find('form')).to have_content("Min threshold")

    fill_in 'Percent off', with: '0.40'
    fill_in 'Min threshold', with: '40'

    click_button "Save"

    expect(page).to have_current_path(merchant_discount_path(merchant1, discount2))

    expect(page).to have_content(0.40)
    expect(page).to have_content(40)
  end
end
