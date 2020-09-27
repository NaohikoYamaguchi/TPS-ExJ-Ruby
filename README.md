# TPS-ExJ

Library of TPS-ExJ (Tonal Pitch Space - EXtended for Jazz). 
#Preface : はじめに
This libraly (TPS-EXJ : Tonal Pitch Space - EXtended for Jazz) is deliverable on Naohiko Yamaguchi's master thesis, Improving TPS to Tackle Non Key Constituent Note.
This works tried extend TPS, computational music theory by Fread Lerdahl, for jazz music theory.

このライブラリ(Tonal Pitch Space EXtended for Jazz)は、山口直彦の修士研究
「非調構成音を含む和音への対応を目的としたTonal Pitch Spaceの拡張」
の成果物です。
Fred Lerdahlによって提唱された計算論的音楽理論TPS(Tonal Pitch Space)を、
より複雑な和音を扱えるように拡張させることを試みました。
技術的な詳細は参考文献をご参照ください。

# Requirements : 動作環境

This library run with Ruby 1.9 on (Japanese) windows.
Perhaps, it can run on UNIX or MacOS if you convert appropriate character set.

実行にはRuby動作環境が必要です。
Windows上にインストールしたRuby 1.9で制作し、動作を確認しています。
特にOSや他のライブラリに依存するような部分はありませんので、UNIXやMacOS上でも、
ソースファイルの文字コードを変換すれば動作すると思いますが、未確認です。

# License : ライセンス

This libraly release by New BSD License.

本ライブラリは修正BSDライセンス（New BSD License）を採用しています。
本ライブラリを利用された場合には、使用された旨を作者までご連絡いただければ幸いです。
（あくまでお願いであり、強制ではありません）
また、ライブラリそのものの改造も歓迎いたします。

# How to Use : 使い方

If you would like to try this libraly, Run Music/Music.rb at first.

On line 458, explain method get code name list of head of "Fly me to the moon".
Explain method calculate distance between adjacent chord. And return appropriate interpretation.

You can read document made by RDoc in doc/index.html.

とりあえず、本ライブラリを動かしてみたい方は、Ruby実行環境でMusicディレクトリ
にあるMusic.rbを実行してみて下さい。

同ファイル下部(458行目）では"Fly me to the moon"冒頭部分のコード進行をexplainメソッドが
受け取っています。
　#"Fly me to the moon"冒頭部分のコード進行をexplainメソッドに与えた例
　test_music.explain("A m 7,D m 7,G 7,C maj7, F maj7,B m 7 -5,E 7,A m …

explainメソッドは、与えられたコードネーム列から、隣り合うコード同士の和音間距離を
算出し、最も妥当性のある和音解釈を計算して返します。

RDocを用いて生成したドキュメントがdocディレクトリ内のindex.htmから閲覧できます。
各クラスのメソッドやプロパティについてはそちらをご参照ください。

