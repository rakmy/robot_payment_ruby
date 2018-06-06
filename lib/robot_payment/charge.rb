# frozen_string_literal: true
require "faraday"
require "json"

module RobotPayment
  class Charge

    def gateway_charge_uri
      RobotPayment.gateway_charge_uri
    end

    def token_charge_uri
      RobotPayment.token_charge_uri
    end

    def create_by_gateway  # Deprecated due to security, so this is ONLY TEST method for gateway.
      client = Faraday.new
      charge = RobotPayment::Charge.new
      url = gateway_charge_uri
      client.post url, test_params
    end

    def create_by_token(params)
      client = Faraday.new
      charge = RobotPayment::Charge.new
      url = token_charge_uri
      client.post url, post_params(params)
    end

    def post_params(params)
      q = {
        aid: RobotPayment.config.aid,
        rt:  RobotPayment.config.rt,
        jb:  RobotPayment.config.jb }
      q.merge!(params) if params
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
    end

  end
end
