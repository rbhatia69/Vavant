require 'spec_helper'

describe "registrations/new" do
  before(:each) do
    assign(:registration, stub_model(Registration,
      :user_id => 1,
      :course_id => 1,
      :price => "9.99"
    ).as_new_record)
  end

  it "renders new registration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => registrations_path, :method => "post" do
      assert_select "input#registration_user_id", :name => "registration[user_id]"
      assert_select "input#registration_course_id", :name => "registration[course_id]"
      assert_select "input#registration_price", :name => "registration[price]"
    end
  end
end
