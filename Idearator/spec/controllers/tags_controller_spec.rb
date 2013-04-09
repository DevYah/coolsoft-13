# spec/controllers/tags_controller_spec.rb
require 'spec_helper'

describe TagsController do
  describe "GET #index" do
    it "populates an array of tags"
    it "renders the :index view"
  end
  
  describe "GET #show" do
    it "assigns the requested contact to @contact"
    it "renders the :show template"
    it "renders the _modal"
  end
  
  describe "GET #new" do
    it "assigns a new Tag to @tag"
    it "renders the :new template"
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new tag in the database"
      it "redirects to the :index view"
    end
    
    context "with invalid attributes" do
      it "does not save the new contact in the database"
      it "re-renders the :new template"
    end
    
    describe "addsym" do
      it "places the synonym name to :name in params[:tag][:name]"
      it "updates the tag list of @tag"
      it "updates the tag list of synonym tag"
      it "redirects to :show view"
    end
    
    describe "delsym" do
      it "retrives the Tag instance from :id"
      it "destroys @tag.tags using params[:id2]"
      it "redirects to :show view"
    end
    
  end
end