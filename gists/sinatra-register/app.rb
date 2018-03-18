require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/asset_pipeline'

class App < Sinatra::Base
  register Sinatra::AssetPipeline

  get '/' do
    'hi'
  end
end
