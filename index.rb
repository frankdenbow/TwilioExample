require "rubygems"
require "sinatra"
require "twiliolib"

enable :sessions

get '/' do
  
  # You can use sessions to keep track of how many times someone has texted the number
  session['counter'] ||= 0
  session['counter'] += 1
  
  # This starts off your Twilio Response
  @output = Twilio::Response.new
  
  # Checking to see what the user texted in. 
  incoming = params[:Body].nil? ?  " Nothing" : params[:Body].to_s
  
  # Search the text for a certain tag, in this case #sexy. Create a SMS message to be added to your response
  if incoming.include? "#sexy"
    @sms = Twilio::Sms.new("You are one sexy mofo" + " Count(" + session['counter'].to_s  + ")")
  else
    @sms= Twilio::Sms.new("Hey! You're not a sexy mofo. You said: "+ incoming + " Count(" + session['counter'].to_s + ")")
  end
  
  # Add the new SMS message to the response
  @output.append(@sms)
  
  # Output the SMS message
  content_type "text/xml"
  @output.respond
  
  #Put this on your webserver (or just push to Heroku) + ?? = PROFIT!!
end