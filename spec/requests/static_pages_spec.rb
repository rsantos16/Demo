require 'spec_helper'

describe "StaticPages" do

	subject { page }
  
	describe "Home pages" do
    	
		before {visit home_path}

		it {should have_content('Sample App') }
		it {should have_selector('title', text: "| Home")}
	
	end

 	describe "Contact Pages" do
 		
		before {visit contact_path}

		it {should have_selector('h1', text: 'Contact Info')}

 	end

end
