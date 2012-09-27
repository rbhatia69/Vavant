require 'spec_helper'

describe "courses/index" do
  before(:each) do
    assign(:courses, [
      stub_model(Course,
        :title => "Title",
        :description => "MyText",
        :price => "9.99",
        :rating => 1.5,
        :enabled => false,
        :user_id => 1,
        :collection_id => 2,
        :language_id => 3,
        :no_of_reviews => 4,
        :no_of_registrations => 5,
        :photo_file_name => "Photo File Name",
        :photo_content_type => "Photo Content Type",
        :photo_file_size => 6
      ),
      stub_model(Course,
        :title => "Title",
        :description => "MyText",
        :price => "9.99",
        :rating => 1.5,
        :enabled => false,
        :user_id => 1,
        :collection_id => 2,
        :language_id => 3,
        :no_of_reviews => 4,
        :no_of_registrations => 5,
        :photo_file_name => "Photo File Name",
        :photo_content_type => "Photo Content Type",
        :photo_file_size => 6
      )
    ])
  end

  it "renders a list of courses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Photo File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Photo Content Type".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
