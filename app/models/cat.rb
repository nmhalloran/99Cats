# == Schema Information
#
# Table name: cats
#
#  id          :bigint(8)        not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#

class Cat < ApplicationRecord

  COLORS = %w(brown black grey white orange blond)
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: {in: COLORS, message: "Color needs to be #{COLORS.join(", ")}"}
  validates :sex, inclusion: {in: %w(m f), message: "Must be male or female"}

  def age
    Time.now.year - self.birth_date.year
  end

  has_many :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat,
    dependent: :destroy

end
