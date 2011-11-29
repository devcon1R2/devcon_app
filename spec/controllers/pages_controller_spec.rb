require 'spec_helper'

describe PagesController do
  render_views
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
	
	it "should have home in the H1 tag" do
      get 'home'
      response.should have_selector("h1", :content => "DevCon App - Home")
	  
    end

	it "should have a 'request forecast' button" do
      get 'home'
      response.should have_selector("a", :content => "Request Forecast")
	  
    end
	
  end

end
