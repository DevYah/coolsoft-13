require 'spec_helper'

describe CompetitionsController do

  describe "GET #index" do
    before :each do
      @investor = FactoryGirl.create(:investor)
      @investor.confirm!
      @investor2 = FactoryGirl.create(:investor,email: 'abuali@yahoo.com',username: 'hamed')
      @investor2.confirm!

      5.times do
          @competition1 = FactoryGirl.create(:competition,tags: [Tag.new(:name => 'Games')],investor: @investor)
      end
      6.times do
          @competition2 = FactoryGirl.create(:competition,investor: @investor2)
      end
    end

    it "returns all competitions" do
      get :index
      assigns(:competitions).should have(10).items
    end

    it "filters competitions" do
      get :index, :tags => ['a','Games']
      assigns(:competitions).should have(5).items
    end

    it "returns all competitions when tags are empty" do
      get :index, :tags => ['a']
      assigns(:competitions).should have(10).items
    end

    it "allow infinite scrolling" do
      get :index, :myPage => 2,:tags => ['a']
      assigns(:competitions).should have(1).items
    end

    it "scrolls with filtering" do
      get :index, :tags => ['a','Games'], :myPage => 2
      assigns(:competitions).should have(0).items
    end

    it "filters competitions for investor" do
      sign_in(@investor)
      get :index
      assigns(:competitions).should have(5).items
    end

  end
end