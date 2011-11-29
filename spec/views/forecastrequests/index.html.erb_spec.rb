require 'spec_helper'

describe "forecastrequests/index.html.erb" do
  before(:each) do
    assign(:forecastrequests, [
      stub_model(Forecastrequest,
        :email => "Email",
        :interval => 1,
        :data => "Data"
      ),
      stub_model(Forecastrequest,
        :email => "Email",
        :interval => 1,
        :data => "Data"
      )
    ])
  end

  it "renders a list of forecastrequests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Data".to_s, :count => 2
  end
end
