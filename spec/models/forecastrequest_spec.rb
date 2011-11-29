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
  
  it "should reject duplicate email addresses" do
    # Put a Forecastrequest with given email address into the database.
    Forecastrequest.create!(@attr)
    Forecastrequest_with_duplicate_email = Forecastrequest.new(@attr)
    Forecastrequest_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    Forecastrequest.create!(@attr.merge(:email => upcased_email))
    Forecastrequest_with_duplicate_email = Forecastrequest.new(@attr)
    Forecastrequest_with_duplicate_email.should_not be_valid
  end
	
  it "should reject invalid data" do
    #to be implemented 
  end
  
  describe "conversion of data to hash" do
  
    it "should be correct" do
      fcr = Forecastrequest.new(@attr)
      hash = { :startdate => DateTime.new(2001, 3, 3, 0, 0, 0),
               :enddate => DateTime.new(2003, 3, 3, 0, 0, 0),
               :interval => 15,
               :wlc => { DateTime.parse('2011-3-4') => 5.0, 
                         DateTime.parse('2011-3-5') => 6.0, 
                         DateTime.parse('2011-3-6') => 6.0, }
             }
      fcr.make_hash.should == hash    
    end
  end
	
end
