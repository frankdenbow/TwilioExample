require "rubygems"
require "sinatra"
require "twiliolib"

get '/' do
  @output = Twilio::Response.new
  
  incoming = params[:Body].nil? ?  " Nothing" : params[:Body].to_s
  
  if incoming.include? "#sexy"
    @sms = Twilio::Sms.new("You are one sexy mofo")
  else
    @sms= Twilio::Sms.new("Hey! You're not a sexy mofo. You said: "+ incoming)
  end
  
  @output.append(@sms)
  content_type "text/xml"
  @output.respond
end