require 'sinatra'
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

get '/' do
  head = '<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js"></script>
          <script type="text/javascript">
            $(document).ready(function() {
              $("a").click(function(e) {
                e.preventDefault();
                $.get($(this).attr("data"));
                if ($(this).attr("data") == "pause") {
                  $(this).attr("data", "play");
                  $(this).text(">");
                } else if ($(this).attr("data") == "play") {
                  $(this).attr("data", "pause");
                  $(this).text("||");
                }
              });
            });
          </script>'
  body = '<div style="font-size: 400%; text-decoration: none">
  <a href="#" data="prev">&lt;&lt;</a> -
  <a href="#" data="pause">||</a> -
  <a href="#" data="next">&gt;&gt;</a>
  <p>
  volume up <a href="#" data="volume_up">+</a> <br/>
  volume down <a href="#" data="volume_down">-</a></div>'

  `osascript -e 'tell application "Spotify" to activate'`
  return head + body
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

get '/volume_up' do
  increase_volume
end

get '/volume_down' do
  decrease_volume
end
