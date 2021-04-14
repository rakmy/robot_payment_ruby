# frozen_string_literal: true
require 'robot_payment/config'
require 'robot_payment/charge'
require 'robot_payment/auto_charge'
require 'robot_payment/pause'
require 'robot_payment/api_error/definitions'

module RobotPayment
  class << self
    attr_accessor :base_uri, :aid, :rt, :cod, :cn , :ed, :fn, :ln, :em, :pnm, :iid, :etc
  end

  @gateway_charge_path = "gateway/gateway.aspx"       # Gateway決済の実行
  @token_charge_path   = "gateway/gateway_token.aspx" # Token決済の実行
  @update_path         = "gateway/accgate.aspx"       # 自動課金情報の変更
  @pause_path          = "gateway/acsgate.aspx"       # 停止処理
  @pause_link_path     = "gateway/acstop.aspx"        # リンク方式による停止処理URI
  @onetouch_path       = "gateway/onetouch.aspx"      # ワンタッチ課金

  @base_uri = "https://credit.j-payment.co.jp/"
  @gateway_charge_uri = "#{@base_uri}#{@gateway_charge_path}"
  @token_charge_uri   = "#{@base_uri}#{@token_charge_path}"
  @update_uri         = "#{@base_uri}#{@update_path}"
  @pause_uri          = "#{@base_uri}#{@pause_path}"
  @pause_link_uri     = "#{@base_uri}#{@pause_link_path}"
  @onetouch_uri       = "#{@base_uri}#{@onetouch_path}"

  def self.base_uri
    @base_uri
  end

  def self.gateway_charge_uri
    @gateway_charge_uri
  end

  def self.token_charge_uri
    @token_charge_uri
  end

  def self.update_autocharge_url
    @update_uri
  end

  def self.pause_url
    @pause_uri
  end

  def self.pause_link_url
    @pause_link_uri
  end

  def self.onetouch_url
    @onetouch_uri
  end
end
