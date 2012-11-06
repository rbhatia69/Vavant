require 'spec_helper'

describe "materials/index" do
  before(:each) do
    assign(:materials, [
      stub_model(Material,
        :content_type => 1,
        :detail_content => "MyText",
        :embedded_content => "MyText",
        :stored_file_name => "Stored File Name",
        :stored_content_type => "Stored Content Type",
        :stored_file_size => 2
      ),
      stub_model(Material,
        :content_type => 1,
        :detail_content => "MyText",
        :embedded_content => "MyText",
        :stored_file_name => "Stored File Name",
        :stored_content_type => "Stored Content Type",
        :stored_file_size => 2
      )
    ])
  end

  it "renders a list of materials" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Stored File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Stored Content Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
