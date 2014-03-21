# RAILS_ROOT = File.dirname(__FILE__) + '/..'
every 6.hours do
  rake "import"
end