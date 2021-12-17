require 'json'
require './lib/analytics/page_visits_analyzer'

class AnalyticsController < ActionController::Base

    def pages_by_pageviews
        pva = PageVisitsAnalyzer.new
        render json: JSON.pretty_generate(pva.pages_by_visitors)
    end

    def unique_pageviews
        pva = PageVisitsAnalyzer.new
        render json: JSON.pretty_generate(pva.unique_pageviews)
    end

end
