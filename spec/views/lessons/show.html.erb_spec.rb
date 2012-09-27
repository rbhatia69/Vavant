require 'spec_helper'

describe "lessons/show" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :title => "Title",
      :description => "Description",
      :course_id => 1,
      :sequence => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Description/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
