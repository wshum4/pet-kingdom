class Animal < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :requests
  has_one_attached :photo

  validates :name, :age, presence: true
end
