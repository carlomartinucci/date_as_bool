require 'test_helper'

class DateAsBool::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, DateAsBool
  end

  test "[User] bool_name method defined" do
    user = User.new
    assert user.verified.in?([true, false])
  end

  test "[User] bool_name=true assigns datetime_name to Time.now" do
    user = User.create(verified: true)
    assert user.verified_at.present?
  end

  test "[User] bool_name=false resets datetime_name to nil" do
    user = User.create(verified_at: Time.now)
    user.update(verified: nil)
    assert user.verified_at.nil?
  end

  test "[User] bool_name! works as bool_name=true" do
    user = User.create
    user.verified!
    assert user.verified_at.present?
  end

  test "[User] bool_name? works as bool_name" do
    user = User.create(verified: true)
    assert user.verified?
  end

  test "[UserImplicitBoolName] bool_name method defined" do
    user = UserImplicitBoolName.new
    assert user.verified.in?([true, false])
  end

  test "[UserImplicitBoolName] bool_name=true assigns datetime_name to Time.now" do
    user = UserImplicitBoolName.create(verified: true)
    assert user.verified_at.present?
  end

  test "[UserImplicitBoolName] bool_name=false resets datetime_name to nil" do
    user = UserImplicitBoolName.create(verified_at: Time.now)
    user.update(verified: nil)
    assert user.verified_at.nil?
  end

  test "[UserImplicitBoolName] bool_name! works as bool_name=true" do
    user = UserImplicitBoolName.create
    user.verified!
    assert user.verified_at.present?
  end

  test "[UserImplicitBoolName] bool_name? works as bool_name" do
    user = UserImplicitBoolName.create(verified: true)
    assert user.verified?
  end

end
