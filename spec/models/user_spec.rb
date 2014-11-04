require 'spec_helper'

describe User do
  it "requires passwords to be at least 8 characters long on create and update" do
    expect_validation_error_on_short_password(build(:user))
    expect_validation_error_on_short_password(create(:user))
    expect_no_error_for_eight_char_password(build(:user))
    expect_no_error_for_eight_char_password(create(:user))
  end
end

def expect_validation_error_on_short_password(user)
  user.password = "short67"
  user.password_confirmation = "short67"
  expect(user.save).to be_false
  expect(user.errors[:password]).not_to be_empty
end

def expect_no_error_for_eight_char_password(user)
  user.password = "eight678"
  user.password_confirmation = "eight678"
  expect(user.save).to be_true
end
