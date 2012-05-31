require 'spec_helper'

describe Micropost do
  
  let (:user) {FactoryGirl.create(:user)}
  before do
  	@micropost = user.microposts.build(content: "Lorem ipsum")
  end

  subject {@micropost}

  it {should respond_to (:content)}
  it {should respond_to(:user_id)}
  it {should respond_to(:user)}
  its(:user) {should == user}

  it {should be_valid}

  describe "when user_id is not present" do
  	before {@micropost.user_id = nil}

  	it {should_not be_valid}
  end

  describe "accessible attributes" do
  	it "should not allow access to user_id" do
  		expect do
  			Micropost.new(user_id: user.id)
  		end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end

  describe "with blank content" do
  	before {@micropost.content = " "}
  	it {should_not be_valid}
  end

  describe "with content that is too long" do
  	before {@micropost.content = "a" * 141}

  	it {should_not be_valid}

  end

  describe "Micropost pages" do
    subject {page}

    let(:user) {FactoryGirl.create(:user)}
    before {sign_in user}

    describe "micropost creation" do
      before {visit root_path}

      describe "with invalid information" do
        it "should not create micropost" do
          expect {click_button "Post"}.should_not change(Micropost, :count)
      end
      describe "error messages" do
        before {click_button "Post"}
        it {should have_content('error')}
      end
    end

   describe "with valid information" do

     before {fill_in 'micropost_content', with: "Lorem ipsum"}

      it "should create a micropost" do
        expect {click_button "Post"}.should change(Micropost, :count).by(1)
      end
   end
  end
end
end
