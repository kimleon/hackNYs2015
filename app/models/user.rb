class User < ActiveRecord::Base
    validates_uniqueness_of :fb_id
end
