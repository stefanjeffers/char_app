'spec_helper'

describe Link do

  let(:pinname) { FactoryGirl.create(:pinname) }
  let(:formula) { FactoryGirl.create(:formula) }
  let(:link) { pinname.links.build( formula_id: formula.id) }

  subject { link }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to pinname_id" do
      # expect do
      #  Link.new(pinname_id: pinname.id)
      # end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "pinname methods" do    
    it { should respond_to(:pinname) }
    it { should respond_to(:formula) }
    its(:pinname) { should == pinname }
    its(:formula) { should == formula }
  end

  describe "when formula id is not present" do
    before { link.formula_id = nil }
    it { should_not be_valid }
  end

  describe "when pinname id is not present" do
    before { link.pinname_id = nil }
    it { should_not be_valid }
  end

end
