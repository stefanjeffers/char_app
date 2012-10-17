require 'spec_helper'
require 'factory_girl'
require 'factories'

describe "Char pages" do

  subject { page }

  describe "char page" do
    let(:pinname) { FactoryGirl.create(:pinname) }
    before { visit char_path(pinname) }

    it { should have_selector('h1',    text: pinname.name_word) }
    it { should have_selector('title', text: pinname.name_word) }
  end

  describe "create char page" do
    before { visit create_path }

    it { should have_selector('h1',    text: 'Create Char') }
    it { should have_selector('title', text: 'Create Char') }
  end

  describe "create new char" do

    before { visit create_path }

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
        fill_in "Abbrev",         with: "F"
        fill_in "Part of Speech", with: "adjective"
      end

      it "should create a new char" do
        expect { click_button submit }.to change( Pinname, :count).by(1)
      end
    end
  end

end

