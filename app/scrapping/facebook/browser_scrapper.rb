module Facebook
  class BrowserScrapper
    attr_reader :browser

    def initialize
      @browser = Watir::Browser.new :firefox
      @browser.goto("https://www.facebook.com/")
    end

    def close

    end

    def open_page(page)
      info "opening #{page}"

      unless logged_in?
        log_in!
        info "again opening #{page}"
        @browser.goto(page)
      end
    end

    def logged_in?
      !@browser.element(id: "loginbutton").present?
    end

    def log_in!
      user = User.random_user

      log_in_form = @browser.forms.first

      email_field = log_in_form.text_field id: "email"
      email_field.set user.email

      password_field = log_in_form.text_field id: "pass"
      password_field.set user.password

      log_in_form.submit

      info "Logging in #{user.email}"
    end


    private

    def info(message)
      puts message
    end

    def facebook_url(path)
      "http://facebook.com/#{path}"
    end

    class User
      attr_reader :email, :password

      def initialize(email, password)
        @email, @password = email, password
      end

      def self.random_user
        load_users unless @users_loaded
        @users.sample
      end


      private

      def self.load_users
        credentials = File.open(ENV["FACEBOOK_CREDENTIALS_FILE"], "r") do |f|
          f.
              read.
              split(/\n/).
              reject { |line| line.empty? }.
              map { |line| line.split(/\t/) }
        end

        @users_loaded = true
        p credentials

        # Create User instances
        @users = credentials.map { |user_credentials| User.new(*user_credentials) }
      end
    end
  end
end
