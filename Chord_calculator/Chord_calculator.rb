#! ruby -Ks
# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Modint/Modint"
require "../Chord/Chord"
require "../Basicspace_calculator/Basicspace_calculator"


# Chord_calculator
# =プロパティ
# [@chord_a] コード(Chord)
# [@chord_b] コード(Chord)
# [@delta] 直前に計算したChord距離(Int)
class Chord_calculator
	@chord_a
	@chord_b
	@chordcircle_a
	@chordcircle_b
	@pivot_a
	@pivot_b
	@delta
	
	#chord関数を測定できなかった時に返す（十分大きな）定数
	CHORD_DISTANCE_UNMEASURABLE = 99


	# chord関数
	# == 引数
	# [in1] コード(Chord)
	# [in2] コード(Chord)
	# == 戻り値
	# コード間距離（Int)
	def calc_chord(in1,in2)
	
		#引数をプロパティに記録する
		@chord_a = in1
		@chord_b = in2
		
		#ピヴォット候補配列を求める
		#ピヴォットが必要ない場合（つまり与えられたコードがダイアトニックの場合）与えられたコード名がそのまま入る
		
		#@chord_aのchord circleの中で@chord_aのコードネームを探索する．
		@pivot_a = Array.new
		@pivot_a = pickup_pivotlist(@chord_a)
		
		#@chord_bのchord circleの中で@chord_bのコードネームを探索する．
		@pivot_b = Array.new
		@pivot_b = pickup_pivotlist(@chord_b)
		
		
		@chordcircle_a = make_chordcircle(@chord_a.getroot(),@chord_a.get_minorflag())
		@chordcircle_b = make_chordcircle(@chord_b.getroot(),@chord_b.get_minorflag())
		
		#結果格納用Array
		result = Array.new
		
		#@chord_aのchord circleの中に@chord_bのピヴォットコード名が存在するか．
		#全てのピヴォットコードの組み合わせを探索
		#現在探索対象となっているchord_aのピヴォットコード名がpivot_a_nowcheck
		#現在探索対象となっているchord_bのピヴォットコード名がpivot_b_nowcheck
		@pivot_a[0].each do |pivot_a_nowcheck|
			@pivot_b[0].each do |pivot_b_nowcheck|
				if @chordcircle_a.include?(pivot_b_nowcheck) then
					#見つかった
					
					#以下，和音の5度圏上の距離を算出する
					#chord_aの和音の5度上でpivot_a_nowcheckが存在する位置を，距離測定の起点base_positionとする
					base_position = Modint.new(@chordcircle_a.index(pivot_a_nowcheck),@chordcircle_a.length)
					
					#距離計測カウンタをリセット
					counter = 0
					
					#和音の5度圏を時計回りに数える
					@chordcircle_a.length.times do |i|
						if @chordcircle_a[base_position.get()] == pivot_b_nowcheck then
							#pivot_b_nowcheckと一致したら数えるのをやめる
							break
						else
							#pivot_b_nowcheckと一致しなかったらもう1ステップ時計回りに進む
							base_position.add(1)
							counter = counter +1
						end
					end
					
					#もしも得られた距離が和音の5度圏の長さの半分より大きければ，
					#反時計回りに探索した方が早かった事になるので，反時計回りの距離に修正する
					if counter > (@chordcircle_a.length / 2.0) then
						counter = @chordcircle_a.length - counter
					end
					
					#和音の5度圏からピヴォットコードとしての場合，外に伸びた枝の分を追加する
					if @pivot_a[1] == true then
						counter = counter +1
					end
					if @pivot_b[1] == true then
						counter = counter +1
					end
					
					#得られた距離を結果格納Arrayにプッシュする
					result.push(counter)
				
				else
					#見つからなかった→chord距離算出不可
					#十分に大きな値を結果としてプッシュする
					result.push(CHORD_DISTANCE_UNMEASURABLE)
				end
				
			end
		end
		
		
		
		#@chord_bのchord circleの中に@chord_aのピヴォットコード名が存在するか．
		#全てのピヴォットコードの組み合わせを探索
		#現在探索対象となっているchord_aのピヴォットコード名がpivot_a_nowcheck
		#現在探索対象となっているchord_bのピヴォットコード名がpivot_b_nowcheck
		@pivot_b[0].each do |pivot_b_nowcheck|
			@pivot_a[0].each do |pivot_a_nowcheck|
				if @chordcircle_b.include?(pivot_a_nowcheck) then
					#見つかった
					
					#以下，和音の5度圏上の距離を算出する
					#chord_bの和音の5度上でpivot_b_nowcheckが存在する位置を，距離測定の起点base_positionとする
					base_position = Modint.new(@chordcircle_b.index(pivot_b_nowcheck),@chordcircle_b.length)
					
					#距離計測カウンタをリセット
					counter = 0
					
					#和音の5度圏を時計回りに数える
					@chordcircle_b.length.times do |i|
						if @chordcircle_b[base_position.get()] == pivot_a_nowcheck then
							#pivot_a_nowcheckと一致したら数えるのをやめる
							break
						else
							#pivot_a_nowcheckと一致しなかったらもう1ステップ時計回りに進む
							base_position.add(1)
							counter = counter +1
						end
					end
					
					#もしも得られた距離が和音の5度圏の長さの半分より大きければ，
					#反時計回りに探索した方が早かった事になるので，反時計回りの距離に修正する
					if counter > (@chordcircle_b.length / 2.0) then
						counter = @chordcircle_b.length - counter
					end
					
					#和音の5度圏からピヴォットコードとしての場合，外に伸びた枝の分を追加する
					if @pivot_a[1] == true then
						counter = counter +1
					end
					if @pivot_b[1] == true then
						counter = counter +1
					end
					
					#得られた距離を結果格納Arrayにプッシュする
					result.push(counter)
				
				else
					#見つからなかった→chord距離算出不可
					#十分に大きな値を結果としてプッシュする
					result.push(CHORD_DISTANCE_UNMEASURABLE)
				end
			end
		end
		
		#結果格納用Arrayのうち，最小のものを出力する
		minimum = result[0]		#初期値として先頭を代入
		result.each do |i|
			if minimum > i then
				minimum = i
			end
		end
		
		@delta = minimum
		return @delta
	end
	
	# 5度圏を表す配列を生成する
	# == 引数
	# [root] 調のルート音(Int)
	# [is_minor] 長調/短調フラグ(Boolean)【True->短調,False->長調】 
	# == 戻り値
	# 5度圏（Array)
	def make_chordcircle(root,is_minor)
		chordcircle=Array.new
		
		
		if is_minor == false then
			#長調のとき
			#このルックアップテーブルは『コード進行スタイルブック』p.182に基づく．
			case root
				when 0
					chordcircle= Array["C","E m","G","B m -5","D m","F","A m"]
				when 1
					chordcircle= Array["Db","F m","Ab","C m -5","Eb m","Gb","Bb m"]
				when 2
					chordcircle= Array["D","F# m","A","C# m -5","E m","G","B m"]
				when 3
					chordcircle= Array["Eb","G m","Bb","D m -5","F m","Ab","C m"]
				when 4
					chordcircle= Array["E","G# m","B","D# m -5","F# m","A","C# m"]
				when 5
					chordcircle= Array["F","A m","C","E m -5","G m","Bb","D m"]
				when 6
					chordcircle= Array["Gb","Bb m","Db","F m -5","Ab m","B","Eb m"]
				when 7
					chordcircle= Array["G","B m","D","F# m -5","A m","C","E m"]
				when 8
					chordcircle= Array["Ab","C m","Eb","G m -5","Bb m","Db","F m"]
				when 9
					chordcircle= Array["A","C# m","E","G# m -5","B m","D","F# m"]
				when 10
					chordcircle= Array["Bb","D m","F","A m -5","C m","Eb","G m"]
				when 11
					chordcircle= Array["B","D m","F#","A# m -5","C# m","E","G# m"]
			end
		else
			#短調の時
			case root
				when 0
					chordcircle= Array["C m","Eb","G m","Bb","D m -5","F m","Ab"]
				when 1
					chordcircle= Array["C# m","E","G# m","B","D# m -5","F# m","A"]
				when 2
					chordcircle= Array["D m","F","A m","C","E m -5","G m","Bb"]
				when 3
					chordcircle= Array["Eb m","Gb","Bb m","Db","F m -5","Ab m","B"]
				when 4
					chordcircle= Array["Eb m","G","B m","D","F# m -5","A m","C"]
				when 5
					chordcircle= Array["F m","Ab","C m","Eb","G m -5","Bb m","Db"]
				when 6
					chordcircle= Array["F# m","A","C# m","E","G# m -5","B m","D"]
				when 7
					chordcircle= Array["G m","Bb","D m","F","A m -5","C m","Eb"]
				when 8
					chordcircle= Array["G# m","B","D# m","F#","A# m -5","C# m","E"]
				when 9
					chordcircle= Array["A m","C","E m","G","B m -5","D m","F"]
				when 10
					chordcircle= Array["Bb m","Db","F m","Ab","C m -5","Eb m","Gb"]
				when 11
					chordcircle= Array["B m","D","F# m","A","C# m -5","E m","G"]
			end
		end
		return chordcircle
	end
	
	# 和音の5度圏の中から，ベーシックスペース距離が最も近い和音（ピヴォット）候補配列を求める
	# == 引数
	# [chord] ピヴォットを求めるコード(Chord)
	# == 戻り値
	# ピヴォット候補配列（Array)（戻り値pivot[0]はピヴォット候補コード名リスト，pivot[1]はピヴォットが必要か否かのフラグ）

	def pickup_pivotlist(chord)
		#chordのchord circleの中でchordのコードネームを探索する．
		#chordの置かれた調に対応するchordcircleを生成
		chordcircle = Array.new
		chordcircle[0] = make_chordcircle(chord.getroot(),chord.get_minorflag())
		chordcircle[1]  = Array.new()
		
		#ピヴォット候補格納配列の生成
		#ピヴォット候補は複数ある可能性があるので配列形式
		pivot = Array.new

		if chordcircle[0].include?(chord.getchordname()) == true then
			#chord circleにコードネームが含まれている
			#ピヴォットはいらない．そのままコード名を格納する．
			
			need_pivot_flag = false
			pivot[0] = chord.getchordname()
			
		else
			#chord circleにコードネームが含まれていない
			#basicspace関数を使ってピヴォットコードを探す．
			
			need_pivot_flag = true
			
			#ベーシックスペース算出クラス生成
			bcalc = Basicspace_calculator.new()
			#全てのダイアトニックコードとaのコードのベーシックスペース距離を算出する
			chordcircle[0].each_index do |i|
				#比較対象コードを取り出してChordクラスを生成
				diatonic = Chord.new(chordcircle[0][i])
				diatonic.setkey(chord.getroot(),chord.get_minorflag())
				
				#ベーシックスペース距離を算出して格納
				chordcircle[1][i] = bcalc.calc_basicspace(diatonic,chord)
			end
			
			#ベーシックスペース距離の最小値を求める
			minimum = chordcircle[1][0]		#初期値として先頭をベーシックスペース距離を代入
			chordcircle[1].each_index do |i|
				if minimum > chordcircle[1][i] then
					minimum = chordcircle[1][i]
				end
			end
			
			#最小値の距離を持ったダイアトニックコード名をピヴォット候補として取り出す
			chordcircle[1].each_index do |i|
			
				if chordcircle[1][i] == minimum then
					pivot.push(chordcircle[0][i])
				end
			end
		end
		
		return Array[pivot,need_pivot_flag]
	
	end
	
	# 最後に求めたChord距離を返す
	# == 戻り値
	# 距離(Int)
	def get_last_delta()
		return @delta
	end

	#p method対応
	def inspect()
		print "chord("
		@chord_a.inspect
		print ","
		@chord_b.inspect
		print ")\n"
		
		print"chordciecle chord_a = "
		p @chordcircle_a
		print"chordciecle chord_b = "
		p @chordcircle_b
		
		print"pivot chord_a = "
		p @pivot_a
		print"pivot chord_b = "
		p @pivot_b
		
		return nil
	
	end

end


