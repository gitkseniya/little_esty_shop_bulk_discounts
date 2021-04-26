class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  enum status: [:cancelled, "in progress", :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_discount
    invoice_items
    .joins(:discounts)
    .where('discounts.min_threshold <= invoice_items.quantity')
    .select('discounts.*, invoice_items.*, (invoice_items.quantity * invoice_items.unit_price * discounts.percent_off) AS total_discount')
    .order('total_discount desc')
    .distinct
  end

  def discounted_revenue
    discount = total_discount.uniq.sum(&:total_discount)
    (total_revenue - discount).to_f.round(2)
  end
end
