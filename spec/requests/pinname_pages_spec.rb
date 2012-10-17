
require 'spec_helper'
require 'factory_girl'
require 'factories'

describe "Pinname pages" do

  subject { page }
    # Corresponds to "profile page":
  describe "pinname page" do
    let(:pinname) { FactoryGirl.create(:pinname) }
    before { visit pinname_path(pinname) }

    it { should have_selector('h1',    text: pinname.name_word) }
    it { should have_selector('title', text: pinname.pinyin) }
  end

    # Corresponds to "signup page":
  describe "create pinname page" do
    before { visit add_pinname_path }

    it { should have_selector('h1',    text: 'Create pinname') }
    it { should have_selector('title', text: 'Create pinname') }
  end

  describe "create new char" do

    before { visit add_pinname_path }

    let( :submit) { "Create char" }

    describe "with invalid information" do
      it "should not create a new char" do
        expect { click_button submit }.not_to change( Pinname, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Base",           with: "173"
        fill_in "Offset",         with: "9"
        fill_in "Pinyin",         with: "hua2"
        fill_in "Name Word",      with: "flowery"
        fill_in "Abbreviation",   with: "F"
        fill_in "Part of Speech", with: "adjective"
      end

      it "should create a new char" do
        expect { click_button submit }.to change( Pinname, :count).by(1)
      end

      describe "after saving the new char information" do
        before { click_button submit }
        let(:pinname) { Pinname.find_by_id( Pinname.count ) }

        it { should have_selector('title', text: pinname.pinyin ) }
        it { should have_selector('div.alert.alert-success', text: 'Thank you for the new char') }
      end
    end
  end


end

