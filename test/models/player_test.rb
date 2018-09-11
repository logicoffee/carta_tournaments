require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def setup
    @player = teams(:kyoto).players.build(
      last_name:       "阪大",
      first_name:      "太郎",
      last_name_kana:  "はんだい",
      first_name_kana: "たろう",
      rank_code:       "C"
    )
  end

  test "should be valid" do
    assert @player.valid?, @player.errors.full_messages.inspect
  end

  ######## for presence ########

  test "last name should be present" do
    @player.last_name = "  "
    assert_not @player.valid?
  end

  test "first name should be present" do
    @player.first_name = "  "
    assert_not @player.valid?
  end

  test "last name kana should be present" do
    @player.last_name_kana = "  "
    assert_not @player.valid?
  end

  test "first name kana should be present" do
    @player.first_name_kana = "  "
    assert_not @player.valid?
  end

  test "rank code should be present" do
    @player.rank_code = " "
    assert_not @player.valid?
  end

  test "team id should be present" do
    @player.team_id = nil
    assert_not @player.valid?
  end

  ######### for length ########

  test "last name should have maximum length" do
    @player.last_name = "阪" * 31
    assert_not @player.valid?
  end

  test "first name should have maximum length" do
    @player.first_name = "阪" * 31
    assert_not @player.valid?
  end

  test "last name kana should have maximum length" do
    @player.last_name_kana = "あ" * 51
    assert_not @player.valid?
  end

  test "first name kana should have maximum length" do
    @player.first_name_kana = "あ" * 51
    assert_not @player.valid?
  end

  ######## for format ########

  test "last name kana should be Hiragana" do
    @player.last_name_kana = "はん大"
    assert_not @player.valid?
  end

  test "first name kana should be Hiragana" do
    @player.first_name_kana = "こんぴゅう太"
    assert_not @player.valid?
  end

  test "should accept valid rank codes" do
    valid_codes = %w[C D E]
    valid_codes.each do |code|
      @player.rank_code = code
      assert @player.valid?, "#{code} should be valid"
    end
  end

  test "should reject invalid rank codes" do
    invalid_codes = %w[A B F G CD]
    invalid_codes.each do |code|
      @player.rank_code = code
      assert_not @player.valid?, "#{code} should be invalid"
    end
  end
end
