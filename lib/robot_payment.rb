# frozen_string_literal: true
require 'robot_payment/config'
require 'robot_payment/order'

module RobotPayment
  class << self
    attr_accessor :base_uri, :aid, :rt, :cod, :cn , :ed, :fn, :ln, :em, :pnm, :iid, :etc
  end

  @gateway_order_path = "gateway/gateway.aspx"     # Gateway決済の実行
  @token_order_path = "gateway/gateway_token.aspx" # Token決済の実行
  @interrupt_path = "gateway/acsgate.aspx"         # 停止処理
  @update_path = "gateway/accgate.aspx"            # 自動課金情報の変更
  @stop_path = "gateway/acstop.aspx"               # 仕様不明な停止処理URI

  @base_uri     = "https://credit.j-payment.co.jp/"
  @gateway_order_uri = "#{@base_uri}#{@gateway_order_path}"
  @token_order_uri = "#{@base_uri}#{@token_order_path}"
  @interrupt_uri = "#{@base_uri}#{@interrupt_path}"
  @update_uri = "#{@base_uri}#{@update_path}"

  def self.base_uri
    @base_uri
  end

  def self.gateway_order_uri
    @gateway_order_uri
  end

  def self.token_order_uri
    @token_order_uri
  end
end
