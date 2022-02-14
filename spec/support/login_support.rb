module LoginSupport
  def login
    visit login_path
    fill_in "session_email", with: "multi@sample.com"
    fill_in "session_password", with: "multipass"
    find(".login_button").click
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
