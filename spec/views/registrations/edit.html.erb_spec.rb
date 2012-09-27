require 'spec_helper'

describe "registrations/edit" do
  before(:each) do
    @registration = assign(:registration, stub_model(Registration,
      :user_id => 1,
      :course_id => 1,
      :price => "9.99"
    ))
  end

  it "renders the edit registration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => registrations_path(@registration), :method => "post" do
      assert_select "input#registration_user_id", :name => "registration[user_id]"
      assert_select "input#registration_course_id", :name => "registration[course_id]"
      assert_select "input#registration_price", :name => "registration[price]"
    end
  end
end
