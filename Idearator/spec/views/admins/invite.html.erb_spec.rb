require "spec_helper"

  describe "admins/invite.html.erb" do
    it "displays invitation form" do

      render

      rendered.should include("<div id=\"example\"")
      rendered.should include("<a data-toggle=\"modal\" href=\"#example\"")      
  end
end