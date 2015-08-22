require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
	@user = User.new(name:"Marc", email:"marc@gmail.com")
	end

	test "should be valid" do 
		assert @user.valid?
	end

	test "name should be present" do
	@user.name = "    "
	assert_not @user.valid?
	end 

	test "name should have less than 50 characters" do
	@user.name = "a" * 51
	assert_not @user.valid?
	end

	test "email should be present" do
	@user.email = "    "
	assert_not @user.valid?
	end 

	test "email should have less than 256 characters" do
	@user.email = "a" * 244 + "@example.com"
	assert_not @user.valid?
	end

	test "email validation should accept valid addresses" do
		valid_addresses = %w[fjiofjzeijf@tata.com ugrhzih.hieuah@fzfe.com fiezoifepoez@feuzf.efi.com gergr+gte@jije.fr]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, " #{valid_address.inspect} should be valid"
		end
	end

	test "email validation should not accept invalid addresses" do
		invalid_addresses = %w[	]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, " #{invalid_address.inspect} should be invalid"
		end
	end

	test "email addresses should be unique" do
		duplicated_user = @user.dup
		duplicated_user.email = @user.email.upcase
		@user.save
		assert_not duplicated_user.valid? 
	end
end
