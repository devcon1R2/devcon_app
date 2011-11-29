require 'spec_helper'

describe "forecastrequests/new.html.erb" do
  before(:each) do
    assign(:forecastrequest, stub_model(Forecastrequest,
      :email => "MyString",
      :interval => 1,
      :data => "MyString"
    ).as_new_record)
  end

  it "renders new forecastrequest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forecastrequests_path, :method => "post" do
      assert_select "input#forecastrequest_email", :name => "forecastrequest[email]"
      assert_select "input#forecastrequest_interval", :name => "forecastrequest[interval]"
      assert_select "input#forecastrequest_data", :name => "forecastrequest[data]"
    end
  end
end
