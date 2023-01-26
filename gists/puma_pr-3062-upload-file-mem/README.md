For https://github.com/puma/puma/pull/3062

Start Puma

    bundle exec puma -p 9090 --config puma.rb -w 1
    BUNDLE_GEMFILE=pr-3062_Gemfile bundle exec puma -p 9090 --config puma.rb -w 1

Upload file

    curl --form "video=@adam.webm" http://0.0.0.0:9090/upload

