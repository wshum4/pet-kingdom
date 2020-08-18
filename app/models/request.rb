class Request < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :sitter, class_name: "User"

  validates :service, :start_date, :end_date, :price, :animal, presence: true
end
