# Robot Payment
# API docs available only pdf
require "faraday"
require "json"

# aid : 店舗ID
# rt  : 決済結果返信方法
# cod : 店舗オーダー番号
# cn  :カード番号
# ed  :カード有効期限
# fn  :カード名義
# ln  :カード名義
# em  :メールアドレス
# pn  :電話番号
# iid :商品コード
# etc :任意パラメータ 1024Byte
module RobotPayment
  class << self
    attr_accessor :base_uri, :aid, :rt, :cod, :cn , :ed, :fn, :ln, :em, :pnm, :iid, :etc
  end

  @order_path = "gateway/gateway.aspx"          # 決済実行
  @interrupt_path = "gateway/acsgate.aspx"      # 停止処理
  @update_path = "gateway/accgate.aspx"         # 自動課金情報の変更
  @stop_path = "gateway/acstop.aspx"            # 仕様不明な停止処理URI

  @base_uri     = "https://credit.j-payment.co.jp/"
  @order_uri = "#{@base_uri}#{@order_path}"
  @interrupt_uri = "#{@base_uri}#{@interrupt_path}"
  @update_uri = "#{@base_uri}#{@update_path}"

  def self.base_uri
    @base_uri
  end

  def self.order_uri
    @order_uri
  end

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
        aid: ENV["AID"],
        rt:  1,
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
