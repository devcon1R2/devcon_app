require "spec_helper"

describe ForecastrequestsController do
  describe "routing" do

    it "routes to #index" do
      get("/forecastrequests").should route_to("forecastrequests#index")
    end

    it "routes to #new" do
      get("/forecastrequests/new").should route_to("forecastrequests#new")
    end

    it "routes to #show" do
      get("/forecastrequests/1").should route_to("forecastrequests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/forecastrequests/1/edit").should route_to("forecastrequests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/forecastrequests").should route_to("forecastrequests#create")
    end

    it "routes to #update" do
      put("/forecastrequests/1").should route_to("forecastrequests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/forecastrequests/1").should route_to("forecastrequests#destroy", :id => "1")
    end

  end
end
