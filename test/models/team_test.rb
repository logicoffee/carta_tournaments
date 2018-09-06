require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def setup
    @team = Team.new(
      name: "京都大学かるた会",
      leader: "京大太郎",
      email: "taro@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  test "should be valid" do
    assert @team.valid?
  end

  ########## for presence ###########
  test "name should be present" do
    @team.name = "  "
    assert_not @team.valid?
  end

  test "leader should be present" do
    @team.leader = "  "
    assert_not @team.valid?
  end

  test "email should be present" do
    @team.email = "  "
    assert_not @team.valid?
  end

  test "password should be present" do
    @team.password = " "*8
    assert_not @team.valid?
  end

  test "password confirmation should be present" do
    @team.password_confirmation = " "*8
    assert_not @team.valid?
  end

  ########## for uniqueness ############
  test "email should be unique" do
    another_team = @team.dup
    another_team.email = @team.email.upcase
    @team.save
    assert_not another_team.valid?
  end

  ############ for length ##############
  test "name should have maximum length" do
    @team.name = "あ"*51
    assert_not @team.valid?
  end

  test "leader should have maximum length" do
    @team.leader = "あ"*51
    assert_not @team.valid?
  end

  test "email should have maximum length" do
    @team.email = "a"*244 + "@example.com"
    assert_not @team.valid?
  end

  test "password should have minimum length" do
    @team.password = "a"*7
    assert_not @team.valid?
  end

  ############# for format ###############
  test "should accept valid email addresses" do
    valid_addresses = %w[
      CAPItal@ExAmPlE.cOm
      number1@world.com
      under_score@example.com
      p+plus@example.com
      m-minus@example.com
      d.dot@example.com
      test@number1.com
      test@m-minus.com
      test@exam.ple.com
    ]
    valid_addresses.each do |valid_address|
      @team.email = valid_address
      assert @team.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "should reject invalid email addresses" do
    invalid_addresses = %w[
      comma@example,com
      invalid_address.com
      dot@example.
      under@score_example.com
      p@plus+example.com
    ]
    invalid_addresses.each do |invalid_address|
      @team.email = invalid_address
      assert_not @team.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  ########## for callbacks #########
  test "email should be saved as lower case" do
    @team.email.upcase!
    @team.save
    assert_equal @team.email.downcase, @team.reload.email
  end
end
