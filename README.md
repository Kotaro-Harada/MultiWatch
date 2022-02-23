![](https://img.shields.io/badge/brew_3.3.15-blue) ![](https://img.shields.io/badge/rails-6.1.4.4-blue) ![](https://img.shields.io/badge/ruby-3.0.3-blue) ![](https://img.shields.io/badge/vue-2.6.14-blue) ![](https://img.shields.io/badge/tests-passing-green) ![](https://img.shields.io/badge/deploy-aws-blue)

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
  ・ユーザー登録、ログイン機能(bcrypt)
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

  ![](/readme_images/multiwatch.drawio.png)

ER図

  ![](/readme_images/erd.png)

使い方

・ホーム画面

  ![](/readme_images/home.png)

チャンネルの検索はヘッダーにあるチャンネル検索によって検索が可能です。また、フォローしたチャンネルは左上のメニューボタンを押すことによって画像にある
サイドバーが開くのでそちらで確認、フォローの解除が可能です。そして、サイドバーのフォローチャンネルから配信を見ることも可能です。

直接配信または動画のURLを入力して視聴することも可能です。その場合は最大４つまで、NICONICOは動画のみとなっております。URLを入力した後、
下のWATCHボタンを押すことで視聴できます。


・チャンネル検索画面

  ![](/readme_images/channels.png)

チャンネル一覧の画面では、チャンネルが配信中であるならばアイコンまたは名前をクリックすると視聴ができます。twitchの場合、
配信していない時は待機画面が表示されます。
また、フォローボタンを押すことでそのチャンネルをフォローすることができます。

注意！ youtubeのチャンネルもフォローできるようにしていますが、YoutubeのAPI使用には1日当たりの限度が設定されてあります。そして、
youtubeのチャンネルをフォローするとサイドバーから全ての画面でyoutubeAPIを使用するため、youtubeチャンネルをフォローした上でその限度
がきてしまうと19時まで何もできなくなってしまうため、極力youtubeチャンネルのフォローはしないで下さい。

・ウィスパー

  ![](/readme_images/whisper.png)

ユーザー名とメッセージを入力して送信ボタンを押すことでメッセージを送れます。クリアボタンを押すとメッセージが全て削除できます。
リロードボタンを押すと新着のメッセージを確認できます。

・ユーザーメニュー

  ![](/readme_images/user_menu.png)

ユーザーアイコンをクリックすることでそれぞれのメニューが出てきます。
フレンドはフレンド依頼の送信、フレンドの削除、フレンドへのウィスパーができます。
設定はユーザーアイコンの変更やユーザーネーム、メールアドレス、パスワードの変更ができます。
ログアウトは現在ログインしているユーザーからログアウトします。
退会は現在ログインしているユーザーを削除します。

・動画、配信視聴ページ

  ※youtubeやtwitchのチャット欄でログインができない場合、ブラウザのセキュリティ設定からcookieを全て受け入れるを選択してみたください。
  
  ※サイドバーのフォロー欄から選んでも視聴しているチャンネルが変わらない場合は一度更新してみて下さい。
  
・レイアウト

  ![](/readme_images/layout.png)

４分割されているアイコンをクリックしてお好みのレイアウトを選ぶことでレイアウトの変更ができます。

・配信、動画の追加

  ![](/readme_images/add_video.png)

＋アイコンを押すことで配信、動画をURLまたはフォローから追加できます。

・配信、動画の削除

  ![](/readme_images/delete_video.png)

−アイコンを押すことで画面の右下にゴミ箱のボタンが出てくるのでそれを押すと動画の削除ができます。

・チャット欄の作成

  ![](/readme_images/create_chat_room.png)

チャットの種類をCUSTOMにした後に”ルームを作成”をクリックすることでチャットルーム作成可能です。
チャットルームを作った時点でそのチャットルームに参加しています。また、参加できるチャットは１つまでです。

・チャットの送信

  ![](/readme_images/chat.png)

メッセージを入力して”チャット”ボタンを押すことでチャットの送信ができます。

・チャットへの招待、退出

  ![](/readme_images/edit_chat.png)

右上のアイコンをクリックし、”フレンドを招待する”からチャットに招待したいフレンドを選択して、”招待”ボタンを押すことで
ウィスパーでチャットへの招待が送れます。
”退出”ボタンを押すことでチャットからの退出が可能です。
