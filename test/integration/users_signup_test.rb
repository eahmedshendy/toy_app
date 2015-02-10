require 'test_helper'
# The main purpose of our test is to verify that clicking the signup button
# results in not creating a new user when the submitted information is invalid.
class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, user: { name: '',
                               email: "foo@invalid",
                               password:              "foo",
                               password_confirmation: "bar"}
    end
    assert_template 'users/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post_via_redirect users_path, user: {name:  "Example User",
                                           email: "user@example.com",
                                           password:              "123456",
                                           password_confirmation: "123456"}
    end
    assert_template 'users/show'
  end
end
