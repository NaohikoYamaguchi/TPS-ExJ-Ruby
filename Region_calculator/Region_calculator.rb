#! ruby -Ks
# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Chord/Chord"
require "../Basicspace/Basicspace"
require "../Pitchclass/Pitchclass"

# Region_calculator
# = プロパティ
# [chord_a] コード(Chord)
# [chord_b] コード(Chord)
# [delta] 直前に計算したRegion距離(Int)

class Region_calculator
	@chord_a
	@chord_b
	@delta
	
	# 2つのregion(調)間距離を算出
	# 長調の五度圏に基づいて算出（短調上の和音は予め平行調に変換する必要がある）
	# == 引数
	# [chord_a] コードネーム(Chord)
	# [chord_b] コードネーム(Chord)
	# == 戻り値
	# 距離(Int)

	def calc_region(chord_a,chord_b)
		#引数をプロパティに記録する
		@chord_a = chord_a
		@chord_b = chord_b
		
		#各コードの調ルートを取り出して、Modint型の数値とする
		key_chord_a = Modint.new(@chord_a.getroot,12)
		key_chord_b = Modint.new(@chord_b.getroot,12)
		
		#各コードが短調だった場合、これを平行調（同じ調号を用いる長調）に変換する
		if @chord_a.get_minorflag then
			key_chord_a.add(3)
		end
		
		if @chord_b.get_minorflag then
			key_chord_b.add(3)
		end
		
		#p key_chord_a
		#p key_chord_b
		
		#p Pitchclass.new(key_chord_a.get).getname()
		#p Pitchclass.new(key_chord_b.get).getname()
		
		#ルックアップテーブルを参照して値を返す
		#regiontableのデータは論文に基づく。
		#12行1列目の値は論文の誤りであり，訂正済み
		regiontable =	[
						[0,5,2,3,4,1,6,1,4,3,2,5],
						[5,0,5,2,3,4,1,6,1,4,3,2],
						[2,5,0,5,2,3,4,1,6,1,4,3],
						[3,2,5,0,5,2,3,4,1,6,1,4],
						[4,3,2,5,0,5,2,3,4,1,6,1],
						[1,4,3,2,5,0,5,2,3,4,1,6],
						[6,1,4,3,2,5,0,5,2,3,4,1],
						[1,6,1,4,3,2,5,0,5,2,3,4],
						[4,1,6,1,4,3,2,5,0,5,2,3],
						[3,4,1,6,1,4,3,2,5,0,5,2],
						[2,3,4,1,6,1,4,3,2,5,0,5],
						[5,2,3,4,1,6,1,4,3,2,5,0]
						]
						
		@delta = regiontable[key_chord_a.get][key_chord_b.get]
		
		return @delta
		
	end
	
	# 最後に求めたRegion距離を返す
	# == 戻り値
	# 距離(Int)
	def get_last_delta()
		return @delta
	end

	
	# p method 対応
	def inspect()
		print "Region(",@chord_a.getkeyname," , ",@chord_b.getkeyname," ) = ",@delta,"\n"
	end


end

