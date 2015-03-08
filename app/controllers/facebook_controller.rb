require 'net/http'

class FacebookController < ApplicationController

	
	def callback()
		@app_id = ENV["FB_CLIENT_ID"]
		@app_secret = ENV["FB_CLIENT_SECRET"]
		
		uri = URI("https://graph.facebook.com/oauth/access_token?client_id=#{@app_id}&redirect_uri=http://localhost:3000/facebook/callback&client_secret=#{@app_secret}&code=#{params[:code]}")
		@res = Net::HTTP.get_response(uri).body
		access_token = @res.split("=")[1].gsub("&expires","")

		uri_long_lived = URI("https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=#{@app_id}&client_secret=#{@app_secret}&fb_exchange_token=#{access_token}")
		@res_long_lived = Net::HTTP.get_response(uri_long_lived).body
		long_lived_access_token = @res.split("=")[1].gsub("&expires","")
		
		binding.pry
	

	end
end