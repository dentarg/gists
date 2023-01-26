require "sinatra"

system "mkdir", "-p", "./public/uploads"

UPLOADS_PATH = File.join(settings.public_folder, "uploads")

get "/" do
  body "/"
end

post "/upload" do
  if params[:video] && params[:video][:filename]
    @filename = params[:video][:filename]
    video_path = File.join(UPLOADS_PATH, @filename)
    FileUtils.mkdir_p(UPLOADS_PATH)
    IO.copy_stream(params[:video][:tempfile].open, video_path)
  end
  body "/upload"
end

run Sinatra::Application
