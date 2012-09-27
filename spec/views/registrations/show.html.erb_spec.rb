require 'spec_helper'

describe "registrations/show" do
  before(:each) do
    @registration = assign(:registration, stub_model(Registration,
      :user_id => 1,
      :course_id => 2,
      :price => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/9.99/)
  end
end
