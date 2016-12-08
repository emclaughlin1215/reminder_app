class Task < ApplicationRecord
  belongs_to :user
  validates :title, presence: true,
                    length: { minimum: 2 }
end
