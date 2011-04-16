require "rubygems"
require "sinatra"
require "twiliolib"

enable :sessions

get '/' do
  session['counter'] ||= 0
  session['counter'] += 1
  
  @output = Twilio::Response.new
  
  incoming = params[:Body].nil? ?  " Nothing" : params[:Body].to_s
  
  if incoming.include? "#sexy"
    @sms = Twilio::Sms.new("You are one sexy mofo" + "Count(" + session['counter']+ ")")
  else
    @sms= Twilio::Sms.new("Hey! You're not a sexy mofo. You said: "+ incoming + "Count(" + session['counter']+ ")")
  end
  
  @output.append(@sms)
  content_type "text/xml"
  @output.respond
end