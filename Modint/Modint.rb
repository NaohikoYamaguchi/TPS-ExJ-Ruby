#! ruby -Ks


# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

# モジュロ演算する整数クラス
# =プロパティ
# [@value] 値(Int)
# [@mod] 法(Int)
class Modint
	@value = 0
	@mod = 1
	
	# コンストラクタ
	# == 引数
	# [val] 値(Int)
	# [mod] 法(Int)
	# == 動作
	# * 値と法を設定する
	def initialize(val,mod)
		# 法の設定
		@mod = mod
		
		# 値の設定
		self.set(val)
		
	end
	
	
	# 値を返す
	# == 戻り値
	# 値（Int)
	def get()
		return @value
	end
	
	# 法を返す
	# == 戻り値
	# 法（Int)
	def getmod()
		return @mod
	end

	
	# 値をセットする
	# == 引数
	# [val] 値(Int)
	def set(val)
		@value = val % @mod
	end
	
	# p method 対応
	def inspect()
		return @value.to_s + " mod " + @mod.to_s
	end
	
	# 足し算
	# == 引数
	# [other] 値(int)
	def add(other)
		case other
		when Integer
			buf = (@value + other) % @mod
		when Mod_int
			if other.getmod == self.getmod then
				buf = @value + other.get
			else
				raise "Divisor mismatch"
			end
		else
			raise TypeError
		end
		self.set(buf)
	end


	
end
