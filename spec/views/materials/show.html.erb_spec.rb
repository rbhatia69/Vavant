require 'spec_helper'

describe "materials/show" do
  before(:each) do
    @material = assign(:material, stub_model(Material,
      :content_type => 1,
      :detail_content => "MyText",
      :embedded_content => "MyText",
      :stored_file_name => "Stored File Name",
      :stored_content_type => "Stored Content Type",
      :stored_file_size => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Stored File Name/)
    rendered.should match(/Stored Content Type/)
    rendered.should match(/2/)
  end
end
