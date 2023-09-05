class Programmation < ApplicationRecord
  belongs_to :post

  validate :open_at_future_date
  validates :close_at, presence: true

  def open_at_future_date
    if open_at.present? && open_at <= Date.today
      errors.add(:open_at, "doit être une date future")
    end
  end

end
