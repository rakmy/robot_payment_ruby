# robot_payment_ruby
RobotPayment の gateway を扱う ruby tool です。

## コンセプト

最速でロボットペイメント決済を実行できる便利メソッドと便利hamlだよ

## irb で使う

    git clone git@github.com:knowledgelabo/robot_payment_ruby.git
    cd robot_payment_ruby
    irb -r ./lib/robot_payment.rb`

## pry で使う (おすすめ!)

    gem install pry
    pry -r ./lib/robot_payment.rb`

## Rails app で gem として使う

    git clone git@github.com:knowledgelabo/robot_payment_ruby.git "/path/to/foo"

Gemfile
```ruby
gem 'robot_payment_ruby', path: "/path/to/foo"
```

### 動作環境

* Ruby 2.4.0+.

## 使い方 (随時更新)

``` ruby
order = RobotPayment::Order.new

order.purchase
=> Faraday::Response
```