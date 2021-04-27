require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_one(:merchant).through(:item) }
    it { should have_many(:discounts).through(:merchant) }
  end

  describe "methods" do
    it "can return incomplete invoices" do
      time1 = Time.new(2008,6,21, 13,30,0, "+09:00").utc
      time2 = Time.new(2006,6,21, 13,30,0, "+09:00").utc
      time3 = Time.new(2015,6,21, 13,30,0, "+09:00").utc

      invoice1 = create(:invoice, created_at: time1)
      invoice2 = create(:invoice, created_at: time2)
      invoice3 = create(:invoice, created_at: time3)

      item1 = create(:item)
      item2 = create(:item)

      invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1, status: 0)
      invoice_item2 = create(:invoice_item, invoice: invoice2, item: item1, status: 1)
      invoice_item3 = create(:invoice_item, invoice: invoice3, item: item2, status: 2)

      expect(InvoiceItem.incomplete_invoices).to eq([invoice2, invoice1])
    end

    it "determines whether a discount has been applied to an invoice item" do
      @merchant1 = create(:merchant)

      @cupcake = create(:item, merchant: @merchant1)
      @cake = create(:item, merchant: @merchant1)

      @discount1 = create(:discount, merchant: @merchant1, percent_off: 10, min_threshold: 5)
      @discount2 = create(:discount, merchant: @merchant1, percent_off: 15, min_threshold: 10)
      @discount3 = create(:discount, merchant: @merchant1, percent_off: 20, min_threshold: 15)

      @klaudia = create(:customer)
      @olivia = create(:customer)

      @invoice1 = create(:invoice, customer: @klaudia)
      @invoice2 = create(:invoice, customer: @olivia)

      @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @cupcake, quantity: 11, unit_price: 6)
      @invoice_item2 = create(:invoice_item, invoice: @invoice2, item: @cake, quantity: 1, unit_price: 28)

      expect(@invoice_item1.link_conditional).not_to eq(nil)
      expect(@invoice_item2.link_conditional).to eq(nil)
    end
  end
end
