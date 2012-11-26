
require 'spec_helper'
# require 'factory_girl'
# require 'factories'

describe "Formula pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      FactoryGirl.create(:formula, word_form: "cliff */ camel", abbrev_form: "C */ C")
      FactoryGirl.create(:formula, word_form: "divide / dog",   abbrev_form: "D / D")
      FactoryGirl.create(:formula, word_form: "bar / boat",     abbrev_form: "B / B")
      visit formulas_path
    end

    it { should have_selector('title', text: 'All Formulas') }
    it { should have_selector('h1',    text: 'All Formulas') }

    # it "should list each char" do
    #   Formula.all.each do |formula|
    #     page.should have_selector('li', text: formula.xxx )
    #   end
    # end

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:formula) } }
      after(:all)  { Formula.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each char" do
        Formula.paginate(page: 1).each do |formula|
          page.should have_selector('li', text: formula.alpha )
        end
      end
    end

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do

        let(:admin) { FactoryGirl.create(:admin) }

        before do
          sign_in admin
          visit formulas_path
        end

        it { should have_link('delete', href: formula_path(Formula.first)) }
        it "should be able to delete a formula entry" do
          expect { click_link('delete') }.to change( Formula, :count).by(-1)
        end
      end
    end

# begin provisional____________________

# end   provisional____________________

  end

    # Corresponds to "profile page":
  describe "formula page" do

    let(:formula) { FactoryGirl.create(:formula) }
    before { visit formula_path(formula) }

    it { should have_selector('h1',    text: formula.alpha ) }
    it { should have_selector('title', text: formula.alpha ) }
  end

    # Corresponds to "signup page":
  describe "create formula page" do
    # let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in FactoryGirl.create(:admin)
      # sign_in user
      visit add_formula_path 
    end

    it { should have_selector('h1',    text: 'Create formula') }
    it { should have_selector('title', text: 'Create formula') }
  end

    # Isn't this redundant with previous test above? No, that is the form, this is the update (post or put?) 
  describe "create new char" do
    # let(:user) { FactoryGirl.create(:user) }

    before do
      # sign_in user
      sign_in FactoryGirl.create(:admin)
      visit add_formula_path 
    end

    let( :submit) { "Create formula" }

    describe "with invalid information" do
      it "should not create new formulas" do
        expect { click_button submit }.not_to change( Formula, :count)
      end
    end
	# Could make this a helper fn?
    describe "with valid information" do
      let(:new_base )        { "173" }
      let(:new_offset )      { "9" }
      let(:new_subindex )    { "0" }
      let(:new_iform )       { "( 66.2.a ) / (( 66.0 ):<.(( 176.0.b | 170.0 )::173.0.a )) / 27.1" }
      let(:new_word_form )   { "Grass-at-top / ( Plant:<.(( leaves | fruit )::droop )) / ( breath::meet:>surface )" }
      let(:new_abbrev_form ) { "GAT / ( P:<.(( L | F )::D )) / ( B::M:>S )" }
      let(:new_alpha )       { "GATO-PILO-FADO-BAMOS" }

      before do
        fill_in "Base",                  with: new_base
        fill_in "Offset",                with: new_offset
        fill_in "Subindex",              with: new_subindex
        fill_in "Index Formula",         with: new_iform
        fill_in "Word Formula",          with: new_word_form
        fill_in "Abbreviation Formula",  with: new_abbrev_form
        fill_in "Alphabetic String",     with: new_alpha
      end

      it "should create new formulas" do
        expect { click_button submit }.to change( Formula, :count).by(1)
      end

      describe "after saving the new formula information" do
        before { click_button submit }

        # let(:formula) { Formula.find_by_id( Formula.count ) }
        # it { should have_selector('title', text: formula.pinyin ) }
        it { should have_selector('title', text: new_alpha ) }
        it { should have_selector('div.alert.alert-success', text: 'Thank you for the new formula information') }
      end
    end
  end

  describe "edit" do
    # let(:user) { FactoryGirl.create(:user) }
    let(:formula) { FactoryGirl.create(:formula) }

    before do
      # sign_in user
      sign_in FactoryGirl.create(:admin)
      visit edit_formula_path(formula)
    end

    describe "page" do
      it { should have_selector('title', text: "Edit Formula Data") }
      it { should have_selector('h1',    text: "Update Formula Data") }
      # Change this to show the char graphic:
      # it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      let(:new_base )        { "" }
      let(:new_offset )      { "" }
      let(:new_subindex )    { "" }
      let(:new_iform )       { "" }
      let(:new_word_form )   { "" }
      let(:new_abbrev_form ) { "" }
      let(:new_alpha )       { "" }

      before do
        fill_in "Base",                  with: new_base
        fill_in "Offset",                with: new_offset
        fill_in "Subindex",              with: new_subindex
        fill_in "Index Formula",         with: new_iform
        fill_in "Word Formula",          with: new_word_form
        fill_in "Abbreviation Formula",  with: new_abbrev_form
        fill_in "Alphabetic String",     with: new_alpha

        click_button "Save changes"
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_base )        { "173" }
      let(:new_offset )      { "9" }
      let(:new_subindex )    { "0" }
      let(:new_iform )       { "( 66.2.a ) / (( 66.0 ):<.(( 176.0.b | 170.0 )::173.0.a )) / 27.1" }
      let(:new_word_form )   { "Grass-at-top / ( Plant:<.(( leaves | fruit )::droop )) / ( breath::meet:>surface )" }
      let(:new_abbrev_form ) { "GAT / ( P:<.(( L | F )::D )) / ( B::M:>S )" }
      let(:new_alpha )       { "GATO-PILO-FADO-BAMOS" }

        # Need to add test for changing char graphic:
      before do
        fill_in "Base",                  with: new_base
        fill_in "Offset",                with: new_offset
        fill_in "Subindex",              with: new_subindex
        fill_in "Index Formula",         with: new_iform
        fill_in "Word Formula",          with: new_word_form
        fill_in "Abbreviation Formula",  with: new_abbrev_form
        fill_in "Alphabetic String",     with: new_alpha

        click_button "Save changes"
      end

      it { should have_selector('title', text: new_alpha ) }
      it { should have_selector('h1', text: new_alpha ) }
      it { should have_selector('div.alert.alert-success') }

      # it { should have_link('Sign out', href: signout_path) }
      specify { formula.reload.base.should        == new_base }
      specify { formula.reload.offset.should      == new_offset }
      specify { formula.reload.subindex.should    == new_subindex }
      specify { formula.reload.iform.should       == new_iform }
      specify { formula.reload.word_form.should   == new_word_form }
      specify { formula.reload.abbrev_form.should == new_abbrev_form }
      specify { formula.reload.alpha.should       == new_alpha }
    end
  end
end

