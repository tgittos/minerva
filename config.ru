# This file is used by Rack-based servers to start the application.

ENV["RACK_ENV"] = "development"

require ::File.expand_path('../config/environment',  __FILE__)
run Minerva::Application
