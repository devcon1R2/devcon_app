require 'spec_helper'

describe "forecastrequests/edit.html.erb" do
  before(:each) do
    @forecastrequest = assign(:forecastrequest, stub_model(Forecastrequest,
      :email => "MyString",
      :interval => 1,
      :data => "MyString"
    ))
  end

  it "renders the edit forecastrequest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forecastrequests_path(@forecastrequest), :method => "post" do
      assert_select "input#forecastrequest_email", :name => "forecastrequest[email]"
      assert_select "input#forecastrequest_interval", :name => "forecastrequest[interval]"
      assert_select "input#forecastrequest_data", :name => "forecastrequest[data]"
    end
  end
end
