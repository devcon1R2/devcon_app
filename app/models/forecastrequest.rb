# == Schema Information
#
# Table name: forecastrequests
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  startdate  :datetime
#  enddate    :datetime
#  interval   :integer
#  data       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Forecastrequest < ActiveRecord::Base

  attr_accessible :email, :startdate, :enddate, :interval, :data
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  
  validates :email, :presence => true,
				    :format => { :with => email_regex } #,:uniqueness => { :case_sensitive => false }
            
  validates :startdate, :presence => true
  
  validates :enddate, :presence => true
           
  validates :interval, :presence => true
  
  validates :data, :presence => true
  
  
  def make_hash
    dataarray = self.data.split("\n")
    datahash = {}
    dataarray.each do |workload|
      wl = workload.split(',')
      datahash[wl[0]] = wl[1]
    end
    { :startdate  => self.startdate.to_s(:db),
      :enddate    => self.enddate.to_s(:db),
      :interval   => self.interval.to_s,
      :wlc        => datahash }
  end
 


 
  def getforecast(hash)
  puts "+++++++++++++++++++++++++"
    require "uri"
    require "net/http"
	require 'nokogiri'
	@input = "<?xml version=\"1.0\" encoding=\"utf-8\"?><ForecastRequest xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"PredictionEngine\" xmlns:version=\"1.0\">"
	#startdate:
	@input = @input + "<startdate>" + hash["startdate"] + "</startdate>"
	#enddate:
	@input = @input + "<enddate>" + hash["enddate"] + "</enddate>"
	#interval of historical- and forecast data:
	@input = @input + "<forecastinterval>" + hash["interval"].to_s + "</forecastinterval> <historicalinterval>" + hash["interval"].to_s + "</historicalinterval>"
    #workloadcollection:
	@input = @input + "<wlc>"
	if hash != nil
	  hash.each do |key, value|
	    if(key != "startdate" && key != "enddate" && key != "interval")
	      @input = @input + "<wl ts =\"" + key + "\">" + value + "</wl>"
		end
	  end
	  @input = @input + "</wlc> </ForecastRequest>"

	  url = URI.parse('http://testcloud.injixo.com/PredictionEngine/PredictionEngine.svc/')
      req = Net::HTTP::Post.new(url.path)
      req['Accept'] = "text/xml"
      req['Content-Type'] = "text/xml"
      req.body = @input
      #http = Net::HTTP.new(url.host, url.port)
	  #http.set_debug_output($stdout)
      #res = http.start #do |x|
  #      result= x.request(req)s
      #end
	  res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
      }
	  puts "OUTPUT"
      puts res.body
	  return res.body

    	#if hash != nil
	else
	  return nil
	end
  end 		#def



end
