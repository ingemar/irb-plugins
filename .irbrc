require_relative ".irb/plugins"

plugin "fast_find"
plugin "pg_stat_activity"
plugin "motd", uri: "https://example.org/motd.txt"
plugin "local_irbrc"

theme "fancy_rails"
