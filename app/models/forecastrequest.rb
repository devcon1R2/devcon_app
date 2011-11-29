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

  attr_accessible :email, :startdate, :enddate, :interval, :data, :result
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  
  validates :email, :presence => true,
				    :format => { :with => email_regex } #,:uniqueness => { :case_sensitive => false }
            
  validates :startdate, :presence => true
  
  validates :enddate, :presence => true
           
  validates :interval, :presence => true
  
  validates :data, :presence => true
  
  
  def make_hash
    mydata = self.data
	mydata.gsub!("\r","")
	mydata.gsub!("\t",",")
	dataarray = mydata.split("\n")
    datahash = {}
    dataarray.each do |workload|
      wl = workload.split(',')
      datahash[wl[0]] = wl[1]
    end
    { :startdate  => self.startdate.strftime("%Y-%m-%dT%H:%M:%SZ"),
      :enddate    => self.enddate.strftime("%Y-%m-%dT%H:%M:%SZ"),
      :interval   => self.interval.to_s,
      :wlc        => datahash }
  end
 
  

  def computeforecast
    res = getforecast
    if res == nil
      self.result = "Invalid input!"
    #elsif res == Net::HTTPSuccess
	  #hash = Forecastrequest.xml_to_hash(res.body)
      #self.result = hash #Forecastrequest.hash_to_csv(hash)
	else
      self.result = Forecastrequest.ownxmlparser(res.body)
    #  self.result += res.body
    end
  end
 

  def getforecast
    hash = make_hash
	if hash != nil
	  url = URI.parse('http://testcloud.injixo.com/PredictionEngine/PredictionEngine.svc/')
      req = Net::HTTP::Post.new(url.path)
      req['Accept'] = "text/xml"
      req['Content-Type'] = "text/xml"
	  req.body = self.inputcreator(hash)
	  res = Net::HTTP.start(url.host, url.port) { |http|
      http.request(req)
      }
	  #puts "OUTPUT"
      #puts res.body
	  return res
	end
	return nil
  end 		#def

  #As the xml parser seems to have problems, own xml parser is used as a workaround
  def  self.ownxmlparser(xmlstr)
    if xmlstr.index("<wlc")
	  return xmlstr.slice(xmlstr.index("<wlc")+5,xmlstr.length).gsub('</wlc></Forecast>',"").gsub('<wl ts="',"").gsub('">',"\t").gsub('</wl>',"\n")
    else  
	  return xmlstr
	end#if  
  end#def
  

  def self.xml_to_hash(xml)
    hash ={} 
    doc = Nokogiri::XML(xml)
    doc.xpath('//wl').each do |wl|
      hash["#{wl.attribute('ts')}"] = "#{wl.content}"
    end
    return hash
  end

  def self.hash_to_csv(hash)
    csv = ""
    hash.each do |key, value| 
      csv << "#{key},#{value}\n"
    end
    return csv
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
#	  if(key != :startdate && key != :enddate && key != :interval)
	    @input = @input + "<wl ts =\"" + key + "\">" + value + "</wl>"
#	  end
	end
	@input = @input + "</wlc> </ForecastRequest>"
	return @input
  end	

end
