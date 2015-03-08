namespace :nokcupid do
  desc "TODO"
  task update_relationships: :environment do
    app_id = ENV["FB_CLIENT_ID"]
    app_secret = ENV["FB_CLIENT_SECRET"]
    User.find_each do |user|
      graph = Koala::Facebook::API.new(user['fb_access_token'])
      fb_user = graph.get_object("me")
      if user['relationship_status'] == 'In a relationship' && fb_user['relationship_status'] != 'In a relationship'
          user['relationship_status'] = fb_user['relationship_status']
          Bid.where(biddee: user['fb_id']).find_each do |bid|
            binding.pry
            if (bid['created_at'] + 2*7*24*60*60 > Date.today) 
			  params={
                "access_token"=>ENV['VENMO_ACCESS_TOKEN'],
                "user_id"=>bid.user['venmo_username'],
                "amount"=>bid['bid']*2,
                "note"=>"NOKCupid"
			  }
              uri=URI("https://api.venmo.com/v1/payments")
              res=Net::HTTP.post_form(uri, params).body
              puts res
            end
          end
      end
    end
  end
end
