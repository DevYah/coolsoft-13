require 'spec_helper'

describe CompetitionsController do

  describe "GET #index" do
    before :each do
      @competition1 = FactoryGirl.create(:competition,tags: [Tag.new(:name => 'Games')])
      @competition2 = FactoryGirl.create(:competition)
      @competition3 = FactoryGirl.create(:competition)
    end

    it "returns all competitions" do
      get :index
      assigns(:competitions).should have(3).items
    end

    it "filters competitions" do
      get :index, :tags => ['a','Games']
      assigns(:competitions).should have(1).items
    end

  end
end