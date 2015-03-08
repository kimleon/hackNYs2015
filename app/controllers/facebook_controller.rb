require 'net/http'

class FacebookController < ApplicationController
	def callback()
		@app_id = ENV["FB_CLIENT_ID"]
		@app_secret = ENV["FB_CLIENT_SECRET"]
		
		uri = URI("https://graph.facebook.com/oauth/access_token?client_id=#{@app_id}&redirect_uri=http://localhost:3000/facebook/callback&client_secret=#{@app_secret}&code=#{params[:code]}")
		res = Net::HTTP.get_response(uri).body
		access_token = res.split("=")[1].gsub("&expires","")

		uri_long_lived = URI("https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=#{@app_id}&client_secret=#{@app_secret}&fb_exchange_token=#{access_token}")
		res_long_lived = Net::HTTP.get_response(uri_long_lived).body
		long_lived_access_token = res.split("=")[1].gsub("&expires","")

        graph = Koala::Facebook::API.new(long_lived_access_token)
        fb_user = graph.get_object("me")

        cur_user = User.new()
        cur_user.update_attributes!(fb_id: fb_user["id"], fb_access_token: long_lived_access_token, relationship_status: fb_user["relationship_status"])
        session["cur_user"] = cur_user
        redirect_to '/dashboard'
	end

    def search()
        if session.has_key?("cur_user")
            cur_user = session["cur_user"]
            graph = Koala::Facebook::API.new(cur_user["fb_access_token"]) 
            search_query = params[:search]
            friends = @graph.get_connections("me", "friends")
            friends.each {|f| do_something_with_item(f) } # it's a subclass of Array
            while next_feed = feed.next_page do
                friends.each {|f| do_something_with_item(f) } # it's a subclass of Array
            end
        else
            redirect_to '/'
        end
    end
end
