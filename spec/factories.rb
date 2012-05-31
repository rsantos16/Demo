FactoryGirl.define do
	factory :user do
		name "Ruddy Santos"
		email "example@railstutorial.org"
		password "foobar"
		password_confirmation "foobar"

    factory :admin do
    	admin true
      end
	end

	factory :micropost do
		content "Lorem Ipsum"
		user
	end
end