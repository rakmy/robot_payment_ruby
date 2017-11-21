# robot_payment_ruby
RobotPayment rubytool

railsアプリに必要な設定

1. write Gemfile
```
gem 'robot_payment', github: 'knowledgelabo/robot_payment_ruby', branch: 'v0.1'
```
3. make `robot_payment_config.rb` in initalizer
```
rails g robot_payment:config
#=> app/config/initializer/robot_payment_config.rb
```

```
RobotPayment.configure do |config|
  config.aid = 100001           # 契約時店舗ID
  config.rt = 1                 # response type
  config.max_amount = 100_000   # 決済最大金額.契約内容を参照
  config.min_amount = 1000      # 決済最小金額.契約内容を参照
end
```

2. ログのtknを[FILTERED] にする場合は以下を設定
```
Application.rb
  config.filter_parameters += [:tkn]
```

3. トークン取得のためのjsをインクルード
```
app/views/layouts/application.html.erb
  javascript_include_tag "https://credit.j-payment.co.jp/gateway/js/CPToken.js"
```

4. app sample  

We have sample application.  
https://github.com/knowledgelabo/kl_payment_app_sample

上記アプリからController/Viewをコピーしてくると作業が早いです

`payment_controller`
https://github.com/knowledgelabo/kl_payment_app_sample/blob/master/app/controllers/payment_controller.rb

`views/payment/index`
https://github.com/knowledgelabo/kl_payment_app_sample/blob/master/app/views/payment/index.html.haml

`routes.rb`
```
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :robot_payment do
    get  :index, to: 'payment#index'
  end
end
```

