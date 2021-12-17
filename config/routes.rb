Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/analytics' do
    get '/pages-by-pageviews', to: 'analytics#pages_by_pageviews'
    get '/unique-pageviews', to: 'analytics#unique_pageviews'
  end

end
