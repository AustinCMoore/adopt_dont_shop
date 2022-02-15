class PetApplication < ApplicationRecord
  enum status: [:pending, :rejected, :approved]
  belongs_to :pet
  belongs_to :application
end
