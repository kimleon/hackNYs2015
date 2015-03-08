class User < ActiveRecord::Base
    has_many :bids
    validates_uniqueness_of :fb_id
end
