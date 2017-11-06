# frozen_string_literal: true

module RobotPayment
  # Configures global settings for RobotPayment
  #   RobotPayment.configure do |config|
  #     config.aid = 123456
  #   end
  class << self
    def configure
      yield config
    end

    def config
      @_config ||= Config.new
    end
  end

  class Config
    attr_accessor :aid, :rt, :jb, :max_amount, :min_amount
    def initialize
      @aid = ENV["AID"]
      @rt = 1
      @jb = "CAPTURE"
      @max_amount = 1000
      @min_amount = 100_000
    end
  end
end
