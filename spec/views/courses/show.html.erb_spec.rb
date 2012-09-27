require 'spec_helper'

describe "courses/show" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/9.99/)
    rendered.should match(/1.5/)
    rendered.should match(/false/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/Photo File Name/)
    rendered.should match(/Photo Content Type/)
    rendered.should match(/6/)
  end
end
