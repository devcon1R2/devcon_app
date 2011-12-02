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
require "uri"
require "net/http"
require 'nokogiri'

class Forecastrequest < ActiveRecord::Base

  PE_URL = 'http://testcloud.injixo.com/PredictionEngine/PredictionEngine.svc/'

  attr_accessible :email, :startdate, :enddate, :interval, :data, :result
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  
  validates :email, :presence => true,
				    :format => { :with => email_regex } #,:uniqueness => { :case_sensitive => false }
            
  validates :startdate, :presence => true
  
  validates :enddate, :presence => true
           
  validates :interval, :presence => true
  
  validates :data, :presence => true
  
  
  def make_hash
    return nil if !(self.data) 
	mydata = self.data.gsub("\r","").gsub("\t",",")
	dataarray = mydata.split("\n")
    datahash = {}
    dataarray.each do |workload|
      wl = workload.split(',')
      datahash[wl[0]] = wl[1]
    end
    return { :startdate  => self.startdate.strftime("%Y-%m-%dT%H:%M:%SZ"),
             :enddate    => self.enddate.strftime("%Y-%m-%dT%H:%M:%SZ"),
             :interval   => self.interval.to_s,
             :wlc        => datahash }
  end
 
  

  def computeforecast
    res = getforecast
    if res == nil
      self.result = "Invalid input!"
#    elsif res == Net::HTTPSuccess
	else
	  self.result = Forecastrequest.hash_to_csv(Forecastrequest.xml_to_hash(res.body))
     # self.result += res.body if !self.result
    end
  end
 

  def getforecast
    hash = make_hash
	if hash != nil
	  url = URI.parse(PE_URL)
      request = Net::HTTP::Post.new(url.path)
      request['Accept'] = "text/xml"
      request['Content-Type'] = "text/xml"
	  request.body = self.inputcreator(hash)
	  res = Net::HTTP.start(url.host, url.port) { |http|
      http.request(request)
      }
	  #puts "OUTPUT"
      #puts res.body
	  return res
	end
	return nil
  end 		#def

  

  def self.xml_to_hash(xml)
    return nil if !xml
	hash ={} 
    doc = Nokogiri::XML(xml)
    doc.remove_namespaces!
	doc.xpath('//wl').each do |wl|
      hash["#{wl.attribute('ts')}"] = "#{wl.content}"
    end
    return hash
  end

  def self.hash_to_csv(hash)
    return nil if !hash
	csv = ""

    hash.keys.sort{|x,y| x <=> y}.each do |key| 
      csv << "#{key},#{hash[key]}\n"
    end
    return csv
  end
  
  
  def getDailyValues(csv)
    return [] unless self && csv
	timeframe = ((self.enddate - self.startdate) / 86400).to_i
	timeframe = 100 if timeframe > 100
	daily = Array.new(timeframe)
	csv.split("\n").each {|l|
	  ks,v = l.split(",")
	  k = Time.zone.parse(ks)
	  d = ((k - self.startdate) / 86400).to_i
	  if d <= timeframe
	    daily[d] = !daily[d] ? v.to_i : daily[d] + v.to_i
	  end
	}
	
    return daily

  end


  def inputcreator(hash)
    @input = "<?xml version=\"1.0\" encoding=\"utf-8\"?><ForecastRequest xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"PredictionEngine\" xmlns:version=\"1.0\">"
    #startdate
	@input = @input + "<startdate>" + hash[:startdate] + "</startdate>"
	#enddate:
	@input = @input + "<enddate>" + hash[:enddate] + "</enddate>"
	#interval of historical- and forecast data:
	@input = @input + "<forecastinterval>" + hash[:interval].to_s + "</forecastinterval> <historicalinterval>" + hash[:interval].to_s + "</historicalinterval>"
    #workloadcollection:
	@input = @input + "<wlc>"
	
	hash[:wlc].each do |key, value|
      @input = @input + "<wl ts =\"" + key + "\">" + value + "</wl>"
	end
	@input = @input + "</wlc> </ForecastRequest>"
	return @input
  end	

end
