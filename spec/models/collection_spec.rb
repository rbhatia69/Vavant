require 'spec_helper'

describe Collection do

  before :each do
    @user = User.create(:email => "admin@vavant.com", :password => "test1234")
  end

  it "new collection must require name and user_id" do
    collection = Collection.create
    collection.should_not be_valid
  end

  it "new collection must require name" do
    collection = Collection.create(:user_id => @user.id)
    collection.should_not be_valid
  end

  it "new collection must require user" do
    collection = Collection.create(:name => "Testing")
    collection.should_not be_valid
  end

  it "new collection created successfully" do
    collection = Collection.create(:name => "Testing", :user_id => @user.id)
    collection.should be_instance_of Collection
  end

  it "collection with new create course" do
    collection = Collection.create(:name => "Testing", :user_id => @user.id)
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id, :collection_id => collection.id)

    courses = Course.courses_by_collection(collection.id)
    courses.length.should eql 0
  end

  it "collection with new create course and enabled" do
    collection = Collection.create(:name => "Testing", :user_id => @user.id)
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id, :collection_id => collection.id, :rating => 0, :price => 0)
    course.enabled = true
    course.save

    courses = Course.courses_by_collection(collection.id)
    courses.length.should eql 1
  end

  it "make sure a user can't create two collections with same name" do
    collection = Collection.create(:name => "Testing", :user_id => @user.id)
    collection = Collection.create(:name => "Testing", :user_id => @user.id)

    collection.should_not be_valid
  end

  it "upon deletion course collection_id should be nil" do
    collection = Collection.create(:name => "Testing", :user_id => @user.id)
    course = Course.create(:title => "Testing", :description => "Testing", :user_id => @user.id, :collection_id => collection.id, :rating => 0, :price => 0)
    course.save

    collection.destroy

    course = Course.find(course.id)
    course.collection_id.should eql nil
  end

end
