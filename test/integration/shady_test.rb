require File.expand_path('../../test_helper', __FILE__)

class ShadyTest < ActionDispatch::IntegrationTest
  include Redmine::I18n

  fixtures :projects, :enabled_modules, :issues, :users, :members,
           :member_roles, :roles, :documents, :attachments, :news,
           :tokens, :journals, :journal_details, :changesets,
           :trackers, :projects_trackers, :issue_statuses, :enumerations,
           :messages, :boards, :repositories, :wikis, :wiki_pages,
           :wiki_contents, :wiki_content_versions, :versions, :comments

  setup do
    # Add permission to Manager role (hence, to jsmith)
    manager_role = Role.find(1)
    manager_role.add_permission!(:use_shady_mode)
  end

  teardown do
    ActionMailer::Base.deliveries.clear
  end

  test "shady button as admin" do
    log_user('admin', 'admin')
    get '/'

    assert_select '#account a.shady-mode'
  end

  test "shady button as authorized" do
    log_user('jsmith', 'jsmith')
    get '/'

    assert_select '#account a.shady-mode'
  end

  test "shady button as unauthorized" do
    log_user('dlopper', 'foo')
    get '/'

    assert_select '#account a.shady-mode', false
  end

  test "issue notification triggered by shady user" do
    log_user('jsmith', 'jsmith')
    shade_on

    deliver_sample_mail

    assert_nil last_mail
  end

  test "issue notification triggered by honest user" do
    log_user('dlopper', 'foo')
    assert_nil User.current.pref[:shady]

    deliver_sample_mail

    assert_not_nil last_mail
  end

  test "toggle shady mode as authorized" do
    log_user('jsmith', 'jsmith')
    get '/'
    shade_on

    assert_select '#shady-bar'

    delete '/shady_mode', nil, { 'HTTP_REFERER' => request.path }
    follow_redirect!

    assert_select '#shady-bar', false
  end

  test "toggle shady move as unauthorized" do
    log_user('dlopper', 'foo')
    get '/'

    post '/shady_mode', nil, { 'HTTP_REFERER' => request.path }

    assert_response 403
    assert_nil User.current.pref[:shady]
  end

  private

  def log_user(login, password)
    get "/login"
    post "/login", :username => login, :password => password

    assert_not_nil session[:user_id]
    assert_equal login, User.find(session[:user_id]).login
  end

  def last_mail
    ActionMailer::Base.deliveries.last
  end

  def shade_on
    post '/shady_mode', nil, { 'HTTP_REFERER' => request.path }
    follow_redirect!

    assert_not_nil User.current.pref[:shady]
  end

  def deliver_sample_mail
    mail = ActionMailer::Base.mail from: "me@example.com",
                                   to: "you@example.com",
                                   subject: "Hello",
                                   body: "Hello, World!"
    mail.deliver
  end
end
