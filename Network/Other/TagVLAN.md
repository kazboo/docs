# Tag VLAN

* VLANにおける接続方式の一つ

* データにそのデータが所属するネットワークの情報を付与し、制御する側はその情報をみて所属するネットワークを判断するやり方

## TagVLANではない構成

![Not TagVLAN](./img/TagVLAN1.svg)

* 効率的ではない
  * VLANが増えれば増えるほど、スイッチのポートをたくさん消費しなければいけない
  * 後からVLANを追加すると、スイッチの設定変更だけでなく、物理的な配線の追加も必要になってしまう

## TagVLANの構成

![TagVLAN](./img/TagVLAN2.svg)

* スイッチ間の接続は1本ですむ

* TagVLANのポート
  * 複数のVLANに割り当てられていて、複数のVLANのイーサネットフレームを転送できるポート

* TagVLANのポートで送受信するイーサネットフレームには「VLANタグ」が付加される
  * VLANタグのフォーマットはIEEE802.1Qで規定されている

* VLANによってスイッチを分割し、タグVLANによってVLANごとにポートを分割できる

## 参考

* タグVLAN
  * <https://news.mynavi.jp/article/vlan-3/>
  * <http://wa3.i-3-i.info/word12091.html>
* L2, L3, ルータの違い
  * <http://sc.ipsecdh.net/entry/656>
* IEEE802.1Q
  * 「ドットワンキュー」あるいは「ドットイチキュー」