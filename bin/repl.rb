#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), ".."))

ENV["RACK_ENV"] = "development"

require "pry"
require "web/router"

puts "
  ███╗   ███╗███████╗███████╗████████╗██╗
  ████╗ ████║██╔════╝██╔════╝╚══██╔══╝██║
  ██╔████╔██║█████╗  █████╗     ██║   ██║
  ██║╚██╔╝██║██╔══╝  ██╔══╝     ██║   ╚═╝
  ██║ ╚═╝ ██║███████╗███████╗   ██║   ██╗
  ╚═╝     ╚═╝╚══════╝╚══════╝   ╚═╝   ╚═╝

"

Pry.start_with_pry_byebug
