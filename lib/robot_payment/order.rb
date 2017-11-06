# frozen_string_literal: true
require "faraday"
require "json"

module RobotPayment
  class Order

    def gateway_order_uri
      RobotPayment.gateway_order_uri
    end

    def token_order_uri
      RobotPayment.token_order_uri
    end

    def purchase!
      if params.valid?
        purchase
      else
        raise ValidationError, "ParamaterError. " \
        "Required params is missing. " \
        "See docs at https://jpayment.zendesk.com/hc/ja/sections/200338447 "
      end
    end

    def gateway_test_purchase
      client = Faraday.new(url: gateway_order_uri)  # TODO client = RobotPayment::Client.new
      order = RobotPayment::Order.new
      url = order.gateway_query_builder
      client.post url
    end

    def token_purchase(params)
      client = Faraday.new(url: gateway_order_uri)  # TODO client = RobotPayment::Client.new
      order = RobotPayment::Order.new
      url = order.token_query_builder(params)
      client.post url
    end

    def gateway_query_builder
      "#{gateway_order_uri}?#{test_params}"
    end

    def token_query_builder(params)
      "#{token_order_uri}?#{basic_params(params)}"
    end

    def basic_params(params)
      q = {
        aid: RobotPayment.config.aid,
        rt:  RobotPayment.config.rt,
        jb:  RobotPayment.config.jb }
      q.merge!(params) if params
      q = q.map{|key,val| "#{key}=#{val}"}.join("&")
    end

    def test_params
      q = {
        aid: RobotPayment.config.aid,
        rt:  RobotPayment.config.rt,
        cod: "#{Time.now.strftime("%Y%m%d%H%M%S")}",
        cn:  "4444333322221111",
        ed:  "1712",
        fn:  "MIZUNO",
        ln:  "MIKA",
        cvv: "123",
        em:  "mika.mizuno@knowledgelabo.com",
        pn:  "0668097072",
        iid: "cs001"}
      q = q.map{|key,val| "#{key}=#{val}"}.join("&")
    end

    def valid?
      #TODO
    end
  end
end
