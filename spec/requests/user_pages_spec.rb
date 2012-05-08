require 'spec_helper'
include ApplicationHelper

describe "UserPages" do
  describe "Users Signup pages" do
  	before {visit signup_path}
    
    it "Should have content Signup" do
    	page.should have_selector('h1', text: "Signup")
    	page.should have_selector('title', text: full_title('Sign up'))
    end
    
  end
end
