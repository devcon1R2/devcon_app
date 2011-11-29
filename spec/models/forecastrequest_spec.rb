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

require 'spec_helper'

describe Forecastrequest do
  
  
  before(:each) do
    @attr = { :email => "Forecastrequest@example.com",
              :startdate => DateTime.new(2001, 3, 3, 0, 0, 0),
              :enddate => DateTime.new(2003, 3, 3, 0, 0, 0),
              :interval => 15,
              :data => "2011-3-4,5\n2011-3-5,6\n2011-3-6,6"
	  }
  end
 
  it "should create a new instance given valid attributes" do
    Forecastrequest.create!(@attr)
  end
  
  it "should require an email address" do
    no_email_Forecastrequest = Forecastrequest.new(@attr.merge(:email => ""))
    no_email_Forecastrequest.should_not be_valid
  end
  
  it "should require a startdate" do
    no_startdate_Forecastrequest = Forecastrequest.new(@attr.merge(:startdate => ""))
    no_startdate_Forecastrequest.should_not be_valid
  end
  
  it "should require an enddate" do
    no_enddate_Forecastrequest = Forecastrequest.new(@attr.merge(:enddate => ""))
    no_enddate_Forecastrequest.should_not be_valid
  end
  
  it "should require an interval" do
    no_interval_Forecastrequest = Forecastrequest.new(@attr.merge(:interval => ""))
    no_interval_Forecastrequest.should_not be_valid
  end
  
  it "should have data" do
    no_data_Forecastrequest = Forecastrequest.new(@attr.merge(:data => ""))
    no_data_Forecastrequest.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[Forecastrequest@foo.com THE_Forecastrequest@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_Forecastrequest = Forecastrequest.new(@attr.merge(:email => address))
      valid_email_Forecastrequest.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[Forecastrequest@foo,com Forecastrequest_at_foo.org example.Forecastrequest@foo.]
    addresses.each do |address|
      invalid_email_Forecastrequest = Forecastrequest.new(@attr.merge(:email => address))
      invalid_email_Forecastrequest.should_not be_valid
    end	  
  end

	
  it "should reject invalid data" do
    #to be implemented 
  end
  
  describe "conversion" do
  
    it "should convert data->hash correctly" do
      fcr = Forecastrequest.new(@attr)
      hash = { :startdate => DateTime.new(2001, 3, 3, 0, 0, 0).to_s(:db),
               :enddate => DateTime.new(2003, 3, 3, 0, 0, 0).to_s(:db),
               :interval => "15",
               :wlc => { '2011-3-4' => "5", 
                         '2011-3-5' => "6", 
                         '2011-3-6' => "6", }
             }
      fcr.make_hash.should == hash    
    end

    it "should convert xml->hash correctly" do
        hash = Forecastrequest.xml_to_hash('<wlc><wl ts="date1">55</wl><wl ts="date2">56</wl></wlc>')
        hash.should == { "date1" => "55","date2" => "56" }
    end

    
    it "should convert hash->csv correctly" do
        hash = { "date1" => "55","date2" => "56" }
        csv = Forecastrequest.hash_to_csv(hash)
        csv.should == "date1,55\ndate2,56\n"
    end
    
  end

 
  describe "test REST-interface" do
    
    it "should not accept empty inputs" do
	  fcr = Forecastrequest.new		 
      fcr = Forecastrequest.new
	  fcr.getforecast((nil)).should == "Input is empty"
	end
	  
  
    it "should get a positive response" do
	  #hash = {:interval => 1440, :startdate => "2012-01-01T00:00:00Z", :enddate => "2012-01-03T00:00:00Z", :2011-12-01T00:00:00Z => "10", :2011-12-02T00:00:00Z => "10", :2011-12-03T00:00:00Z => "10", :2011-12-04T00:00:00Z => "10", :2011-12-05T00:00:00Z => "10", :2011-12-06T00:00:00Z => "10", :2011-12-07T00:00:00Z => "10", :2011-12-08T00:00:00Z => "10"}
	  hash = { :startdate => DateTime.new(2012, 1, 1, 0, 0, 0).to_s(:db),
               :enddate => DateTime.new(2012, 1, 3, 0, 0, 0).to_s(:db),
               :interval => "15",
               :wlc => { '2011-12-01' => "5", 
                         '2011-12-02' => "6", 
                         '2011-12-03' => "6", 
						 '2011-12-04' => "6", 
						 '2011-12-05' => "6", 
						 '2011-12-06' => "6", 
						 '2011-12-07' => "6", 
						 '2011-12-08' => "6", 
						 '2011-12-09' => "6", 
						 '2011-12-10' => "6", 
						 }
             }
	  fcr = Forecastrequest.new		 
      fcr.make_hash.should == hash    
	  fcr = Forecastrequest.new(@attr)
	  
	end
  end

  
end
