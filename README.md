# いとをかし
開運や魔除けなど多くのご利益をもたらす天狗が運営する言葉の共有サイトです。<br>
ユーザーが持つポジティブなエピソードやユーザーお気に入りの格言を共有できます。<br>
レスポンシブ対応していますので、スマートフォンからもご覧頂けます。<br><br>
<img width="1439" alt="top_page" src="https://user-images.githubusercontent.com/64714255/94778642-9c140180-0400-11eb-80f5-205af0087425.png">
![proverb](https://user-images.githubusercontent.com/64714255/94784199-c8cc1700-0408-11eb-94be-b33c50260525.png)

# URL
https://itowokashi.club
※ 現在はアクセスできません
~~Googleアカウントをお持ちでしたら、Google認証でログインできます。~~

# 背景
名前を 「いとをかし」 とした理由は、現代の技術であるWebサービスと、古文で使われていた日本人なら誰もが知る言葉をあえて掛け合わせ若い世代のユーザーから興味を引く狙いと遊び心から付けました。 <br>
背景としましては、以前からSNS関連のニュースを見ていると匿名ユーザーから誹謗中傷を受けて自殺に走ってしまう有名人や一般人が後を絶たない印象を受け異常であると常々思っています。<br>
他人への匿名攻撃だけでなく、ネットいじめ等陰湿な目的に使われたりしている現実があります。<br>
誰かを暗い気分にさせるのではなく、利用者全員が明るい気持ちになれることを願うサービスがあっても良いのではないか。<br>  
そんな考えから今回、このWebサービスを作成しました。  

# AWS構成図
![AWS構成図(いとをかし)](https://user-images.githubusercontent.com/64714255/94783709-08deca00-0408-11eb-95e0-a130fefaf12e.jpg)

# 使用技術
- Ruby 2.5.7
- Ruby on Rails 5.2.4.3
- MySQL 5.7
- Nginx
- Puma
- AWS
  - VPC
  - EC2 (異なるAZへそれぞれ1台ずつ起動した冗長化構成)
  - RDS (プライベートサブネット上で立ち上げ、セキュリティグループで2台のEC2からのみ通信を許可)
  - Route 53
  - CloudWatch (異常発生時、管理者へメールで通知するように設定)
  - S3 (オリジナルサイズを保存するバケットとリサイズした画像を保存するバケットをそれぞれ連携)
  - ALB
  - Auto Scaling (最小容量:1, 希望する容量:2, 最大容量:4)
  - Lambda (S3へトリガーを設置し、画像が投稿されたタイミングで画像圧縮を自動で行う)
- Capistrano
- Rspec
- omniauth-google-oauth2
- devise
- Ajax
- refile
- kaminari

# 機能一覧
https://docs.google.com/spreadsheets/d/1ThKXqANzTH2QS4iD4_JJ9In0VjqmNn-glbNyR-Me6bI/edit?usp=sharing

# テスト
- Rspec
  - 単体テスト (model)
  - 機能テスト (request)
  - 統合テスト (system)
