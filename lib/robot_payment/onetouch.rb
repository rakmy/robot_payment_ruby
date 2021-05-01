# frozen_string_literal: true
require "faraday"
require "json"

module RobotPayment
  class Onetouch
    def onetouch_url
      RobotPayment.onetouch_url
    end

    def create(params)
      client = Faraday.new(url: onetouch_url, proxy: RobotPayment.config.proxy)
      charge = RobotPayment::Onetouch.new
      url = charge.query_builder(params)
      client.post url
    end

    def query_builder(params)
      "#{onetouch_url}?#{basic_params(params)}"
    end

    def basic_params(params)
      q = {
        aid: RobotPayment.config.aid,
        rt: 1,
        cmd: 2,
        jb: "CAPTURE", # 店舗ID・店舗オーダー番号
        }
      q.merge!(params) if params
      q = q.map{|key,val| "#{key}=#{val}"}.join("&")
    end
  end
end
