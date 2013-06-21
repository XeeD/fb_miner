module Facebook
  class FanPageFetcher
    def initialize(page)
      @page = page
      fetch
    end

    def fetch
      @scrapper = BrowserScrapper.new
      @scrapper.open_page(@page.url)
    end

    def name
      @scrapper.browser.element(css: "h2 span").text.strip
    end

    def fb_id
      @scrapper.browser.element(id: "pagelet_timeline_main_column").attribute_value("data-gt").scan(/\d{4,}/)[0]
    end

    def finished
      @scrapper.close
    end
  end
end
