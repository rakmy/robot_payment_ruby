# frozen_string_literal: true
require "faraday"
require "json"

module RobotPayment
  class AutoCharge

    def update_autocharge_url
      RobotPayment.update_autocharge_url
    end

    def update_by_token(params)
      client = Faraday.new(url: update_autocharge_url, proxy: RobotPayment.config.proxy)  # TODO client = RobotPayment::Client.new
      charge = RobotPayment::AutoCharge.new
      url = charge.query_builder(params)
      client.post url
    end

    def query_builder(params)
      "#{update_autocharge_url}?#{basic_params(params)}"
    end

    def basic_params(params)
      q = {
        aid: RobotPayment.config.aid,
        cmd: 1                       # 変更時に1を指定
        }
      q.merge!(params) if params
      q = q.map{|key,val| "#{key}=#{val}"}.join("&")
    end

    def valid?
      #TODO
    end
  end
end
