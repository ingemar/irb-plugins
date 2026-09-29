# frozen_string_literal: true

return unless ENV["RAILS_ENV"] == "development"

class IRB::Plugins::Motd
  class IrbCommand < IRB::Command::Base
    category "Misc"
    description "Display MOTD"
    help_message <<~HELP
      Display the Message of The Day

      Usage: motd
    HELP

    def execute(*)
      motd = IRB::Plugins::Motd.message_of_the_day

      if motd.length > 0
        puts motd
      else
        puts "Nothing there."
      end
    end
  end

  class << self
    attr_accessor :uri

    def path = File.join(Dir.pwd, "tmp", ".motd.txt")

    def daily
      return if File.exist?(path) && File.mtime(path).today?

      puts message_of_the_day
    end

    def message_of_the_day
      require "net/http"

      result = Net::HTTP.get(URI.parse(uri))
      result = result.respond_to?(:force_encoding) ? result.force_encoding("UTF-8") : ""
      File.write(path, result)

      result
    end
  end
end

IRB::Plugins::Motd.uri = @config[:uri]

IRB::Command.register(:motd, IRB::Plugins::Motd::IrbCommand)

IRB::Plugins::Motd.daily
