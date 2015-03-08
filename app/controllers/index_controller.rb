class IndexController < ApplicationController

	def index
	end 

    def dashboard
        if session.has_key?("cur_user")
            cur_user = session["cur_user"]         
            graph = Koala::Facebook::API.new(cur_user["fb_access_token"]) 
            @friends = graph.get_connections("me", "friends")
        else
            redirect_to '/'
        end
    end
end
