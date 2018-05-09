# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint(8)        not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#

class CatRentalRequest < ApplicationRecord
  STATUSES = %w(PENDING APPROVED DENIED)
  validates :cat_id, :start_date, :end_date, presence:true
  validates :status, inclusion: {in: STATUSES}

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat


  def overlapping_requests
    cat
      .rental_requests
      .where(status = 'APPROVED')
      .where(start_date >= self.end_date)
      .where(end_date <= self.start_date)
  end

end
