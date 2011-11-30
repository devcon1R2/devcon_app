require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
      response.should have_selector("h1", :content => "DevCon App - Home")
  end
  
  
  it "should have a forecastrequest new page at '/forecast'" do
    get '/forecast'
    response.should have_selector('h1', :content => "Forecast request - create")
  end
  
  describe "Submit form" do
    before(:each) do
      get '/forecast'
	  fill_in "forecastrequest[email]",    :with => "test@example.com"
      fill_in "forecastrequest[startdate]", :with => "01/01/2012"
      fill_in "forecastrequest[enddate]", :with => "03/31/2012"
      choose "forecastrequest_interval_15" #:interval, :with => 15
	  fill_in "forecastrequest[data]", :with => "2011-01-01T00:00:00Z,1\n2011-01-01T00:15:00Z,2\n2011-01-01T00:30:00Z,3\n2011-01-01T00:45:00Z,4\n"
      click_button	  
    end
	
   it "should create a result" do
      response.status.should be(200)
    end	

   it "Result should have a result field" do
      response.should have_selector("textarea")
   end		
	
	
   it "Result should have an email link" do
      response.should have_selector("a", :content => "Send to email address")
   end		

  end
  
  
  
end#describe layout links