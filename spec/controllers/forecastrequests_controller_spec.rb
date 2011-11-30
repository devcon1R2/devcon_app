require 'spec_helper'


describe ForecastrequestsController do
  render_views
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right H1" do
      get 'new'
      response.should have_selector("h1", :content => "Forecast request - create")
    end
	
	describe "fields" do
	  it "should have field email" do
	    get 'new'
		response.should have_selector("input", :name => "forecastrequest[email]")
	  end#it
	  it "should have field startdate" do
	    get 'new'
		response.should have_selector("input", :name => "forecastrequest[startdate]")
	  end#it	  
	  it "should have field enddate" do
	    get 'new'
		response.should have_selector("input", :name => "forecastrequest[enddate]")
	  end#it	
	  it "should have field interval" do
	    get 'new'
		response.should have_selector("input", :name => "forecastrequest[interval]")
	  end#it	
	  it "should have multiline field data" do
	    get 'new'
		response.should have_selector("textarea", :name => "forecastrequest[data]")
	  end#it	
	end#describe fields
  end



end
