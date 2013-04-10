require "spec_helper"

  describe "ideas/_show.html.erb" do
    it "display auto complete form" do

      render :partial => "ideas/show.html.erb"

      rendered.should include("id=\"input-facebook-theme\"")
      rendered.should include("id=\"filter\"")
    end
  end




