require "rubygems"
require "sinatra"
require "twiliolib"

get '/' do
  @output = Twilio::Response.new
  
  incoming = params[:Body].nil? ?  " Nothing" : params[:Body].to_s
  @sms= Twilio::Sms.new("Hey! You just said: "+ incoming)
  
  @output.append(@sms)
  content_type "text/xml"
  @output.respond
end