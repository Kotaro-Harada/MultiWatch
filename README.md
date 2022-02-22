https://img.shields.io/badge/brew_3.3.15-blue https://img.shields.io/badge/rails-6.1.4.4-blue https://img.shields.io/badge/ruby-3.0.3-blue https://img.shields.io/badge/vue-2.6.14-blue https://img.shields.io/badge/tests-passing-green https://img.shields.io/badge/deploy-aws-blue

MultiWatchとは

配信や動画の複数窓を可能にするサイトです。youtubeやtwitchのチャンネルをフォローすることや、フレンドにメッセージを送ったり、フレンド間だけのチャット欄を作ることも可能です。

概要

2020年からコロナが世界中で蔓延し、その中で自分自身やスキル、作品を収益化するために立ち上げた多数のビジネス
であるクリエーターエコノミーが急成長しました。2021年にはクリエーターエコノミーは約12兆円の市場となり、クリエーター
は世界で5000万人となりました。そして、私自身も多種多様な配信や動画を見ていく内に複数窓ができるようなサイトがあれば
便利ではないか、また使いたいと思う人も多くいるのではないかと思い、このサイトを作りました。

使用技術
  ・Ruby 3.0.3
  ・Ruby on Rails 6.1.1.4
  ・Vue 2.6.14
  ・Postgresql 14.1(AWS内では11.12)
  ・NGINX
  ・UNICORN
  ・AWS
    ・VPC
    ・EC2
    ・RDS
    ・Route53
  ・RSpec
  ・JEST
  ・Youtube API
  ・Twitch API
  ・Action cable

機能一覧
  ・ユーザー登録, ログイン機能(bcrypt)
  ・フォロー機能(API, Vue)
  ・ウィスパー機能(Vue)
  ・フレンド機能
  ・配信、動画視聴機能
  ・チャンネル検索機能(API)
  ・チャット機能(Action cable)

テスト
  ・Rspec
    ・単体テスト(model)
    ・機能テスト(request)
    ・統合テスト(feature)
  ・JEST(単一コンポーネント)

AWS構成図

ER図

使い方


