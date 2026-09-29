# frozen_string_literal: true

return unless defined?(Rails)

application_name = "\033[38;2;255;132;182m#{Rails.application.class.module_parent.name}\033[0m"
rails_environment =
  case Rails.env
  when "production"
    "\033[38;2;218;40;27mProduction\033[0m"
  when "staging"
    "\033[38;2;255;204;108mStaging\033[0m"
  else
    "\033[38;2;0;204;112m#{Rails.env}\033[0m"
  end
prompt = "#{application_name}[#{rails_environment}]:%03n"

# defining custom prompt
IRB.conf[:PROMPT][:RAILS] = {
  PROMPT_I: "#{prompt}> ",
  PROMPT_S: "#{prompt}%l ",
  PROMPT_C: "#{prompt}* ",
  RETURN: " => %s\n"
}

# Setting our custom prompt as prompt mode
IRB.conf[:PROMPT_MODE] = :RAILS
