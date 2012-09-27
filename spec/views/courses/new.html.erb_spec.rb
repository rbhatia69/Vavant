require 'spec_helper'

describe "courses/new" do
  before(:each) do
    assign(:course, stub_model(Course,
      :title => "MyString",
      :description => "MyText",
      :price => "9.99",
      :rating => 1.5,
      :enabled => false,
      :user_id => 1,
      :collection_id => 1,
      :language_id => 1,
      :no_of_reviews => 1,
      :no_of_registrations => 1,
      :photo_file_name => "MyString",
      :photo_content_type => "MyString",
      :photo_file_size => 1
    ).as_new_record)
  end

  it "renders new course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => courses_path, :method => "post" do
      assert_select "input#course_title", :name => "course[title]"
      assert_select "textarea#course_description", :name => "course[description]"
      assert_select "input#course_price", :name => "course[price]"
      assert_select "input#course_rating", :name => "course[rating]"
      assert_select "input#course_enabled", :name => "course[enabled]"
      assert_select "input#course_user_id", :name => "course[user_id]"
      assert_select "input#course_collection_id", :name => "course[collection_id]"
      assert_select "input#course_language_id", :name => "course[language_id]"
      assert_select "input#course_no_of_reviews", :name => "course[no_of_reviews]"
      assert_select "input#course_no_of_registrations", :name => "course[no_of_registrations]"
      assert_select "input#course_photo_file_name", :name => "course[photo_file_name]"
      assert_select "input#course_photo_content_type", :name => "course[photo_content_type]"
      assert_select "input#course_photo_file_size", :name => "course[photo_file_size]"
    end
  end
end
