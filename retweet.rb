require "rubygems"
require "twitter"

class RetweetBot
	#Twitter configuration
	client = Twitter::REST::Client.new do |config|
  		config.consumer_key        = "YOUR_CONSUMER_KEY"
  		config.consumer_secret     = "YOUR_CONSUMER_SECRET"
  		config.access_token        = "YOUR_ACCESS_TOKEN"
  		config.access_token_secret = "YOUR_ACCESS_TOKEN_SECRET"
	end
	
	#Retweet tweets with this topic
	topic = "#RETWEET_TOPIC"

	#Get all my followers
	my_followers = client.follower_ids
	
	#Iterate over all my followers
	my_followers.each do |follower_id|
		#Check the timeline for my follower
		client.user_timeline(follower_id, result_type: "recent").each do |tweet|
			#If a tweet includes #nairuby - retweet it
			if tweet.text.include? topic
				client.retweet(tweet.id)
			end
		end
	end
end

#Initilize my retweet bot
my_retweet_bot = RetweetBot.new
