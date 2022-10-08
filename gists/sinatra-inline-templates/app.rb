# frozen_string_literal: true

require 'sinatra'

get '/' do
  haml :index
end

__END__

@@ layout
%html
  != yield

@@ index
%div.title Hello world.
