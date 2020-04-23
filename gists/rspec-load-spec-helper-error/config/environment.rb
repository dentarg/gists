# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("..", __dir__))

# Gems
Bundler.require(:default)

# Controllers
require "app/controllers/base_controller"
require "app/controllers/home_controller"
require "app/controllers/bar_controller"
require "app/controllers/foo_controller"
