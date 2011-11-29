require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
      response.should have_selector("h1", :content => "DevCon App - Home")
  end
  
  
  it "should have a forecastrequest new page at '/forecast'" do
    get '/forecast'
    response.should have_selector('h1', :content => "New forecastrequest")
  end
end#describe layout links