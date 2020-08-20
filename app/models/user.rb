class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :requests_as_owner, class_name: "Request", source: :requests, foreign_key: :owner_id
  has_many :requests_as_sitter, class_name: "Request", source: :requests, foreign_key: :sitter_id
  has_many :sitter_accepted_animals
  has_many :reviews, through: :requests_as_sitter

  validates :first_name, :last_name, :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
