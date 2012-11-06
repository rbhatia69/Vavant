require 'spec_helper'

describe "materials/new" do
  before(:each) do
    assign(:material, stub_model(Material,
      :content_type => 1,
      :detail_content => "MyText",
      :embedded_content => "MyText",
      :stored_file_name => "MyString",
      :stored_content_type => "MyString",
      :stored_file_size => 1
    ).as_new_record)
  end

  it "renders new material form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => materials_path, :method => "post" do
      assert_select "input#material_content_type", :name => "material[content_type]"
      assert_select "textarea#material_detail_content", :name => "material[detail_content]"
      assert_select "textarea#material_embedded_content", :name => "material[embedded_content]"
      assert_select "input#material_stored_file_name", :name => "material[stored_file_name]"
      assert_select "input#material_stored_content_type", :name => "material[stored_content_type]"
      assert_select "input#material_stored_file_size", :name => "material[stored_file_size]"
    end
  end
end
