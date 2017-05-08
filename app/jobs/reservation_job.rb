class ReservationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    ###### SLACK ############################### http://stackoverflow.com/questions/30910950/slack-incoming-webhook-api
	parms = {
	    text: "You've got a booking test",  
	    username: "TestingBot", 
	    icon_emoji: ":raised_hands:"
	}

	uri = URI.parse(ENV['SLACK_ENDPOINT'])
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true

	request = Net::HTTP::Post.new(uri.request_uri)
	request.body = parms.to_json

	response = http.request(request)
	############################################

    puts "Performing Reservation Job Now"
    ReservationMailer.booking_email(*args).deliver_now

  end
end

