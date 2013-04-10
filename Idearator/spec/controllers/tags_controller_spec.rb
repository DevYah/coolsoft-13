# spec/controllers/tags_controller_spec.rb
require 'spec_helper'

describe TagsController do
  include Devise::TestHelpers
  before :each do
    @a1 = Admin.new
    @a1.email = 'admin@gmail.com'
    @a1.username = 'admin'
    @a1.password = '123123123'
    @a1.confirm!
    @a1.save

    sign_in @a1
  end
  describe "GET #index" do
    it "populates an array of tags" do
      tag = []
      tag << Tag.new(:name => '1').save
      tag << Tag.new(:name => '2').save
      tag << Tag.new(:name => '3').save
      tag << Tag.new(:name => '4').save
      tag << Tag.new(:name => '5').save
      tag = Tag.all
      get :index
      assigns(:tags).should eq(tag)
    end
    it "renders the template view" do 
       response.should be_successful
       response.should render_template("index")
     end
  end
   
  describe "GET #new" do
    it "assigns a new Tag to @tag" do
      get :new
      assigns(:tag).should eq(Tag.new)
    end
    it "renders the :new template" do
      response.should be_successful
      response.should render_template("new")
    end
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new tag in the database" do
        t = Tag.new
        expect{
        post :create, tag: t, name: 'Software'
      }.to change(Tag,:count).by(1)
    end
      it "redirects to the :index view" do
        response.should be_successful
        response.should render_template ("index")
     end
    end
    
    context "with invalid attributes" do
      it "does not save the new contact in the database" do
      t = Tag.new
        expect{
        post :create, tag: t, name: ''
      }.to_not change(Tag,:count)
    end
      it "re-renders the new method" do
      post :create, t
      response.should render_template ("new")
      end
    end 
  end
end
