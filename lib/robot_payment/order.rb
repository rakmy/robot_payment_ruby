# frozen_string_literal: true
require "faraday"
require "json"
require "base64"

module RobotPayment
  class Order
    def test_uri
      RobotPayment.order_uri
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

    def purchase
      #client = RobotPayment::Client.new
      client = Faraday.new(url: RobotPayment.base_uri)
      order = RobotPayment::Order.new
      url = order.query_builder
      client.post url
    end

    def query_builder
      "#{test_uri}?#{params}"
    end

    def params
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
