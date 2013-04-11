# spec/controllers/tags_controller_spec.rb
require 'spec_helper'

describe TagsController do
  include Devise::TestHelpers
  render_views
  before :each do
    @a = Admin.new
    @a.email = 'admin@gmail.com'
    @a.username = 'admin'
    @a.password = '123123123'
    @a.confirm!
    @a.save

    sign_in @a
  end
    describe "PUT #addsym" do
      context "Synonym does not exist as a tag" do
      it "creates a new tag" do
        t = Tag.new(:name => 'Soft')
        t.save
        expect { put :addsym, id: t.id, tag: {:name => 'Eng'} } .to change(Tag, :count).by(1) 
      end
      it "updates the tag tags list on both sides" do
        t = Tag.new(:name => 'Soft')
        t.save
       put :addsym, id: t.id, tag: {:name => 'Eng'}
       t.tags.should eq(1)
       t.tags[0].tags.should eq(1)
      end

      it "redirects to #show" do
        t = Tag.new(:name => 'Soft')
        t.save
        put :addsym, id: t.id, tag: {:name => 'Eng'} 
        response.should redirect_to t
      end

      end

      context "Synonym exists as a tag" do
        
       
       it "updates the tag tags list on both sides" do
        t = Tag.new(:name => 'Soft')
        t.save
        t2 = Tag.new(:name => 'Eng')
        t2.save
        put :addsym, id: t.id, tag: {:name => 'Eng'}
        t.reload
        t2.reload
        t.tags.should eq(1)
        t2.tags.should eq(1)
        end

      it "redirects to #show" do
        t = Tag.new(:name => 'Soft')
        t.save
        t2 = Tag.new(:name => 'Eng')
        t2.save
        put :addsym, id: t.id, tag: {:name => 'Eng'}
        response.should redirect_to t
      end 
    end
     
     context "Synonym already exists in tag's sym list" do


        it "does not do anything" do
        t = Tag.new(:name => 'Soft')
        t.save
        t2 = Tag.new(:name => 'Eng')
        t2.save
        t.tags << t2
        t2.tags << t
        put :addsym, id: t.id, tag: {:name => 'Eng'}
        t.tags.should_not eq(2)
        t2.tags.should_not eq(2)
        end

        it "redirects to #show" do
          t = Tag.new(:name => 'Soft')
          t.save
          t2 = Tag.new(:name => 'Eng')
          t2.save
          t.tags << t2
          t2.tags << t
          put :addsym, id: t.id, tag: {:name => 'Eng'}
          response.should redirect_to t
        end 
      end
    end
    
    describe "PUT #delsym" do
      
      it "destroys @tag.tags using params[:id2]" do
      t = Tag.new(:name => 'Soft')
      t.save
      t2 = Tag.new(:name => 'Eng')
      t2.save
      t.tags << t2
      t2.tags << t 
        expect { put :delsym, id: t.id, sym: t2.id} .to change(t.tags, :count).by(1) 
      end
      it "redirects to :show view" do
      t = Tag.new(:name => 'Soft')
      t.save
      t2 = Tag.new(:name => 'Eng')
      t2.save
      t.tags << t2
      t2.tags << t 
        put :delsym, id: t.id, sym: t2.id
        response.should redirect_to t
      end
    end

    describe "GET #show" do
      
      it "gets the tag and it's associated syms" do
      t = Tag.new
      t.name = 'Software'
      t.save
      t.tags << Tag.new(:name => '1')
      t.tags << Tag.new(:name => '2')
      t.tags << Tag.new(:name => '3')
      t.tags << Tag.new(:name => '4')
      t.tags << Tag.new(:name => '5')
      get :show, :id => t.id
      assigns(:tag).should eq(t)
      assigns(:tags).should eq(t.tags)
      end

      it "renders the partial view _modal" do
      t = Tag.new
      t.name = 'Software'
      t.save
      t.tags << Tag.new(:name => '1')
      t.tags << Tag.new(:name => '2')
      t.tags << Tag.new(:name => '3')
      t.tags << Tag.new(:name => '4')
      t.tags << Tag.new(:name => '5')
      get :show, :id => t.id
      response.should render_template(:partial => 'modal')
      end
      end  
end