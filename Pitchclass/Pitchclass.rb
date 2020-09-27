#! ruby -Ks


# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

# ピッチクラス
# =プロパティ
# [@value] pc番号
class Pitchclass
	@value
	
	# コンストラクタ
	# == 引数
	# [val] 値（pc番号(int)もしくは英語音名(String)）
	# == 動作
	# * 値を設定する
	def initialize(val)
		# 値の設定
		case val
			when Integer,String
				self.set(val)
			else
				raise TypeError
		end
	end
	
	
	# pc番号を返す
	# == 戻り値
	# pc番号（Int)
	def get()
		return @value
	end
	
	# 英語音名を返す
	# == 戻り値
	# 英語音名（String)
	def getname()
		case @value
		when 0
			return "C"
		when 1
			return "C#/Db"
		when 2
			return "D"
		when 3
			return "D#/Eb"
		when 4
			return "E"
		when 5
			return "F"
		when 6
			return "F#/Gb"
		when 7
			return "G"
		when 8
			return "G#/Ab"
		when 9
			return "A"
		when 10
			return "A#/Bb"
		when 11
			return "B"
		end
	end
	
	# 英語音名を返す（短縮版）
	# * 白鍵は通常通り
	# * 黒鍵はフラット表記に統一
	# == 戻り値
	# 短縮英語音名（String)
	def getnameshort()
		case @value
		when 0
			return "C"
		when 1
			return "Db"
		when 2
			return "D"
		when 3
			return "Eb"
		when 4
			return "E"
		when 5
			return "F"
		when 6
			return "Gb"
		when 7
			return "G"
		when 8
			return "Ab"
		when 9
			return "A"
		when 10
			return "Bb"
		when 11
			return "B"
		end
	end
	
	# ピッチクラスの値を設定
	# == 引数
	# val:: 値(pc番号(int)または音名(String)）
	def set(val)
		case val
		when Integer
			#値は0から11まで
			if (0<=val) && (val <=11) then
				@value = val
			else
				raise ArgumentError
			end
		when String
			#書式を揃えるために大文字に変換
			buf = val.upcase
		
			case buf
				when "C"
					@value = 0
				when "C#","DB"
					@value = 1
				when "D"
					@value = 2
				when "D#","EB"
					@value = 3
				when "E"
					@value = 4
				when "F"
					@value = 5
				when "F#","GB"
					@value = 6
				when "G"
					@value = 7
				when "G#","AB"
					@value = 8
				when "A"
					@value = 9
				when "A#","BB"
					@value = 10
				when "B"
					@value = 11
				else
					raise ArgumentError
			end
		else
			raise TypeError
		end
	end

	
	
	#  p method 対応
	def inspect()
		return @value.to_s + "(" + self.getname + ")"
	end
end

