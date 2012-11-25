require 'spec_helper'

describe "Front page" do
	it "should be the login page by default" do
		visit root_path
		page.should have_content("Amahi Server Login")
	end

	it "should be the dashboard if \"guest dashboard\" is enabled" do
		setting = create(:setting, name: "guest-dashboard", value: "1")
		visit root_path
		page.should have_content("Dashboard")
	end

	it "should be the login page if \"guest dashboard\" is disabled" do
		setting = create(:setting, name: "guest-dashboard", value: "0")
		visit root_path
		page.should have_content("Amahi Server Login")
	end

	it "should allow a user with proper username/password to login" do
		user = create(:user)
		visit root_path
		page.should have_content("Amahi Server Login")
		fill_in "username", :with => user.login
		fill_in "password", :with => "secret"
		click_button "Log In"
		page.should have_content("Dashboard")
		page.should have_content("Logout")
	end

	it "should not allow a user with bad username to login" do
		user = create(:user)
		visit root_path
		page.should have_content("Amahi Server Login")
		fill_in "username", :with => "bogus"
		fill_in "password", :with => "secret"
		click_button "Log In"
		page.should have_content("Error: Incorrect username or password")
		page.should have_content("Amahi Server Login")
	end

	it "should not allow a user with bad password to login" do
		user = create(:user)
		visit root_path
		page.should have_content("Amahi Server Login")
		fill_in "username", :with => user.login
		fill_in "password", :with => "bogus"
		click_button "Log In"
		page.should have_content("Error: Incorrect username or password")
		page.should have_content("Amahi Server Login")
	end

	it "should allow a user with proper username/password to login and also logout" do
		user = create(:user)
		visit root_path
		page.should have_content("Amahi Server Login")
		fill_in "username", :with => user.login
		fill_in "password", :with => "secret"
		click_button "Log In"
		page.should have_content("Dashboard")
		page.should have_content("Logout")
		click_link "Logout"
		page.should have_content("Amahi Server Login")
	end
end
