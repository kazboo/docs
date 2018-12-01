# Ubuntuの概要

## UbuntuとDebian GNU/Linux

* Ubuntuは `Debian` の派生ディストリビューション
  * Linux Mint
  * Raspbian(ラズビアン: Raspberry Pi用Debian)
  * KNOPPIX(クノーピクス、ノピックス)

* Ubuntuは南アフリカの言葉で `他者への思いやり`
  * 当時Linuxはユーザーフレンドリーとはいいがたかった
  * デスクトップOSとして見られることが多かった

* ビジネスユースでもライセンス料は不要(Canonical社の有償サポートあり)

* バリエーション
  * Ubuntu Desktop
  * Ubuntu Server
  * Ubuntu Cloud: クラウドプラットフォーム向け
  * Ubuntu Core: IoTデバイス向け

* 6か月ごとに最新リリース
  * Ubuntu 18.04 > 2018/04 にリリースされた版

* バージョン毎にコードネーム
  * 16.04: (ジーニアル ジリス、おもてなしのアラゲジリス), 18.04: Bionic Beaver(生体工学のビーバー)

* サポート期間
  * リリースされてから9カ月
  * LTS版
    * 5年間にわたってセキュリティアップデートが提供される
    * 16.04LTS > 2021年まで

* ポイントリリース
  * LTS版では一定期間ごとに累積アップデートをまとめている
    * 16.04, 16.04.1, 16.04.2, ...

* `パッケージ管理` 
  * 形式: Debian形式(.deb) (Debian同様)
  * パッケージ管理システム: `APT(Advanced Packaging Tool)` (Debian同様)

## Ubuntu Serverの特徴

* CLI
* 最小構成のインストールが可能
* アーキテクチャ
  * 一般的なx86/x86-64, ARM, IBM PowerPC, IBM s390x
* クラウドでの利用
  * AWS, Microsoft Azure, GCPにおけるゲストOSとして認証を受けており、クラウド上で利用可能
  * VPS(Virtual Private Server)サービスでもデフォルトのOSとしてUbuntuServerを選択できるところが多い
* 主な構成ソフトウェア
  * Apache, docker, LXC, LXD, MariaDB, MySQL, Postgre, OpenJDK, OpenSSH, OpenSSL, Python2/3, Samba, etc

