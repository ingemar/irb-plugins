# frozen_string_literal: true

# rubocop:disable Naming/BinaryOperatorParameterName
# rubocop:disable Style/MixinUsage

module IRB
  module Plugins
    BASE_PATH = Pathname.new(Dir.pwd).join(".irb")
    PLUGIN_PATH = BASE_PATH.join("plugins")
    THEME_PATH = BASE_PATH.join("themes")

    def plugin(name, **config)
      @config = config
      $LOAD_PATH.unshift(PLUGIN_PATH.to_s)

      load PLUGIN_PATH.join("#{name}.rb")
    ensure
      remove_instance_variable(:@config) if instance_variable_defined?(:@config)
      $LOAD_PATH.delete(PLUGIN_PATH.to_s)
    end

    def theme(name)
      $LOAD_PATH.unshift(THEME_PATH.to_s)

      load THEME_PATH.join("#{name}.rb")
    ensure
      $LOAD_PATH.delete(THEME_PATH.to_s)
    end
  end
end

extend IRB::Plugins
# rubocop:enable Naming/BinaryOperatorParameterName
# rubocop:enable Style/MixinUsage
