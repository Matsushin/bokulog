# ボクログ
Rails練習用ブクログコピーアプリ

## ボクログとは
本を検索してレビュー、タグ、評価をつける等して自分の本棚を作り管理することができます。

## セットアップ時の注意点
##### 1.各種キー情報の取得
- [Facebook Apps](https://developers.facebook.com/apps)
- [Twitter Apps](https://apps.twitter.com/)
- [GitHub API](https://github.com/settings/applications)
- [Amazonアソシエイトプログラム](https://affiliate.amazon.co.jp/)
- [Amazon Product API](https://affiliate.amazon.co.jp/gp/advertising/api/detail/main.html)

##### 2.各種キー情報の設定

.envファイルを作成しプロジェクトディレクトリ直下に配置して下記の記述を追加して下さい。

````
# facebook authentication
FACEBOOK_APP_ID         = '[取得したFacebook App ID]'
FACEBOOK_APP_SECRET     = '[取得したFacebook App Secret]'

# twitter authentication
TWITTER_API_KEY         = '[取得したTwitter API Key]'
TWITTER_API_SECRET      = '[取得したTwitter API secret]'

# github authentication
GITHUB_CLIENT_ID        = '[取得したClient ID]'
GITHUB_CLIENT_SECRET    = '[取得したClient secret]'

# amazon product api
AMAZON_ASSOCIATE_TAG    = '[取得したアソシエイトID]'
AWS_ACCESS_KEY_ID       = '[取得したAccess Key ID]'
AWS_SECRET_KEY          = '[取得したSecret Access Key]'
````

## 機能一覧　
### 1.認証
- 会員登録
- ログイン
- SNSログイン(Facebook,Twitter,GitHub)
- ログアウト

### 2.マイページ
- 読書状況、利用状況の表示

### 3.本検索(Amazon Product Advertising API利用)
- 本のキーワード検索(ページャー処理あり)
- 本の詳細表示

### 4.本棚
- 本の本棚登録
- 本棚表示(ページャー処理あり)
- 本棚の本の情報編集(評価、読書状況、カテゴリ、レビュー、タグ)


## テーブル構成
- Users
- Bookshelves
- Items
- Reviews
- Tags 



## 追加したい機能一覧
- プロフィール情報編集(アイコン、自己紹介等)
- 退会
- ユーザ別のカテゴリの追加、変更、統一
- ユーザ別のタグの追加、変更、統一
- 本棚情報編集
- 本棚の並び替え
- 本棚の本削除
- 他ユーザの本棚表示
- 他ユーザのフォロー、アンフォロー
- 他ユーザのレビューへのコメント
- レビューへのイイネ
