class ForecastrequestsController < ApplicationController
  
  def new
    @forecastrequest = Forecastrequest.new
    render 'new'
  end
  
	
  def create
	@forecastrequest = Forecastrequest.new(params[:forecastrequest])
	@forecastrequest.save!
    @forecastrequest.computeforecast
	@forecastrequest.save!
	render 'show'
  end
  
  

  def destroy
    @forecastrequest = Forecastrequest.find(params[:id])
    @forecastrequest.destroy
  end
end
