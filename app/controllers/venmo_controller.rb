require 'net/http'

class VenmoController < ApplicationController

	
	def callback()
		client_id  = ENV["VENMO_CLIENT_ID"]
		client_secret = ENV["VENMO_CLIENT_SECRET"]
		
		uri = URI("https://api.venmo.com/v1/oauth/access_token?client_id=#{client_id}&code=#{params[:code]}&client_secret=#{client_secret}")
		venmo_res = Net::HTTP.get_response(uri).body
		# access_token = @venmo_res.split("=")[1]

		binding.pry

		# uri_long_lived = URI("https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=#{@app_id}&client_secret=#{@app_secret}&fb_exchange_token=#{access_token}")
		# @res_long_lived = Net::HTTP.get_response(uri_long_lived).body
		# long_lived_access_token = @res.split("=")[1].gsub("&expires","")
		
		# binding.pry
	

	end
end