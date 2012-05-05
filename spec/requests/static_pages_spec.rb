require 'spec_helper'

describe "StaticPages" do
  
	describe "Home pages" do
		it "should have the content Sample App" do
		 visit '/static_pages/home'
		 page.should have_content('Sample App')
		end
	end

 	describe "Hello Page" do
 		it "should have the content  - Hello World" do
 		 visit '/static_pages/hello'
 		 page.should have_selector('p', text: 'Hello World')	
 		end
 	end

end
