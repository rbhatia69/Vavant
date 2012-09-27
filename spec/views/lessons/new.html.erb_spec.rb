require 'spec_helper'

describe "lessons/new" do
  before(:each) do
    assign(:lesson, stub_model(Lesson,
      :title => "MyString",
      :description => "MyString",
      :course_id => 1,
      :sequence => 1
    ).as_new_record)
  end

  it "renders new lesson form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => lessons_path, :method => "post" do
      assert_select "input#lesson_title", :name => "lesson[title]"
      assert_select "input#lesson_description", :name => "lesson[description]"
      assert_select "input#lesson_course_id", :name => "lesson[course_id]"
      assert_select "input#lesson_sequence", :name => "lesson[sequence]"
    end
  end
end
