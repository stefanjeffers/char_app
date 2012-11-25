require 'spec_helper'
# require 'factory_girl'
# require 'factories'

describe "User pages" do

  subject { page }

  describe "index" do

    let(:user) { FactoryGirl.create(:user, email: "indexuser@other.com") }
      # Note: "before(:each)" is a synonym for "before":
    before(:each) do
      # sign_in FactoryGirl.create(:user)
      # FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      # FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      # visit users_path
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end  # it "should list each user" 
    end  # describe "pagination"

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin, email: "admin1@other.com" ) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }

        describe "should not be able to delete self" do
          let( :initial ) { User.count } # Not useful
          before { delete user_path( admin ) } # ;  final = User.count }
          let( :final ) { User.count } # Not useful
          let( :diff ) { initial - final } # Not useful
          # OK: before { delete user_path( User.first) }
          # OK: before { delete user_path( User.find_by_admin( true ) ) }
          # expect { delete user_path(admin) }.not_to change(User, :count)
          # specify { diff.should_not be 
          # specify { admin.reload.admin.should == ? }
          # specify { initial == final } 
          specify { admin.should be_admin } # doesn't seem to do anything
          specify { response.should redirect_to( root_path) } # Only this seems to work
          # specify { (delete user_path( admin )).should_not redirect_to(root_path) }
          # specify { (delete user_path( admin )).should_not  change(User, :count) }
          # final = User.count
          # initial.should == final
          # @temp = change(User, :count) 
          # it { should_not change(User, :count) }
        end
      end  # describe "as an admin user"

      describe "admin user should not be able to delete self" do
        # let(:admin) { FactoryGirl.create(:admin, email: "admin2@other.com" ) }
        before do
        #  sign_in admin
        #  visit users_path
        # delete user_path( admin )
        end
        # specify { response.should_not redirect_to(root_path) }
        # it { should_not change(User, :count) }
      end  # describe "admin user"
    end  # describe "delete links"
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user, email: "profile1user@other.com") }
    let!(:m1)  { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2)  { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before { visit user_path(user) }
    after(:each)  { User.delete_all }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end

    describe "micropost delete links" do
      let(:other_user) { FactoryGirl.create(:user, email: "otheruser@other.com") }
      let!(:m1)  { FactoryGirl.create(:micropost, user: other_user, content: "Foo") }
      let!(:m2)  { FactoryGirl.create(:micropost, user: other_user, content: "Bar") }

      before do
        sign_in user
        visit user_path( other_user)
      end

      it { should_not have_link('delete') }
    end

    describe "pagination" do
      # Check later: this line seemed to cause the "email already taken error". But how?
      # before(:all) { 51.times { FactoryGirl.create(:micropost, user: user ) }}
      before do
        51.times { FactoryGirl.create(:micropost, user: user ) }

        sign_in user
        visit user_path( user)
      end

      after(:all)  { Micropost.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each micropost" do
        Micropost.paginate(page: 1).each do |micropost|
          page.should have_selector('li', text: micropost.content )
        end
      end  # it "should list each micropost" 
    end  # describe "pagination"

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Follow" }
          it { should have_selector('input', value: 'Unfollow') }
        end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Unfollow"
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unfollow" }
          it { should have_selector('input', value: 'Follow') }
        end
      end
    end # describe "follow/unfollow buttons"
#__________________________
# For Problem 4, Section 11.5:

    describe "follower/following counts" do
      let(:other_user) { FactoryGirl.create(:user) }

      before do
        sign_in user   # Not necessary 
        sign_in other_user  # Not necessary

        other_user.follow!(user)
        visit user_path(user)
      end

      it { should have_link("0 following", href: following_user_path(user)) }
      it { should have_link("1 followers", href: followers_user_path(user)) }
    end
#__________________________

  end # describe "profile page"

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    # it { should have_selector('title', text: full_title('Sign up')) }
    it { should have_selector('title', text: 'Sign up') }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",             with: "Example User"
        fill_in "Email",            with: "user@example.com"
        fill_in "Password",         with: "foobar"
        fill_in "Confirm Password", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }

        it { should have_link('Sign out') }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user, email: "edituser@other.com") }
    # before { visit edit_user_path(user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
         # This works because password confirmation is not filled in?
      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end
  end

  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "followed users" do
      before do
        sign_in user
        visit following_user_path(user)
      end

      it { should have_selector('title', text: full_title('Following')) }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end

    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_selector('title', text: full_title('Followers')) }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end

end

