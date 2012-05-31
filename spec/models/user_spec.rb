require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", 
    password: "foobar", password_confirmation: "foobar")}

  subject { @user}

  it {should respond_to (:name)}
  it {should respond_to (:email)}
  it {should respond_to (:password_digest)}
  it {should respond_to (:password)}
  it {should respond_to (:password_confirmation)}
  it {should respond_to (:authenticate)}
  it {should respond_to (:remembered_token)}
  it {should respond_to (:microposts)}
  it {should be_valid}

  describe "When name is not present" do
  	before {@user.name = " "}
  	it {should_not be_valid}
  end
 

  describe "When email is not present" do
  	before {@user.email = " "}
  	it {should_not be_valid}
  end
 
  describe "When name is too long" do
  	before {@user.name =  "a" * 51}
  	it {should_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end 
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "When email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end
    it {should_not be_valid}
  end

  describe "When password is not present" do
    before {@user.password = @user.password_confirmation = " "}
    it {should_not be_valid}
  end

  describe "When password is too short" do
    before {@user.password = @user.password_confirmation = "a" * 4}
    it {should_not be_valid}
  end
  
  describe "When password does not match" do
    before {@user.password_confirmation = "mismatch"}
    it {should_not be_valid}
  end

  describe "When password is nil" do
    before {@user.password_confirmation = nil}
    it {should_not be_valid}
  end


  describe "return value of authenticate method" do
    before {@user.save}
    let(:found_user) {User.find_by_email(@user.email)}
  

  describe "with valid password" do
    it {should == found_user.authenticate(@user.password)}
   end
 
  describe "with remembered_token" do
    its(:remembered_token) {should_not be_blank}
  end

   describe "with invalid password" do
    let (:user_for_invalid_password) {found_user.authenticate('invalid')}

    it {should_not == user_for_invalid_password}
    specify {user_for_invalid_password.should be_false}  
  end
 end 

describe "micropost associations" do
    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
     end
      it "should have the right microposts in the right order" do
      @user.microposts.should == [newer_micropost, older_micropost]
    end

    it "should destroy associated microposts" do
     microposts = @user.microposts
      @user.destroy
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end 
  end

 describe "profil page" do
  let (:user) {FactoryGirl.create(:user)}
  let!(:m1) {FactoryGirl.create(:micropost, user, content: "Foo")}
  let!(:m2) {FactoryGirl.create(:micropost, user, content: "bar")}

  before {visit user_path(user)}

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
     end
  end
end














