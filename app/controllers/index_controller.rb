class IndexController < ApplicationController

	def index
	end 

    def dashboard
        if session.has_key?("cur_user")
            cur_user = session["cur_user"]         
            graph = Koala::Facebook::API.new(cur_user["fb_access_token"]) 
            friends_list = []
            friends = graph.get_connections("me", "friends")
            friends.each {|f| 
                friends_list << f["id"]
            } 
            while friends = friends.next_page do
                friends.each {|f| 
                    friends_list << f["id"]
                } 
            end
            @enslaved_friends = User
                .where('relationship_status LIKE ?', '%In a relationship%')
                .where(:fb_id => friends_list)
        else
            redirect_to '/'
        end
    end
end
