class Request < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :sitter, class_name: "User"
  belongs_to :animal
  has_many :reviews, dependent: :destroy

  validates :service, :start_date, :end_date, :animal_id, presence: true
  validates :service, acceptance: { accept: ['Grooming', 'Walking', 'Sitting', 'Cuddling'] }

  def set_price
    if self.service == 'Grooming'
      self.price = 65
    elsif self.service == 'Walking'
      self.price = 30
    elsif self.service == 'Sitting'
      self.price = 50
    elsif self.service == 'Cuddling'
      self.price = 25
    end
  end
end
