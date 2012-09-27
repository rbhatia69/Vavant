require 'spec_helper'

describe Language do
  it "can not create two languages of the same name" do
    language = Language.create(:name => 'English')
    language1 = Language.create(:name => 'English')
    language1.should_not be_valid
  end
end
