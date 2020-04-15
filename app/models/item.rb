class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :inventory
  validates_presence_of :image, optional: true

  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :inventory, greater_than: 0

  def self.active_items
    where(active?: true)
  end

  def self.most_popular(limit)
    joins(:item_orders)
    .group(:id)
    .order('SUM(item_orders.quantity)DESC')
    .limit(limit)
  end

  def self.least_popular(limit)
    joins(:item_orders)
    .group(:id)
    .order('SUM(item_orders.quantity)ASC')
    .limit(limit)
  end

  def quantity_ordered
    item_orders.sum(:quantity)
  end

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def update_status
    self.toggle!(:active?)
  end
end
