class Application < Sinatra::Application
  use Rack::Static, :urls => ["/stylesheets", "/javascripts"], :root => "public"
  
  configure do
    set :calculated_session => lambda{ Calculated::Session.create(:api_key => ENV["CC_API_KEY"])}
  end
  
  get "/" do
    File.read(File.join('public', 'index.html'))
  end
  
  get '/electric_bills/calculate' do
    content_type :json
    if kwh = params[:kwh]      
      result = settings.calculated_session.answer_for_computation("4d00f89cdfde7b3b98000002",  {:fuel => "4d011c91fa85f343d70000f3", :formula_input_name => "emissions_per_kwh", :amount => kwh })
      result["calculations"].to_json
    else
      {:error => "Calculation Could not be Reached"}.to_json
    end
  end

end
