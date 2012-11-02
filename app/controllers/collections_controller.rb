class CollectionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]


  def index
    @collections = Collection.find_collection_by_user(current_user.id)
  end

  def show
    @collection = Collection.find(params[:id])
  end

  def new
    @collection = Collection.new
  end

  def edit
    @collection = Collection.find(params[:id])
  end

  def create
    counter = 0
    params[:id].each do |value|
      collection = Collection.find(value)
      collection.name = params[:collection_name][counter]
      collection.save
      counter = counter + 1
    end

    if (params[:new_collection].length > 0)
      @collection = Collection.create(:user_id => current_user.id, :name => params[:new_collection])
    end
    redirect_to(collections_path(), :notice => 'Collection(s) were successfully saved.')
  end

  def update
    @collection = Collection.find(params[:id])
    @collection.name =  params[:collection]
    @collection.user_id = current_user.id

    if @collection.save
      redirect_to(collections_path(), :notice => 'Collection was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy

    redirect_to(collections_path(), :notice => 'Collection was successfully deleted.')
  end
end
