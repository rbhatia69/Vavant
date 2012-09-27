require 'spec_helper'

describe "reviews/new" do
  before(:each) do
    assign(:review, stub_model(Review,
      :user_id => 1,
      :comment => "MyString",
      :course_id => 1,
      :rating => 1
    ).as_new_record)
  end

  it "renders new review form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reviews_path, :method => "post" do
      assert_select "input#review_user_id", :name => "review[user_id]"
      assert_select "input#review_comment", :name => "review[comment]"
      assert_select "input#review_course_id", :name => "review[course_id]"
      assert_select "input#review_rating", :name => "review[rating]"
    end
  end
end
