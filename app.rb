require "google_drive"
require 'csv'
require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/mairie'

#session = GoogleDrive::Session.from_config("config.json")
#ws = session.spreadsheet_by_key("1U3-Krii5x1oLPrwD5zgn-ry").worksheets[0]

###################################################################################################################

#p ws[2, 1]
