class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :requests_as_owner, source: :requests, foreign_key: :owner_id
  has_many :requests_as_sitter, source: :requests, foreign_key: :sitter_id
  has_many :sitter_accepted_animals

  has_one_attached :photo

  validates :first_name, :last_name, presence: true
end
