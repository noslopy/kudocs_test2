class PageVisitsAnalyzer

    def initialize()
        filepath = "#{Rails.root}/log/analytics/analytics.log"
        @page_visit_analytics = scrape_visit_logs filepath
    end

    def pages_by_visitors
        sorted_list = @page_visit_analytics.sort_by {|_key, value| -value[:visitors]}
        sorted_list.map{ |p, v| [p, v[:visitors]] }
    end

    def unique_pageviews
        sorted_list = @page_visit_analytics.sort_by {|_key, value| -value[:unique_visitors].count}
        sorted_list.map{ |p, v| [p, v[:unique_visitors]] }
    end

    private

    def scrape_visit_logs filepath
        page_visit_data = {}
        visit_logs = File.open(filepath)
        visit_logs.each do |entry|
            entry_array = process_log_entry entry
            page, visitor = entry_array[0], entry_array[1]

            visitors = page_visit_data.key?("#{page}") ? page_visit_data["#{page}"][:visitors] : 0
            unique_visitors = page_visit_data.key?("#{page}") ? page_visit_data["#{page}"][:unique_visitors] : []
            unique_visitors << visitor unless unique_visitors.include? visitor

            page_visit_data["#{page}"] = { 'visitors': visitors + 1, 'unique_visitors': unique_visitors }
        end
        page_visit_data
    end

    def process_log_entry entry
        entry_array = entry.split(' ')
        if entry_array.count != 2
            raise 'Log format is not correct'
        end
        entry_array
    end

end