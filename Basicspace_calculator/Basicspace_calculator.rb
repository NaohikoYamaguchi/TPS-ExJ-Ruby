#! ruby -Ks
# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Chord/Chord"
require "../Basicspace/Basicspace"
require "../Pitchclass/Pitchclass"

# Basicspace_calculator
# =プロパティ
# [chord_a] コードネーム(Chord)
# [chord_b] コードネーム(Chord)
# [a_bs] chord_aのベーシックスペース(Basicspace)
# [b_bs] chord_bのベーシックスペース(Basicspace)
# [delta] 直前に計算したベーシックスペース距離(Int)
class Basicspace_calculator
	@chord_a
	@chord_b
	@a_bs
	@b_bs
	@delta

	# ベーシックスペース関数の値を算出する
	# == 引数
	# [chord_a] コードネーム(Chord)
	# [chord_b] コードネーム(Chord)
	# == 戻り値
	# 距離(Int)
	def	calc_basicspace (chord_a,chord_b)
		
		#引数をプロパティに記録する
			@chord_a = chord_a
			@chord_b = chord_b
			

		
		#ベーシックスペースの生成
		
			@a_bs = Basicspace.new(@chord_a.getchordname(),@chord_a.getroot(),@chord_a.get_minorflag())
			@b_bs = Basicspace.new(@chord_b.getchordname(),@chord_b.getroot(),@chord_b.get_minorflag())
			
		#距離の算出
			@delta = delta_basicspace()
		
			return @delta
	end
	
	
	# ベーシックスペース間距離を算出
	# == 引数
	# [bs_a] 距離を算出されるベーシックスペース(Basicspace)
	# [bs_b] 距離を算出するベーシックスペース(Basicspace)
	# == 戻り値
	# 距離(Int)
	def delta_basicspace()
		delta_pos = 0
		delta_neg = 0
		
		12.times do |i|
			sub=@a_bs.get_bs[i]-@b_bs.get_bs[i]
			
			if sub < 0 then
				delta_neg += (-1 * sub)
			else
				delta_pos += sub
			end
		end
		
		return (delta_pos < delta_neg) ? delta_neg : delta_pos
	end
	
	# 最後に求めたベーシックスペース間距離を返す
	# == 戻り値
	# 距離(Int)
	def get_last_delta()
		return @delta
	end
	
	# p method 対応
	def inspect()
		print "Basicspace( ",@chord_a.getchordname()," , ",@chord_b.getchordname()," ) = ",@delta,"\n"
		print "\tfedcba\t   |   \tfedcba\n---------------\t---+---\t-------\n"
		12.times do |i|
		buf = Pitchclass.new(i)
		print buf.getname,"\t"
		@a_bs.get_bs()[i].times do |j|
			print "*"
		end
		print "\t   |   \t"
		@b_bs.get_bs()[i].times do |j|
			print "*"
		end
		print "\n"
		end
	return nil
	end


end


