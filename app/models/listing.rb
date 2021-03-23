class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  
  validates :address, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true


  
  def is_available?(start_date, end_date)
    day_one = start_date.to_date
    day_two = end_date.to_date
    reservations.each do |reservation|
      if day_one < reservation.checkin && day_two > reservation.checkin
        return false
      elsif day_one < reservation.checkout && day_two > reservation.checkout
        return false
      elsif reservation.checkin < day_one && reservation.checkout > day_one
        return false
      elsif reservation.checkin < day_two && reservation.checkout > day_two
        return false
      end
    end
    return true
  end

end
