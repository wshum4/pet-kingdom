class Request < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :sitter, class_name: "User"
  has_many :reviews

  validates :service, :start_date, :end_date, :animal, presence: true
  validates :service, acceptance: { accept: ['Grooming', 'Walking', 'Sitting', 'Cuddling'] }

  # def set_price
  #   if self.service == 'grooming'
  #     self.price = 65
  #   elsif self.service == 'walking'
  #     self.price = 30
  #   elsif self.service == 'sitting'
  #     self.price = 50
  #   elsif self.service == 'cuddling'
  #     self.price = 25
  #   end
  # end
end
