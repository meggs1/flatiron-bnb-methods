class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(start_date, end_date)
    openings = []
    self.listings.each do |listing|
     if listing.is_available?(start_date, end_date)
        openings << listing
      end
    end
    openings
  end

  def self.highest_ratio_res_to_listings
    
  end

  def self.most_res

  end

  def total_reservations
    self.listings.sum{|listing| listing.reservations.count}
  end

end

