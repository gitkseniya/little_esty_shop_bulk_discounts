require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end

  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions}
    it { should have_many :invoice_items}
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:discounts).through(:merchants) }
  end

  describe "instance methods" do
    before :each do
      @merchant1 = create(:merchant)

      @cupcake = create(:item, merchant: @merchant1)
      @canoli = create(:item, merchant: @merchant1)
      @cake = create(:item, merchant: @merchant1)

      @discount1 = create(:discount, merchant: @merchant1, percent_off: 0.10, min_threshold: 5)
      @discount2 = create(:discount, merchant: @merchant1, percent_off: 0.15, min_threshold: 10)
      @discount3 = create(:discount, merchant: @merchant1, percent_off: 0.20, min_threshold: 15)

      @klaudia = create(:customer)
      @olivia = create(:customer)

      @invoice1 = create(:invoice, customer: @klaudia)
      @invoice2 = create(:invoice, customer: @olivia)

      @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @cupcake, quantity: 11, unit_price: 6)
      @invoice_item2 = create(:invoice_item, invoice: @invoice1, item: @canoli, quantity: 18, unit_price: 4)
      @invoice_item3 = create(:invoice_item, invoice: @invoice2, item: @cake, quantity: 1, unit_price: 28)
    end

    it "can calculate total_revenue" do
      expect(@invoice1.total_revenue).to eq(138)
      expect(@invoice2.total_revenue).to eq(28)
    end

    it 'total_discount' do
      expect(@invoice1.discounted_revenue).to eq(113.70)
      expect(@invoice2.discounted_revenue).to eq(28.00)
    end
  end
end
