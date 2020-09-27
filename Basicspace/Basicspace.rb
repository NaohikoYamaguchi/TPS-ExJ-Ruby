#! ruby -Ks
# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Modint/Modint"
require "../Pitchclass/Pitchclass"

# Basicspace
# = プロパティ
# [@bs] ベーシックスペース(Array)
class Basicspace
	@bs
	
	# コンストラクタ
	# = 引数
	# [chordname] コードネーム(String)
	# [root] 調のルート(Int)
	# [is_minor] 長調/短調フラグ(True->短調,False->長調)(Boolean)
	# =動作
	# *ベーシックスペースの生成
	def initialize(chordname,root,is_minor)
		
		#ベーシックスペースの生成
		self.genbs(chordname,root,is_minor)
		
	end
	
	# ベーシックスペースを生成する
	# == 引数
	# [chordname] コードネーム(String)
	# [root] 調のルート(Int)
	# [is_minor] 長調/短調フラグ(True->短調,False->長調)(Boolean)
	def genbs(chordname,root,is_minor)
		#配列の初期化
		#初期値はすべて1
		@bs = Array.new(12,1)
		
		#調構成音の重みを1レベル増やす
		self.genbs_keyconstructnote(root,is_minor)
		
		#コードネームから和音を構成する
		self.genbs_chordstructnote(chordname)
	end
	
	# ベーシックスペースの調構成音レベルを決定
	# == 引数
	# [root] 調のルート(Int)
	# [is_minor] 長調/短調フラグ(True->短調,False->長調)(Boolean)
	def genbs_keyconstructnote(root,is_minor)
		#調のルートのピッチクラスを求める
		nowpc = Modint.new(root,12)
		
		
		#長調/短調で場合わけ
		if is_minor then
			#短調の場合（自然短音階）
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#全
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(1)	#半
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#全
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#全
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(1)	#半
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#全
			@bs[nowpc.get]=@bs[nowpc.get]+1
		else
			#長調の場合
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#全
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#全
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(1)	#半
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#全
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#全
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#全
			@bs[nowpc.get]=@bs[nowpc.get]+1
		end

	end

	# ベーシックスペースの和音構成音レベルを決定
	# == 引数
	# [chordname] コードネーム(String)
	# == コードネームパーサに対する注意
	# このコードネームパーサは暫定版であり，以下の制約を持つ．
	# *ルート音，各コードネームを構成する部品は半角スペースで区切る必要がある(例:"Cm7-5"->"C m 7 -5")
	# *コードネームの文法誤りについては考慮していない
	# == 対応するコードネーム
	# 現在，以下に示すコードネームに対応している．(@はコードの主音）
	# [@] メジャーコード
	# [@m] マイナーコード
	# [@maj7] メジャー・セブンス
	# [@mmaj7] マイナー・メジャー・セブンス
	# [@aug] オーギュメント(増5度)
	# [@-5] (altと同じ意味)フラットファイブ(減5度)
	# [@alt] (-5と同じ意味)アルタード(減5度)
	# [@7] セブンス
	# [@m7] マイナー・セブンス
	# [@aug7] オーギュメント・セブンス
	# [@7-5] アルタード・セブンス
	# [@dim] ディミニッシュ(ここではクラシック音楽理論風に三和音として定義)
	# [@m7-5] マイナーセブン・フラッテッドファイブ
	# [@dim(M7)] ディミニッシュド・メジャーセブンス
	# [@sus4] サスペンデッド・フォー
	# [@7sus4] セブンス・サスペンデッド・フォー
	def genbs_chordstructnote(chordname)
		#暫定版
		chord = chordname.split(" ")
		
		#ルート音
		buf = Pitchclass.new(chord[0])
		rootpc=Modint.new(buf.get,12)
		nowpc=Modint.new(rootpc.get,12)
		@bs[nowpc.get]=6
		
		#第3音と第5音がセットされたかどうかのフラグ
		setno3 = false
		setno5 = false
		
		#mの場合
		if chord[1]=="m" then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(3)
			@bs[nowpc.get]=4
			setno3 = true
			
		end
		
		#dimの場合
		if chord[1]=="dim" then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(3)
			@bs[nowpc.get]=4
			setno3 = true
			
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(6)
			@bs[nowpc.get]=5
			setno5 = true
			
			#クラシック音楽の記法に合わせてdimは三和音とする．
			#以下のコメントを外せば4和音となる
			#nowpc=Modint.new(rootpc.get,12)
			#nowpc.add(9)
			#@bs[nowpc.get]=3
		end
		
		#augがある場合
		if chord.include?("aug") then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(8)
			@bs[nowpc.get]=5
			setno5 = true
		end
		
		#-5がある場合
		if (chord.include?("-5") || chord.include?("alt")) then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(6)
			@bs[nowpc.get]=5
			setno5 = true
		end
		
		#sus4がある場合
		if chord.include?("sus4") then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(5)
			@bs[nowpc.get]=4
			setno3 = true
		end
		
		#7thがある場合
		if chord.include?("7") then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(10)
			@bs[nowpc.get]=3
		end
		
		#maj7thがある場合
		if chord.include?("maj7") then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(11)
			@bs[nowpc.get]=3
		end


		
		#第3音がセットされているかどうか確認
		if setno3 == false then
			#セットされていなければ標準の値（ルートから長3度）をセット
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(4)
			@bs[nowpc.get]=4
			setno3 = true
		end
		
		#第5音がセットされているかどうか確認
		if setno5 == false then
			#セットされていなければ標準の値（ルートから完全5度）をセット
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(7)
			@bs[nowpc.get]=5
			setno5 = true
		end

	end
	
	#basicspaceを返す
	def get_bs()
		return @bs
	end

	# p method 対応
	def inspect()
		print "\tfedcba\n--------------\n"
		12.times do |i|
		buf = Pitchclass.new(i)
		print buf.getname,"\t"
		@bs[i].times do |j|
			print "*"
		end
		print "\n"
		end
	return nil
	end


	
end


