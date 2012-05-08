require 'spec_helper'

describe "StaticPages" do

	subject { page }
  
	describe "Home pages" do
    	
		before {visit home_path}

		it "should have the content Sample App" do
		 page.should have_content('Sample App') 
		 page.should have_selector('title', text: "| Home")

		end
	end


 	describe "Contact Pages" do
 		subject {page}
 		before {visit contact_path}
 		it "Should have the content - Contact" do
 			
 		page.should have_selector('h1', text: "Contact Info")

 		end
 	end

end
