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
      response.should have_selector("h1", :content => "New forecastrequest")
    end
	
	describe "fields" do
	  it "should have field email" do
	    get 'new'
		response.should have_selector("input", :name => "@forecastrequest[email]")
	  end#it
	  it "should have field startdate" do
	    get 'new'
		response.should have_selector("input", :name => "@forecastrequest[startdate]")
	  end#it	  
	  it "should have field enddate" do
	    get 'new'
		response.should have_selector("input", :name => "@forecastrequest[enddate]")
	  end#it	
	  it "should have field interval" do
	    get 'new'
		response.should have_selector("input", :name => "@forecastrequest[interval]")
	  end#it	
	  it "should have field data" do
	    get 'new'
		response.should have_selector("input", :name => "@forecastrequest[data]")
	  end#it	
	end#describe fields
  end

  # This should return the minimal set of attributes required to create a valid
  # Forecastrequest. As you add validations to Forecastrequest, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end




#  describe "GET new" do
#    it "assigns a new forecastrequest as @forecastrequest" do
#      get :new
#      assigns(:forecastrequest).should be_a_new(Forecastrequest)
#    end
#  end

 

  # describe "POST create" do
    # describe "with valid params" do
      # it "creates a new Forecastrequest" do
        # expect {
          # post :create, :forecastrequest => valid_attributes
        # }.to change(Forecastrequest, :count).by(1)
      # end

      # it "assigns a newly created forecastrequest as @forecastrequest" do
        # post :create, :forecastrequest => valid_attributes
        # assigns(:forecastrequest).should be_a(Forecastrequest)
        # assigns(:forecastrequest).should be_persisted
      # end

      # it "redirects to the created forecastrequest" do
        # post :create, :forecastrequest => valid_attributes
        # response.should redirect_to(Forecastrequest.last)
      # end
    # end

    # describe "with invalid params" do
      # it "assigns a newly created but unsaved forecastrequest as @forecastrequest" do
        # # Trigger the behavior that occurs when invalid params are submitted
        # Forecastrequest.any_instance.stub(:save).and_return(false)
        # post :create, :forecastrequest => {}
        # assigns(:forecastrequest).should be_a_new(Forecastrequest)
      # end

      # it "re-renders the 'new' template" do
        # # Trigger the behavior that occurs when invalid params are submitted
        # Forecastrequest.any_instance.stub(:save).and_return(false)
        # post :create, :forecastrequest => {}
        # response.should render_template("new")
      # end
    # end
  # end

  # describe "PUT update" do
    # describe "with valid params" do
      # it "updates the requested forecastrequest" do
        # forecastrequest = Forecastrequest.create! valid_attributes
        # # Assuming there are no other forecastrequests in the database, this
        # # specifies that the Forecastrequest created on the previous line
        # # receives the :update_attributes message with whatever params are
        # # submitted in the request.
        # Forecastrequest.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        # put :update, :id => forecastrequest.id, :forecastrequest => {'these' => 'params'}
      # end

      # it "assigns the requested forecastrequest as @forecastrequest" do
        # forecastrequest = Forecastrequest.create! valid_attributes
        # put :update, :id => forecastrequest.id, :forecastrequest => valid_attributes
        # assigns(:forecastrequest).should eq(forecastrequest)
      # end

      # it "redirects to the forecastrequest" do
        # forecastrequest = Forecastrequest.create! valid_attributes
        # put :update, :id => forecastrequest.id, :forecastrequest => valid_attributes
        # response.should redirect_to(forecastrequest)
      # end
    # end

    # describe "with invalid params" do
      # it "assigns the forecastrequest as @forecastrequest" do
        # forecastrequest = Forecastrequest.create! valid_attributes
        # # Trigger the behavior that occurs when invalid params are submitted
        # Forecastrequest.any_instance.stub(:save).and_return(false)
        # put :update, :id => forecastrequest.id.to_s, :forecastrequest => {}
        # assigns(:forecastrequest).should eq(forecastrequest)
      # end

      # it "re-renders the 'edit' template" do
        # forecastrequest = Forecastrequest.create! valid_attributes
        # # Trigger the behavior that occurs when invalid params are submitted
        # Forecastrequest.any_instance.stub(:save).and_return(false)
        # put :update, :id => forecastrequest.id.to_s, :forecastrequest => {}
        # response.should render_template("edit")
      # end
    # end
  # end

  # describe "DELETE destroy" do
    # it "destroys the requested forecastrequest" do
      # forecastrequest = Forecastrequest.create! valid_attributes
      # expect {
        # delete :destroy, :id => forecastrequest.id.to_s
      # }.to change(Forecastrequest, :count).by(-1)
    # end

    # it "redirects to the forecastrequests list" do
      # forecastrequest = Forecastrequest.create! valid_attributes
      # delete :destroy, :id => forecastrequest.id.to_s
      # response.should redirect_to(forecastrequests_url)
    # end
  # end

end
