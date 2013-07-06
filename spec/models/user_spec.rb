require 'spec_helper'

describe User do

  before{@user=User.new(:name=>"vivek",:email=>"vivek.of.nayyar@gmail.com",:password=>"foobar",:password_confirmation=>"foobar")}
  subject{@user}
  it{should respond_to(:name)}
  it{should respond_to(:email)}
  it{should respond_to(:password)}
  it{should respond_to(:password_confirmation)}
  it{should respond_to(:password_digest)}
  it{should respond_to(:remember_token)}

  describe "the name should not be empty" do
  	before{@user.name=""}
  	it{should_not be_valid}
  end
  describe "the email should not be empty" do
  	before{@user.email=""}
  	it{should_not be_valid}
  end

  describe "the name is too long" do
  	before{@user.name="a"*51}
  	it{should_not be_valid}
  end

  describe "the email should be invalid" do
  	it "should be invalid" do
  		addresses=%w[vivek.of.nayyar@.com suchita.gmail.com anil@]
  		addresses.each do |invalid|
  			@user.email=invalid
  			@user.should_not be_valid
  		end
  	end
  end

  describe "the email should be valid" do
  	it "should be valid" do
  		addresses=%w[vivek.of.nayyar@gmail.com suchita@yahoo.com anil@rediffmail.com]
  		addresses.each do |valid|
  			@user.email=valid
  			@user.should be_valid
  		end
  	end
  end

  describe "the email is already taken" do
  	before do
  		user_with_same_email=@user.dup
  		user_with_same_email.email=@user.email.upcase
  		user_with_same_email.save
  	end
  	it{should_not be_valid}
  end

  describe "the password and confirm is empty" do
  	before{@user.password=@user.password_confirmation=""}
  	it{should_not be_valid}
  end

  describe "the passwords dont match" do
  	before{@user.password="mismatch"}
  	it{should_not be_valid}
  end

  describe "the password confirm is nil should be invalid" do
  	before{@user.password_confirmation=nil}
  	it{should_not be_valid}
  end

  it{should respond_to(:authenticate)}

  describe "password is too short" do
  	before{@user.password="a"*5}
  	it{should_not be_valid}
  end

  describe "authentication output" do
  	before{@user.save}
  	let(:found_user) {User.find_by_email(@user.email)}

  	describe "user with valid password" do
  		it{should==found_user.authenticate(@user.password)}
  	end

  	describe "user with invalid password" do
  		let(:user_with_invalid_pass) {found_user.authenticate("invalid")}

  		it{should_not==user_with_invalid_pass}
  		specify{user_with_invalid_pass.should be_false}
  	end
  end

  describe "remember_token" do
    before{@user.save}
    its(:remember_token) {should_not blank}
  end
end
