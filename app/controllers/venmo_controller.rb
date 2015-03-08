require 'net/http'

class VenmoController < ApplicationController

	
	def callback()
		client_id  = ENV["VENMO_CLIENT_ID"]
		client_secret = ENV["VENMO_CLIENT_SECRET"]
		
		uri = URI("https://api.venmo.com/v1/oauth/access_token")
        p = {
            "client_id" => client_id,
            "code" => params[:code],
            "client_secret" => client_secret
        }
		venmo_res = Net::HTTP.post_form(uri,p).body
	end


	def bid()
		if session.has_key?("cur_user")	
			cur_user=session["cur_user"]
			if cur_user.has_key?("venmo_access_token")		
				biddee=params[:biddee]
				amount=params[:amount]
				access_token=cur_user["venmo_access_token"]
				params={
					"access_token"=>access_token,
					"user_id"=>"kimberly-leon",
					"amount"=>amount
				}
				uri=URI("https://api.venmo.com/v1/payments")
				res=Net::HTTP.post_form(uri, params)
			else
				redirect_to "/venmo/login"
			end
		else
			redirect_to "/"
		end
	end
end
