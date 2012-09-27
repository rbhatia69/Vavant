require 'spec_helper'

describe "lessons/edit" do
  before(:each) do
    @lesson = assign(:lesson, stub_model(Lesson,
      :title => "MyString",
      :description => "MyString",
      :course_id => 1,
      :sequence => 1
    ))
  end

  it "renders the edit lesson form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => lessons_path(@lesson), :method => "post" do
      assert_select "input#lesson_title", :name => "lesson[title]"
      assert_select "input#lesson_description", :name => "lesson[description]"
      assert_select "input#lesson_course_id", :name => "lesson[course_id]"
      assert_select "input#lesson_sequence", :name => "lesson[sequence]"
    end
  end
end
