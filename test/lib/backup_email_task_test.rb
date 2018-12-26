require 'test_helper'

class BackupEmailTaskTest < ActionDispatch::IntegrationTest
  def setup
    @emails = ActionMailer::Base.deliveries
    @emails.clear
    Myapp::Application.load_tasks
  end

  test "daily task for backup email" do
    Rake::Task['backup:email_csv'].invoke
    assert_equal Tournament.count, @emails.count
    @emails.each do |email|
      assert_equal 1, email.attachments.count
    end
  end
end
