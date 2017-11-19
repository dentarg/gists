require 'sinatra'
require 'sinatra/multi_route'
require 'sinatra/reloader' if development?

#get '/' do
#  system "osascript -e 'tell application \"Spotify\"' -e 'next track' -e 'end tell'"
#end

def current_volume
  `osascript -e "get volume settings"`.match(/(\d+)/).captures.first.to_i
end

def increase_volume
  set_volume(current_volume + 6)
end

def decrease_volume
  set_volume(current_volume - 6)
end

def set_volume(volume)
  `osascript -e "set volume output volume #{volume}"`
end

helpers do
  def ui(route: '')
    %(<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js"></script>
          <script type="text/javascript">
            $(document).ready(function() {
              $("a").click(function(e) {
                e.preventDefault();
                $.get('#{route}' + $(this).attr("data"));
                if ($(this).attr("data") == "pause") {
                  $(this).attr("data", "play");
                  $(this).text("⏯");
                } else if ($(this).attr("data") == "play") {
                  $(this).attr("data", "pause");
                  $(this).text("⏯");
                }
              });
            });
          </script>

    <div style="font-size: 600%;">
    <h1>#{route.empty? ? 'Spotify' : route[1..-2].capitalize}</h1>
    <a style="text-decoration: none;" href="#" data="prev">⏮</a> &nbsp;
    <a style="text-decoration: none;" href="#" data="pause">⏯</a> &nbsp;
    <a style="text-decoration: none;" href="#" data="next">⏭</a>
    <p>
    <code>
    <a style="text-decoration: none;" href="#" data="volume_up">volume up &nbsp;➕</a>
    <br/>
    <a style="text-decoration: none;" href="#" data="volume_down">volume down➖</a>
    </code>
    </p>
    </div>)
  end
end

get '/safari' do
  `osascript -e 'tell application "Safari" to activate'`

  body ui(route: '/safari/')
end

get '/safari/play', '/safari/pause' do
  `osascript -e 'tell application "System Events" to keystroke Space'`
end

get '/' do
  `osascript -e 'tell application "Spotify" to activate'`
  body ui
end

get '/next' do
  `osascript -e 'tell application "Spotify" to next track'`
end

get '/prev' do
  `osascript -e 'tell application "Spotify" to previous track'`
end

get '/play' do
  `osascript -e 'tell application "Spotify" to play'`
end

get '/pause' do
  `osascript -e 'tell application "Spotify" to pause'`
end

get '/volume_up', '/safari/volume_up' do
  increase_volume
end

get '/volume_down', '/safari/volume_down' do
  decrease_volume
end
