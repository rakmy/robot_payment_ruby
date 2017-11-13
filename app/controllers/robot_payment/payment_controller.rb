module RobotPayment
  class PaymentController < ApplicationController
    def index
    end

    def pay
      user_params = {
        pn:  params[:pn],   # * phone number
        em:  params[:em],   # * email
        tkn: params[:tkn],  # * token
      }
      line_items = {   # 初回決済
        am: 1_000,     # * amount
        tx: 100,       # * tax
        sf: 100        # * shipping fee
      }
      auto_charge_line_items = {
        actp: 4,       # * 課金周期 2: 毎週課金, 3: 隔週課金, 4: 毎月課金, 5: 隔月, 6: 3ヶ月課金, 7: 6ヶ月課金, 8: 1年課金
        acam: 1_000,   # * amount
        actx: 90,      # tax
        acsf: 90,      # shipping fee
        actx: 10       # tax
      }

      optionals = {          # 任意パラメータ
        cod:  "2",           # 店舗オーダー番号
        ac1:  99,            # 課金日指定 0:未指定, 1-30: 1-30日, 99: 末日課金
      }
      trials = {             # お試し機能
        trtp: 4,             # お試しタイプ 2: 日数, 3: 期間, 4: 月間, 5: 期限指定
        tr1: nil,            # お試し日数 0: 指定なし, 1-999 日数指定
        tr2: 1,            # お試し月数 0: 指定なし, 1-24  月間指定
        tr3: "2017/12/31",   # お試し期限
        tram: 0,             # お試し期間終了時の決済金額. trtp指定時に必須
        trtx: 0,             # お試し期間終了時の決済税額
        trsf: 0              # お試し期間終了時の決済送料 (document には税額とあるが)
      }

      @query = post_for_robot_payment_params.merge(user_params)
        .merge(line_items)
        .merge(auto_charge_line_items)
        .merge(optionals)
        .merge(trials)
      @url = "#{RobotPayment.token_order_uri}"
      charge = RobotPayment::Charge.new
      @response = charge.create_by_token(@query)
    end

    # robot_payment に投げるparamater
    def post_for_robot_payment_params
      params.permit(
        :aid, :jb, :rt, :cod,
        :tkn, :pn, :em,
        :am, :tx, :sf,
        :actp, :acam, :actx, :acsf,
        :ac1, :ac2, :ac3, :ac4, :ac5,
        :trtp, :tr1, :tr2, :tr3, :tram, :trtx, :trsf
        #, :id  # 発行ID.J-Paymentシステムより発行されたID => 扱い不明
        )
    end
  end
end