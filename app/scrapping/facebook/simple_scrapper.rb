module Facebook
  class SimpleScrapper
    def initialize
      @agent = Mechanize.new do |agent|
        agent.user_agent = "Mac Firefox"

        proxy = ProxySettings.new
        if proxy.proxy_set?
          agent.set_proxy proxy[:address], proxy[:port], proxy[:user], proxy[:password]
        end
      end
    end

    def fetch_page(url)
      @agent.get(url)
      @agent.page
    end


    #protected

    class ProxySettings
      def proxy_set?
        self[:address].present?
      end

      def [](key)
        ENV["SCRAPPING_PROXY_#{key.to_s.upcase}"]
      end
    end
  end
end
