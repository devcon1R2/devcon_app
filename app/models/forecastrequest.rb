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
				    :format => { :with => email_regex },
            :uniqueness => { :case_sensitive => false }
            
  validates :startdate, :presence => true
  
  validates :enddate, :presence => true
           
  validates :interval, :presence => true
  
  validates :data, :presence => true
  
  def make_hash
    dataarray = self.data.split("\n")
    datahash = {}
    dataarray.each do |workload|
      wl = workload.split(',')
      date = DateTime.parse(wl[0])
      value = wl[1].to_f
      datahash[date] = value
    end
    { :startdate  => self.startdate,
      :enddate    => self.enddate,
      :interval   => self.interval,
      :wlc        => datahash }
  end
  
  def build(hash)
    #ContentType => "text/xml"
    #:input = 
	@input = "<?xml version=\"1.0\" encoding=\"utf-8\"?><ForecastRequest xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"PredictionEngine\" xmlns:version=\"1.0\">"
	#startdate:
	@input = @input + "<startdate>" + startdate + "</startdate>"
	#enddate:
	@input = @input + "<enddate>" + enddate + "</enddate>"
	#interval of historical- and forecast data:
	@input = @input + "<forecastinterval>" + interval + "</forecastinterval> <historicalinterval>" + interval + "</historicalinterval>"
    #workloadcollection:
	@input = @input + "<wlc>"
	if hash != nil
	  hash.each do |key, value|
	    if(key != "startdate" && key != "enddate" && key != "interval")
	      @input = @input + "<wl ts =\"" + key + "\">" + value + "</wl>"
		end
	  end
	
	  @input = @input + "</wlc> </ForecastRequest>"
	  x = Net::HTTP.post_form(URI.parse('http://testcloud.injixo.com/PredictionEngine/PredictionEngine.svc/'), @input)
      puts x.body
	end
#	base_uri 'http://testcloud.injixo.com/PredictionEngine/PredictionEngine.svc/'
#	options = { :query => {:status => text}}
#    self.class.post(input, options)
  end

end
