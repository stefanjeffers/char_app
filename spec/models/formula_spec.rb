# == Schema Information
#
# Table name: pinnames
#
#  id               :integer          not null, primary key
#  base             :string(255)
#  offset           :string(255)
#  subindex         :string(255)
#  ord              :string(255)

#  ...

#  graph_id         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Formula do

  before { @formula = Formula.new( base: "122", offset: "2", subindex: "0",
				   iform: "( 66.2.a ) / (( 66.0 ):<.(( 176.0.b | 170.0 )::173.0.a )) / 27.1",
				   word_form: "Grass-at-top / ( Plant:<.(( leaves | fruit )::droop )) / ( breath::meet:>surface )",
				   abbrev_form: "GAT / ( P:<.(( L | F )::D )) / ( B::M:>S )",
				   alpha: "GATO-PILO-FADO-BAMOS",
                                   graph_id: "000") }

  subject { @formula }

  it { should respond_to(:base) }
  it { should respond_to(:offset) }
  it { should respond_to(:subindex) }
  it { should respond_to(:iform) }
  it { should respond_to(:word_form) }
  it { should respond_to(:abbrev_form) }
  it { should respond_to(:alpha) }
  it { should respond_to(:graph_id) }

  it { should respond_to(:reverse_links) }
  it { should respond_to(:pinnames) }

  it { should respond_to(:linked_to?) }
  it { should respond_to(:link_to!) }
  it { should respond_to(:unlink!) }

#___________________________________________________
# Test base:
  
  describe "when base is not present" do
    before { @formula.base = " " }
    it { should_not be_valid }
  end

  describe "when base is too long" do
    before { @formula.base = "1" * 4 }
    it { should_not be_valid }
  end

  describe "when base format is invalid" do
    it "should be invalid" do
      bases = %w[ a abc 1234 123a 00A ]
      bases.each do |invalid_base|
        @formula.base = invalid_base

        # @formula.save
        # @formula.reload

        @formula.should_not be_valid
      end
    end
  end

  describe "when base format is valid" do
    it "should be valid" do
      bases = %w[ 0 000 01 001 1 111 123 99 999 ]
      bases.each do |valid_base|
        @formula.base = valid_base

        # @formula.save
        # @formula.reload

        @formula.should be_valid
      end
    end
  end

#___________________________________________________
# Test offset:
  
  describe "when offset is not present" do
    before { @formula.offset = " " }
    it { should_not be_valid }
  end

  describe "when offset is too long" do
    before { @formula.offset = "1" * 4 }
    it { should_not be_valid }
  end

  describe "when offset format is invalid" do
    it "should be invalid" do
      offsets = %w[ a abc 1234 123a 00A ]
      offsets.each do |invalid_offset|
        @formula.offset = invalid_offset

        # @formula.save
        # @formula.reload

        @formula.should_not be_valid
      end
    end
  end

  describe "when offset format is valid" do
    it "should be valid" do
      offsets = %w[ 0 000 01 001 1 111 123 99 999 ]
      offsets.each do |valid_offset|
        @formula.offset = valid_offset

        # @formula.save
        # @formula.reload

        @formula.should be_valid
      end
    end
  end

#___________________________________________________
# Test iform:
  
  describe "when iform is not present" do
    before { @formula.iform = " " }
    it { should_not be_valid }
  end

  describe "iform with mixed case" do
    let(:mixed_case_iform) { "( 66.2.A ) / (( 66.0.c ):<.(( 176.0.B)" }

    it "should be saved as all lower-case" do
      @formula.iform = mixed_case_iform

      @formula.save
      @formula.reload.iform.should == mixed_case_iform.downcase

    end
  end

#___________________________________________________
# Test abbrev_form:
  
  describe "when abbrev_form is not present" do
    before { @formula.abbrev_form = " " }
    it { should_not be_valid }
  end

  describe "abbrev_form with mixed case" do
    let(:mixed_case_abbrev_form) { "Gat / ( B::m:>S )" }

    it "should be saved as all upper-case" do
      @formula.abbrev_form = mixed_case_abbrev_form

      @formula.save
      @formula.reload.abbrev_form.should == mixed_case_abbrev_form.upcase

    end
  end

#___________________________________________________
# Test alpha:
  
  describe "when alpha is not present" do
    before { @formula.alpha = " " }
    it { should_not be_valid }
  end

  describe "alpha with mixed case" do
    let(:mixed_case_alpha) { "Gato-Pilo-FADO-bamos" }

    it "should be saved as all upper-case" do
      @formula.alpha = mixed_case_alpha

      @formula.save
      @formula.reload.alpha.should == mixed_case_alpha.upcase

    end
  end

#___________________________________________________
# Test link to pinnames:

  describe "linking to pinnames" do
    let(:pinname) { FactoryGirl.create(:pinname) }    
    before do
      @formula.save
      @formula.link_to!( pinname )
    end

    it { should be_linked_to(pinname) }
    its(:pinnames) { should include(pinname) }

    describe "and unlinking" do
      before { @formula.unlink!(pinname) }

      it { should_not be_linked_to(pinname) }
      its(:pinnames) { should_not include(pinname) }
    end
  end

#___________________________________________________
  
end

