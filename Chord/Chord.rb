#! ruby -Ks


# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Pitchclass/Pitchclass"


# コード クラス
# =プロパティ
# [@chordnaame] コードネーム(String)【必須】
# [@root]  調のルート(Int)
# [@is_minor]  長調/短調フラグ(Boolean)【True->短調,False->長調】
class Chord
	@chordname
	@root
	@is_minor

	# コンストラクタ
	# == 引数
	# [chordname]  コードネーム(String)
	# == 動作
	# * コードネームを設定し、クラスの初期化を行う。
	def initialize(chordname)
		# コードネームの設定
		self.setchordname(chordname)
	end
	
	# コードネームの設定
	# == 引数
	# [chordname] コードネーム(String)
	def setchordname(chordname)
		@chordname = chordname
	end


	# 調を設定する。
	# * 引数のうちいずれかがnilならば設定を削除する
	# * 引数が2つ指定されていれば、調ルート音と長調・短調を設定する
	# == 引数
	# [root] 調のルート(数字もしくは文字指定)
	# [is_minor] 長調/短調フラグ(True->短調,False->長調)
	def setkey(root,is_minor)
		if (root == nil) || (is_minor == nil) then
			#引数のいずれかがnilなら設定を削除
			@root = nil
			@is_minor = nil
		else
			
			#ルートの設定
			#文字による指定と数字による指定に対応
			case root
				when String
					#文字（音名）による指定
					buf = Pitchclass.new(root)
					@root = buf.get
				when Integer
					#数字による指定
					if (0<=root) && (root <= 11) then
						@root = root
					else
						#範囲異常
						raise ArgumentError
					end
				else
					raise TypeError
			end
			
			#長調/短調フラグの設定
			case is_minor
			when TrueClass
				@is_minor= true
			when FalseClass
				@is_minor= false
			else
				raise ArgumentError
			end
		end
	end




	# コードネームを返す
	# == 戻り値
	# コードネーム（String)
	def getchordname()
		return @chordname
	end
	
	# 調名を返す
	# == 戻り値
	# 調名（String)
	def getkeyname()
		buf = Pitchclass.new(@root)
		keyname = buf.getname
		if @is_minor then
			return keyname + " minor"
		else
			return keyname + " major"
		end
		
	end
	
	# 長調/短調フラグを返す
	# == 戻り値
	# 長調/短調フラグ（Boolean)
	def get_minorflag()
		return @is_minor
	end
	
	# 調のルートを返す
	# == 戻り値
	# ルート（Int)
	def getroot()
		return @root
	end

	
	# p method 対応
	def inspect()
		print "[",self.getchordname,"]"
		if @root != nil then
			print " in ", self.getkeyname
		return nil
		end
	end
end







