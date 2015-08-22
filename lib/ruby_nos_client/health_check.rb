require 'mini_check'

module RubyNosClient
  HealthCheck = MiniCheck::RackApp.new.tap do |app|
    app.register("health.application-sample.yml") { File.exists?("config/application-sample.yml")}
    app.register("health.load_application-sample.yml") { YAML.load(File.read("config/application-sample.yml")).is_a?(Hash) }
  end
end
