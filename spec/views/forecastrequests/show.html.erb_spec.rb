require 'spec_helper'

describe "forecastrequests/show.html.erb" do
  before(:each) do
    @forecastrequest = assign(:forecastrequest, stub_model(Forecastrequest,
      :email => "Email",
      :interval => 1,
      :data => "Data"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Data/)
  end
end
