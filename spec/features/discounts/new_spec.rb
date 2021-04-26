require 'rails_helper'

describe 'merchant discount new' do
  before :each do
    @merchant1 = create(:merchant)
  end

  it 'should be able to fill in a form and create a new merchant' do
    visit "/merchant/#{@merchant1.id}/discounts"

    click_link 'Create a new discount'

    expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts/new")

    expect(find('form')).to have_content('Percent off')
    expect(find('form')).to have_content('Min threshold')

    fill_in 'Percent off', with: '0.50'
    fill_in 'Min threshold', with: '20'

    click_button 'Submit'

    expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts")

    expect(page).to have_content(0.5)
    expect(page).to have_content(20)
  end
end
