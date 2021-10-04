Rails.application.routes.draw do
  
  Dir.glob(File.expand_path('../engines/*', __dir__)).each do |path|
    engine = File.basename(path)
    mount engine.classify.constantize::Engine, at: '/'
  end

  mount Root::API => '/'
end
