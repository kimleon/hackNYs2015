require 'net/http'
require 'json'

class VenmoController < ApplicationController
    skip_before_filter :verify_authenticity_token, :only => :bid

	
	def callback()
		client_id  = ENV["VENMO_CLIENT_ID"]
		client_secret = ENV["VENMO_CLIENT_SECRET"]
		
		uri = URI("https://api.venmo.com/v1/oauth/access_token")
        p = {
            "client_id" => client_id,
            "code" => params[:code],
            "client_secret" => client_secret
        }
		venmo_res = JSON.parse(Net::HTTP.post_form(uri,p).body)
        binding.pry
		if session.has_key?("cur_user")	
			cur_user=session["cur_user"]
            begin
                cur_user = User.find_by! fb_id: cur_user['fb_id']
                cur_user.update_attributes(
                    venmo_access_token: venmo_res['access_token'],
                    venmo_username: venmo_res['user']['id']
                )
                cur_user.save()
                session['cur_user'] = cur_user;
                redirect_to '/dashboard'
            rescue
                redirect_to '/'
            end
        else
            redirect_to '/'
        end
	end


	def bid()
		if session.has_key?("cur_user")	
			cur_user=session["cur_user"]
            begin
                cur_user = User.find_by! fb_id: cur_user['fb_id']
            rescue
                if !cur_user
                    redirect_to '/'        
                end
            end
			if cur_user['venmo_access_token']
				biddee=params[:biddee]
				amount=params[:amount]
				access_token=cur_user["venmo_access_token"]
				params={
					"access_token"=>access_token,
					"phone"=>"16265521989",
					"amount"=>amount,
                    "note"=>"NOKCupid"
				}
				uri=URI("https://api.venmo.com/v1/payments")
				res=Net::HTTP.post_form(uri, params).body
                bid = cur_user.bids.create(
                    bid: amount,
                    time_limit: 2,
                    biddee: biddee,
                    bidder: cur_user['fb_id']
                )
                binding.pry
			else
				redirect_to "https://api.venmo.com/v1/oauth/authorize?client_id=2429&scope=make_payments%20access_profile%20access_email%20access_balance&response_type=code"
			end
		else
			redirect_to "/"
		end
	end
end
