require 'spec_helper'
include ApplicationHelper


describe "UserPages" do

	subject { page }

  describe "Users Signup pages" do
  	
  	before {visit signup_path}
   
	it {should have_selector('h1', text: "Signup")} 
	it {should have_selector('title', text: full_title('Sign up'))}
       
  end
end
