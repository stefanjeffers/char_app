require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path } 

    let(:heading)    { 'Char App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector 'title', text: '| Home' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "with one micropost" do
        before do
          FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
          sign_in user
          visit root_path
        end

        it { should     have_selector 'span', text: '1 micropost'  }
        it { should_not have_selector 'span', text: '1 microposts' }
      end

      describe "with one micropost with a long word" do
        before do
          FactoryGirl.create(:micropost, user: user, content: "X" * 130 )
          sign_in user
          visit root_path
        end
          # should see the long string broken into strings of at most 30 * 'X', separated, by this HTML code:
        # it { should     have_selector 'span', text: raw( '8203' )} 
        it { should     have_selector 'span', text: "X" * 30 }
        it { should_not have_selector 'span', text: "X" * 31 }
      end

      describe "with two microposts" do
        before do
          FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
          FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
            sign_in user
            visit root_path
        end

        it { should  have_selector 'span', text: '2 microposts'  }
        it "should render the user's feed" do
          user.feed.each do |item|
            page.should have_selector("li##{item.id}", text: item.content)
          end
        end
      end  # describe "with two microposts"
#____________________________________________

      describe "pagination" do

        # before(:all) { 51.times { FactoryGirl.create(:micropost, user: user ) }}
        before do
          51.times { FactoryGirl.create(:micropost, user: user ) }

          sign_in user
          visit root_path
        end

        after(:all)  { Micropost.delete_all }

        it { should have_selector('div.pagination') }

        it "should list each micropost" do
          Micropost.paginate(page: 1).each do |micropost|
            page.should have_selector('li', text: micropost.content )
          end
        end  # it "should list each micropost" 
      end  # describe "pagination"
#____________________________________________

    end  # describe "for signed-in users"
  end  # describe "Home page"

  let(:page_title) { '' }

  describe "Help page" do
    before { visit help_path }

    let(:heading)    { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }

    let(:heading)    { 'About Us' }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }

    let(:heading)    { 'Contact' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up"
    page.should have_selector 'title', text: full_title('Sign up')
  end

end
