require 'spec_helper'

describe Invited do

  describe "self.creates" do

    it 'validates admin exists' do
      i = Invited.creates('muhammed@yahoo.com',nil)

      i.valid?.should == false
    end
    it 'validates email format' do
      i = Invited.creates('muhammed@yahoo',1)
      i2 = Invited.creates(nil,1)

      i.valid?.should == false
      i.valid?.should == false
    end
    it 'saves valid invitations' do
      i = Invited.creates('muhammed@yahoo.com',1)
      i = Invited.creates('muhammed@yahoo.com',1)

      Invited.all.length.should == 1
    end
  end
end
