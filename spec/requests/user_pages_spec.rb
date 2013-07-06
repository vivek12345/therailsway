require 'spec_helper'

describe "UserPages" do
	subject{page}
  describe "Sign-up page" do
  	before{visit signup_path}
  	it{should have_selector('h1',text:'Sign-up')}
  	it{should have_selector('title',text:my_test('Sign-up'))}
  end

  describe "profile pages" do
  	let(:user) {FactoryGirl.create(:user)}
  	before{visit user_path(user)}
  	it{should have_selector('h1',text: user.name)}
  	it{should have_selector('title',text:user.name)}
  end

  describe "signup" do
  	let(:submit) {"Create my account"}

  	describe "with invalid information" do
  		expect{click_button submit}.not_to change(User,:count)
  	end
  	describe "with valid information" do
  		before do
  			fill_in "Name",with:"Vivek Nayyar"
  			fill_in "Email",with:"vivek.of.nayyar@gmail.com"
  			fill_in "Password",with:"foobar"
  			fill_in "Confirmation",with:"foobar"
  		end
  		expect{click_button submit}.to change(User,:count).by(1)
  	end
  end

  describe "edit page" do
    let(:user) {FactoryGirl.create(:user)}
    before{visit edit_path_user(user)}

    describe "page" do
      it{should have_selector('h1',text:'Update your profile')}
      it{should have_selector('title',text:'Edit user')}
      it{should have_link('change',href:'http://gravatar.com/emails')}
    end

    describe "Invalid information" do
      before{click_button "Save changes"}
      it{should have_content('error')}
    end
  end
  

end
