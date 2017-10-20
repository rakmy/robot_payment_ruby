# frozen_string_literal: true
module RobotPayment
  module Generators
    # rails g robot_payment:config
    class ConfigGenerator < Rails::Generators::Base # :nodoc:
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def copy_config_file
        template 'robot_payment_config.rb', 'config/initializers/robot_payment_config.rb'
      end
    end
  end
end