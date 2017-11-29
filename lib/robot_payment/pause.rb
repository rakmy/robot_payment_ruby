# frozen_string_literal: true
require "faraday"
require "json"

module RobotPayment
  class Pause

    def pause_url
      RobotPayment.pause_url
    end

    def update(params)
      client = Faraday.new(url: pause_url)
      charge = RobotPayment::Pause.new
      url = charge.query_builder(params)
      client.post url
    end

    def query_builder(params)
      "#{pause_url}?#{basic_params(params)}"
    end

    def basic_params(params)
      q = {
        aid: RobotPayment.config.aid,
        cmd: 1                       # 変更時に1を指定
        }
      q.merge!(params) if params
      q = q.map{|key,val| "#{key}=#{val}"}.join("&")
    end
  end
end
