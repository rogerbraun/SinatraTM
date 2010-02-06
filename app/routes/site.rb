class Main
  get "/" do
    haml :home
  end

  post "/translation" do

    translation = Translation.new(:source => params[:source], :target => params[:target])
    translation.save
    
    redirect "/"

  end

  get "/fuzzy/?" do
    
    @matches = get_best_matches(params[:q]) || []

    haml :fuzzy     

  end

end
