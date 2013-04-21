# spec/controllers/tags_controller_spec.rb
require 'spec_helper'

#Author: Mohammad Abdulkhaliq
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
      get :index
      response.should be_successful
      response.should render_template("index")
    end
  end

  describe "GET #new" do
    it "assigns a new Tag to @tag" do
      get :new
      assigns(:tag).should_not eq(nil)
    end
    it "renders the :new template" do
      get :new
      response.should be_successful
      response.should render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new tag in the database" do
        expect{
          post :create, tag: {:name => 'Software'}
        }.to change(Tag,:count).by(1)
      end
    end
    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        t = Tag.new(:name => 'Software').save
        expect{
          post :create, tag: {:name => 'Software'}
        }.to_not change(Tag,:count)
      end
    end
  end

end
