
require 'spec_helper'
require 'factory_girl'
require 'factories'

describe "Pinname pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      FactoryGirl.create(:pinname, name_word: "camel",    name_word_abbrev: "C")
      FactoryGirl.create(:pinname, name_word: "eohippus", name_word_abbrev: "E")
      FactoryGirl.create(:pinname, name_word: "hippus",   name_word_abbrev: "H")
      visit pinnames_path
    end

    it { should have_selector('title', text: 'All Chars') }
    it { should have_selector('h1',    text: 'All Chars') }

    # it "should list each char" do
    #   Pinname.all.each do |pinname|
    #     page.should have_selector('li', text: pinname.name_word)
    #   end
    # end

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:pinname) } }
      after(:all)  { Pinname.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each char" do
        Pinname.paginate(page: 1).each do |pinname|
          page.should have_selector('li', text: pinname.name_word)
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do

        let(:admin) { FactoryGirl.create(:admin) }

        before do
          sign_in admin
          visit pinnames_path
        end

        it { should have_link('delete', href: pinname_path(Pinname.first)) }
        it "should be able to delete a char entry" do
          expect { click_link('delete') }.to change( Pinname, :count).by(-1)
        end
      end
    end

# begin provisional____________________

# end   provisional____________________

  end

    # Corresponds to "profile page":
  describe "pinname page" do

    let(:pinname) { FactoryGirl.create(:pinname) }
    before { visit pinname_path(pinname) }

    it { should have_selector('h1',    text: pinname.name_word) }
    it { should have_selector('title', text: pinname.pinyin) }
  end

    # Corresponds to "signup page":
  describe "create pinname page" do
    # let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in FactoryGirl.create(:admin)
      # sign_in user
      visit add_pinname_path 
    end

    it { should have_selector('h1',    text: 'Create pinname') }
    it { should have_selector('title', text: 'Create pinname') }
  end

    # Isn't this redundant with previous test above? No, that is the form, this is the update (post or put?) 
  describe "create new char" do
    # let(:user) { FactoryGirl.create(:user) }

    before do
      # sign_in user
      sign_in FactoryGirl.create(:admin)
      visit add_pinname_path 
    end

    let( :submit) { "Create char" }

    describe "with invalid information" do
      it "should not create a new char" do
        expect { click_button submit }.not_to change( Pinname, :count)
      end
    end
	# Could make this a helper fn?
    describe "with valid information" do
      let(:new_base )  { "173" }
      let(:new_offset ) { "9" }
      let(:new_pinyin ) { "hua2" }
      let(:new_name_word ) { "flowery" }
      let(:new_name_word_abbrev ) { "F" }
      let(:new_part_of_speech ) { "adjective" }

      before do
        fill_in "Base",           with: new_base
        fill_in "Offset",         with: new_offset
        fill_in "Pinyin",         with: new_pinyin
        fill_in "Name Word",      with: new_name_word
        fill_in "Abbreviation",   with: new_name_word_abbrev
        fill_in "Part of Speech", with: new_part_of_speech
      end

      it "should create a new char" do
        expect { click_button submit }.to change( Pinname, :count).by(1)
      end

      describe "after saving the new char information" do
        before { click_button submit }
		# Assumed the new char has the highest id, ie, id==count. That failed.
        # let(:pinname) { Pinname.find_by_id( Pinname.count ) }
        # it { should have_selector('title', text: pinname.pinyin ) }
        it { should have_selector('title', text: new_pinyin ) }
        it { should have_selector('div.alert.alert-success', text: 'Thank you for the new char') }
      end
    end
  end

  describe "edit" do
    # let(:user) { FactoryGirl.create(:user) }
    let(:pinname) { FactoryGirl.create(:pinname) }

    before do
      # sign_in user
      sign_in FactoryGirl.create(:admin)
      visit edit_pinname_path(pinname)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update Char Data") }
      it { should have_selector('title', text: "Edit Char Data") }
      # Change this to show the char graphic:
      # it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      let(:new_base )  { "" }
      let(:new_offset ) { "" }
      let(:new_pinyin ) { "" }
      let(:new_name_word ) { "" }
      let(:new_name_word_abbrev ) { "" }
      let(:new_part_of_speech ) { "" }

      before do
        fill_in "Base",           with: new_base
        fill_in "Offset",         with: new_offset
        fill_in "Pinyin",         with: new_pinyin
        fill_in "Name Word",      with: new_name_word
        fill_in "Abbreviation",   with: new_name_word_abbrev
        fill_in "Part of Speech", with: new_part_of_speech

        click_button "Save changes"
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_base )  { "173" }
      let(:new_offset ) { "9" }
      let(:new_pinyin ) { "hua2" }
      let(:new_name_word ) { "flowery" }
      let(:new_name_word_abbrev ) { "F" }
      let(:new_part_of_speech ) { "adjective" }

        # Need to add test for changing char graphic:
      before do
        fill_in "Base",           with: new_base
        fill_in "Offset",         with: new_offset
        fill_in "Pinyin",         with: new_pinyin
        fill_in "Name Word",      with: new_name_word
        fill_in "Abbreviation",   with: new_name_word_abbrev
        fill_in "Part of Speech", with: new_part_of_speech

        click_button "Save changes"
      end

      it { should have_selector('title', text: new_pinyin) }
      it { should have_selector('h1', text: new_name_word) }
      it { should have_selector('div.alert.alert-success') }
      # it { should have_link('Sign out', href: signout_path) }
      specify { pinname.reload.base.should  == new_base }
      specify { pinname.reload.offset.should == new_offset }
      specify { pinname.reload.pinyin.should == new_pinyin }
      specify { pinname.reload.name_word.should == new_name_word }
      specify { pinname.reload.name_word_abbrev.should == new_name_word_abbrev }
      specify { pinname.reload.part_of_speech.should == new_part_of_speech }
    end
  end
end

