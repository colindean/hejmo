#!/usr/bin/env ruby

require 'mkmf' #this is dangerous, internal use only for extconf.rb
require 'date'

unless find_executable('trash')
  puts "Unable to find trash executable. Install it:\n\tbrew install trash"
  exit 1
end
if File.exists? "mkmf.log"
  puts "Removing temporary mkmf file…"
  File.delete "mkmf.log"
end

class FileWithTime
    REGEX = /(\d{4}-\d{2}-\d{2}) at (\d{1,2}\.\d{2}\.\d{2})( [AP]M)?/

    attr_reader :filename

    def initialize filename
      @filename = filename
    end

    def file
      @file ||= File.new filename
    end

    def basename
      `basename "#{filename}"`.strip
    end

    def timestamp
      @timestamp ||= extract_timestamp
    end

    def age_in_days
      (::DateTime.now - timestamp).to_i
    end

    def extract_timestamp
      matches = REGEX.match(@filename)
      date = matches[1]
      time = matches[2].gsub('.', ':')
      timestamp_text = [date, time].join " "
      ::DateTime.parse timestamp_text
    end

    def to_s
      "#{age_in_days.to_s.rjust(3)}d ┣ #{basename}"
    end
end

DRY_RUN = ENV['DRY_RUN'] || false
SCREENSHOT_GLOB = ENV['SCREENSHOT_GLOB'] || "#{ENV['HOME']}/Desktop/Screen Shot**"
ARCHIVE_GLOB = ENV['ARCHIVE_GLOB'] || "#{ENV['HOME']}/Desktop/Screenshot Archive/Screen Shot**"
ARCHIVE_DIR = `dirname "#{ARCHIVE_GLOB}"`.strip

def trash entry
  puts "🗑 ⬅ #{entry}"
  `trash "#{entry.filename}"` unless DRY_RUN
end

def archive entry
  puts "🗄 ⬅ #{entry}"
  unless Dir.exists? ARCHIVE_DIR
    puts "Creating #{ARCHIVE_DIR}"
    Dir.mkdir ARCHIVE_DIR
  end
  File.rename entry.filename, [ARCHIVE_DIR, entry.basename].join(File::SEPARATOR) unless DRY_RUN
end


# clean archive
Dir[ARCHIVE_GLOB].each do |e|
  entry = FileWithTime.new e
  if entry.age_in_days > 15
    trash entry
  else
    puts "🗄 ⬇ #{entry}"
  end
end
Dir[SCREENSHOT_GLOB].each do |e|
  entry = FileWithTime.new e
  if entry.age_in_days > 7
    archive entry
  else
    puts "📂 ⬇ #{entry}"
  end
end

