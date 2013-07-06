require 'spec_helper'

describe "LoginPages" do
	subject{page}

  describe "Home page" do
  	before{visit root_path}
  	it{should have_selector('h1',text:'My home page')}
  	it{should have_selector('title',text:my_test('Home'))}	
  	it "should have right links on the layout" do
  		click_link "Sign-Up"
  		page.should have_selector('h1',text:'Sign-up')
  	end

  	end

  describe "Help page" do
  	before{visit help_path}

  	it{should have_selector('h1',text:'My help page')}
  	it{should have_selector('title',text:my_test('Help'))}
  end

  describe "About page" do
  	before{visit about_path}

  	it{should have_selector('h1',text:'My About page')}
  	it{should have_selector('title',text:my_test('About'))}
  end
  


end
