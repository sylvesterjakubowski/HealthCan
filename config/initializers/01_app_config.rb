
begin
  APP_CONFIG = YAML.load_file("/etc/healthcan/application.yml")[Rails.env]
rescue
  APP_CONFIG = YAML.load_file("#{Rails.root}/config/application.yml")[Rails.env]
end