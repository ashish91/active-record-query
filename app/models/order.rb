class Order < ApplicationRecord
  belongs_to :customer
  has_and_belongs_to_many :books, join_table: 'books_orders'

  enum status: {
    being_packed: 0,
    shipped: 1,
    complete: 2,
    cancelled: 3
  }

  scope :created_before, ->(time) { where(created_at: ...time) }
  before_save :set_subtotal, :set_total

  def set_subtotal
    self.subtotal = books.map(&:price).sum
  end

  def set_total
    book_price = books.map(&:price).sum
    price_with_tax = ((100 + tax)*book_price)/100
    self.total = price_with_tax + shipping
  end
end
