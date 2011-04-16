require "rubygems"
require "sinatra"
require "twiliolib"

get '/' do
  @output = Twilio::Response.new
  
  incoming = params[:Body]
  @sms= Twilio::Sms.new("Hey! You just said: "+ incoming)
end