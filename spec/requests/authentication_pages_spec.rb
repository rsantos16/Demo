require 'spec_helper'

describe "Authentication" do
 
  subject { page }

  describe "signin page" do
  	before {visit signin_path}

  	it { should have_selector('h1', text: 'Sign in')}
  	it { should have_selector('title', text: 'Sign in')}
  end

  describe "with invalid information" do
  	let(:user) {FactoryGirl.create(:user)}
  	before do
      visit signin_path
  		fill_in "Email", with: user.email
  		fill_in "Password", with: user.password
  		click_button "Sign in"
  	end

  	it {should have_selector('title', text: user.name)}
  	it {should have_link('Profile', href: user_path(user))}
  	it {should have_link('Sign out', href: signout_path)}
  	it {should_not have_link('Sign in', href: signin_path)}
  end

  describe "after visiting another page" do
  	before do 
      visit signin_path
      click_link 'Home'
    end
  	it {should_not have_selector('div.alert.alert-error')}
  end

  describe "visiting the user index" do
    before { visit users_path}
    it {should have_selector('title', text: 'Sign in')}
  end

end
