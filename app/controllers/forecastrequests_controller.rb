class ForecastrequestsController < ApplicationController


  # GET /forecastrequests/new
  # GET /forecastrequests/new.xml
  def new
  #@forecastrequest = Forecastrequest.new
  
 #   respond_to do |format|
 #     format.html # new.html.erb
 #   end
  end

  # GET /forecastrequests
  # GET /forecastrequests.xml
#  def index
#    @forecastrequests = Forecastrequest.all

#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @forecastrequests }
#    end
#  end

  # GET /forecastrequests/1
  # GET /forecastrequests/1.xml
#  def show
#    @forecastrequest = Forecastrequest.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @forecastrequest }
#    end
#  end  
  
  
  # GET /forecastrequests/1/edit
#  def edit
#    @forecastrequest = Forecastrequest.find(params[:id])
#  end

  # POST /forecastrequests
  # POST /forecastrequests.xml
#  def create
#    @forecastrequest = Forecastrequest.new(params[:forecastrequest])
#
#    respond_to do |format|
#      if @forecastrequest.save
#        format.html { redirect_to(@forecastrequest, :notice => 'Forecastrequest was successfully created.') }
#        format.xml  { render :xml => @forecastrequest, :status => :created, :location => @forecastrequest }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @forecastrequest.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # PUT /forecastrequests/1
  # PUT /forecastrequests/1.xml
#  def update
#    @forecastrequest = Forecastrequest.find(params[:id])
#
#    respond_to do |format|
#      if @forecastrequest.update_attributes(params[:forecastrequest])
#        format.html { redirect_to(@forecastrequest, :notice => 'Forecastrequest was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @forecastrequest.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /forecastrequests/1
  # DELETE /forecastrequests/1.xml

  def destroy
    @forecastrequest = Forecastrequest.find(params[:id])
    @forecastrequest.destroy
  end
end
