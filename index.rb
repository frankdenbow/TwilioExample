require "rubygems"
require "sinatra"
require "twiliolib"

post '/' do
  @output = Twilio::Response.new
  
  incoming = params[:Body].nil? ? params[:Body] : " Nothing"
  @sms= Twilio::Sms.new("Hey! You just said: "+ incoming)
  
  @output.append(@sms)
  content_type "text/xml"
  @output.respond
end