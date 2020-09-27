#! ruby -Ks
# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Chord/Chord"
require "../Delta_chord_calcurator/Delta_chord_calcurator"


# グラフを実装するためのノードクラス
# == 謝辞（参考文献）
# 書籍「Java データ構造とアルゴリズム基礎講座」所収のコードをRubyに移植したものである．
# = プロパティ
# [name] ノード名
# [children] 子ノードの格納されたArray
# [childrenCost] 子ノードへのコストが格納されたArray
# [pointer] 親へのポインタ
# [g] コスト
# [h] ヒューリスティック値
# [f = 0] 評価値
# [hasG = false] コスト設定済みフラグ
# [hasF = false] 評価値設定済みフラグ
class Node
	@name 
	@children
	@childrenCosts
	@pointer
	@g
	@h
	@f = 0
	@hasG = false
	@hasF = false
	
	# コンストラクタ
	# = 引数
	# name:: ノード名
	# h:: ヒューリスティック値
	# =主な動作
	# * ノード名、ヒューリスティック値の設定
	# * ブランチを扱うArrayとHashの定義
	def initialize(name , h)

		@name = name
		@children = Array.new()
		@childrenCosts = Hash.new()
		@h=h
	end
	
	# ノードの名前を返す
	def getname()
		return @name
	end
	
	# 親へのポインタをセットする
	# == 引数
	# [node] 親ノードオブジェクト
	def setpointer(node)
		@pointer=node
	end
	
	# 親へのポインタを返す
	def getpointer()
		return @pointer
	end
	
	# g（コスト）を返す
	def getG()
		return @g
	end
	
	# g（コスト）をセットする
	# == 引数
	# [g] コスト
	def setG(g)
		@hasG = true
		@g = g
	end
	
	# h（ヒューリスティック値）を返す
	def getH()
		return @h
	end
	
	# f（評価値）を返す
	def getF()
		return @f
	end
	
	# f（評価値）をセットする
	# == 引数
	# [f] 評価値
	def setF(f)
		@hasF = true
		@f = f
	end
	
	# 子ノードを追加する
	# == 引数
	# [child] 子ノードオブジェクト
	# [cost] childへの経路コスト
	def addChild(child , cost)
		@children.push(child)
		@childrenCosts.store(child,cost)
	end
	
	# 子ノード一覧のArrayを返す
	def getChildren()
		return @children
	end
	
	# 子ノードへのコストを返す
	# ==引数
	# [child] 子ノードオブジェクト
	def getCost(child)
		@childrenCosts[child].to_i
	end
	
	# pメソッド対応のため実装。
	# 内部でto_sメソッドを呼んで返す。
	def inspect()
		return self.to_s()
	end
	
	# printメソッド対応のために実装。
	# == 表示書式
	# {ノード名}(h:{ヒューリスティック値})[(g:{コスト値})][f:{評価値}]
	def to_s
	result = String.new( @name + "(h:" + @h.to_s + ")")
		if @hasG then
			result = result + "(g:" + @g.to_s + ")"
		end
		if @hasG then
			result = result + "(f:" + @f.to_s + ")"
		end
		return result
	end
	
end

# グラフ探索を行なうためのSearchクラス
# == 謝辞（参考文献）
# 書籍「Java データ構造とアルゴリズム基礎講座」所収のコードをRubyに移植し，改造したものである．
# = プロパティ
# [node] ノード一覧
# [goal] 終点ノード
# [start] 始点ノード
class Search
	@node
	@goal
	@start
	
	# コンストラクタ
	# 状態空間を生成するメソッドを呼び出す
	def initialize()
		@node = Array.new
		#makeStateSpace()
	end
	
	# 状態空間にノードを追加する
	# == 引数
	# [name] ノード名
	# [heuristic] ヒューリスティック値
	# == 返り値
	# 登録されたノードID(Int）
	def newnode(name,heuristic)
		@node.push Node.new(name,heuristic)
		return @node.length-1
	end
	
	# 状態空間のノード間に枝を張る
	# == 引数
	# [parentid] 親のノードID
	# [childid] 子のノードID
	# [cost] 枝のコスト
	def newbranch(parentid,childid,cost)
		@node[parentid].addChild(@node[childid],cost)
	end
	
	# 状態空間の始点ノードと終点ノードを登録
	# == 引数
	# [starid] 始点ノードとするノードのID
	# [endid] 終点ノードとするノードのID
	def setstart_goal(startid,endid)
		@start = @node[startid]
		@goal = @node[endid]
	end
	
	
	# pメソッド対応のため実装。
	# 求められた経路をゴールからさかのぼって表示
	def inspect()
		return self.to_s()
	end
	
	def to_s()
		now = @goal
		
		result = ""
		
		while now.getpointer() != nil
			result = result + now.to_s + " <- "
			now = now.getpointer()
		end
		
		if now == @start then
			result = result + now.to_s + "\n *Route search was successful.*"
		else
			result = result + "*Route search failed."
		end
	end
	

	
	# A(A*)アルゴリズムによる最短路探索
	# 全てのノードに登録されたヒューリスティック値が0の場合，ダイクストラ法に一致する
	def aStar()
		open = Array.new
		open.push(@start)
		
		@start.setG(0)
		@start.setF(0)
		
		closed = Array.new
		
		success = false
		
		step = 0
		
		while true
			#ステップ数の表示とカウントアップ
			#print "STEP:" , step.to_s , "\n"
			step = step + 1
			
			#これからチェックするノードのリスト
			#print " OPEN:" , open.to_s , "\n"
			#チェックの終わったノードのリスト
			#print " closed:" , closed.to_s , "\n"
			
			if open.size == 0 then
			#もう調べるべきノードが存在しない場合falseを返して終わり
				success = false
				break
			else
				#調べるべきノードが存在する場合
				#次に調べるノードをopenからnodeへ移す
				node = open[0]
				open.delete_at(0)
				
				if node == @goal then
				#nodeがゴールならtrueを返して終わり
					success = true
					break
				else
				#nodeがまだゴールじゃない
					#nodeの子ノードを展開
					children = node.getChildren()
					
					#チェックの終わったノードリストにnodeを追加
					closed.push(node)
					
					children.size.times do |i|
						#子ノードのi番目をmに移す
						m = children[i]
						
						#nodeまでの評価値とnode->mのコストを足したものを
						#gmnとする
						gmn = node.getG().to_i + node.getCost(m).to_i
						
						if !open.include?(m) && !closed.include?(m) then
						#もしも、子ノードがopenにもclosedにも存在しないなら
						#（つまり未チェックかつチェック予定にも存在しないなら）
							#mのコストとしてgmnを入れる
							m.setG(gmn)
						end
						
						if open.include?(m) then
						#もしも、子ノードがopenに存在するならば
							if gmn < (m.getG()) then
							#今求めた評価値が、計算済みのコストより小さいなら
								#評価値を更新
								m.setG(gmn)
								#親ノードを更新
								m.setpointer(node)
							end
						end
						
						fmn = gmn + m.getH()
					
						if !open.include?(m) && !closed.include?(m) then
						#もしも、子ノードがopenにもclosedにも存在しないなら
						#（つまり未チェックかつチェック予定にも存在しないなら）
							#親ノードを更新
							m.setpointer(node)
							
							m.setF(fmn)
							open.push(m)
						end
						
						if open.include?(m) && fmn < m.getF() then
						#子ノードがチェック予定にあって評価値がfmnより低いなら
							#評価値をfmnにする
							m.setF(fmn)
							
							#チェック予定に追加
							open.push(m)
							
							#親ノードを更新
							m.setpointer(node)
						end
						
						if closed.include?(m) && fmn < m.getF() then
							#親ノードを更新
							m.setpointer(node)
							
							#評価値をfmnにする
							m.setF(fmn)
							
							#closedにある最初のmを削除
							closed.delete_at(closed.index(m))
							
							#チェック予定に追加
							open.push(m)
						end
					end
				end
			end
			open.sort!{|a,b|a.getF() <=> b.getF()}
		end
		return success
	end
end

# Music
# =プロパティ
# [chordlist] 和音クラス格納行列(Array)
# [chordgraph] 和音探索グラフ(Search)
# = 動作
# TPSの呼び出し元．
class Music
	@chordlist
	@chordgraph
	
	# 和声進行の解釈を行う
	# == 引数
	# [chordsheet] 和音名をカンマ区切りで列挙した文字列(String)
	# == 動作
	# * クラスの初期化を行う。
	# * chordlistの設定
	# * 和音探索グラフの生成
		def explain(chordsheet)
		#@chordlistを配列宣言
		@chordlist = Array.new
		
		#カンマ区切りで渡された和音名列を配列に分割
		chordlistbuf = chordsheet.split(',')
		
		#全ての調パターンを生成
		chordlistbuf.each_index do |cd|
			@chordlist.push(Array.new)
			(0..11).each do |rootpc|
				@chordlist[cd].push(Array[chordlistbuf[cd],rootpc,false])
				@chordlist[cd].push(Array[chordlistbuf[cd],rootpc,true])
			end
		end
		
		#ここから探索グラフの作成
		#グラフクラス生成
		@chordgraph = Search.new
		
		#グラフクラスにノードを登録し，ノード番号を記録
		@chordlist.each_index do |i|
			@chordlist[i].each_index do |j|
				nodename = @chordlist[i][j][0] + "/" + @chordlist[i][j][1].to_s + @chordlist[i][j][2].to_s
				@chordlist[i][j][3]=@chordgraph.newnode(nodename,0)
			end
		end
		
		
		#出発ノード・終点ノードを作成
		startid = @chordgraph.newnode("START",0)
		endid = @chordgraph.newnode("END",0)
		
		@chordgraph.setstart_goal(startid,endid)
		
		#1つ目の和音は，すべて出発ノードとコスト0でリンク作成
		@chordlist[0].each do |i|
			@chordgraph.newbranch(startid,i[3],0)
		end
		
		#最後の和音は，すべて終点ノードとコスト0でリンク作成
		@chordlist[(@chordlist.length) -1 ].each do |i|
			@chordgraph.newbranch(i[3],endid,0)
		end
		
		#各枝のコストを計算しながらリンクを作成
		
		tps_cal = Delta_Chord_calculator.new
		
		logfile = File.open("Test_log.txt",'a')
		logfile.print "\n @@ ",chordsheet," @@@\n"
		print "\n@@@ ",chordsheet," @@@\n"
		
		
		#(@chordlist.length) -1回繰り返し
		((@chordlist.length) -1).times do |i|
			#i番目の和音候補配列の全てから
			@chordlist[i].each do |j|
				#i+1番目の和音候補配列の全てへ
				@chordlist[i+1].each do |k|
					#Chordクラスの生成
					x = Chord.new(j[0])
					x.setkey(j[1],j[2])
					
					y = Chord.new(k[0])
					y.setkey(k[1],k[2])
					
					distance = tps_cal.calc_chord_delta(x,y)
					distance_ary = Array[tps_cal.get_last_delta_chord,tps_cal.get_last_delta_region,tps_cal.get_last_delta_basicspace]
					
					#枝作成
					@chordgraph.newbranch(j[3],k[3],distance)
					
					logfile.print j.to_s,"\t",distance,"(C:",distance_ary[0]," R:",distance_ary[1]," B:",distance_ary[2],")\t",k.to_s,"\n"
					#print j.to_s,"\t",distance,"\t",k.to_s,"\n"	#debug
				end
			end
			logfile.print "\n"
		end
		
		@chordgraph.aStar()
		
		logfile.print @chordgraph.inspect
		p @chordgraph
		
		logfile.close
	end
	

	
	# p method 対応
	def inspect()
		return  @chordgraph.to_s
	end

end


test_music = Music.new

#Musicクラスを生成し、explainメソッドにコードネーム列を渡すと、和音解釈を返します。
#test_music.explain("C,A 7,D m,G 7")
#test_music.explain("C,G,C")
#test_music.explain("C,F,C")

#"Fly me to the moon"冒頭部分のコード進行をexplainメソッドに与えた例
test_music.explain("A m 7,D m 7,G 7,C maj7, F maj7,B m 7 -5,E 7,A m 7,A 7,D m 7,G 7,C maj7 A 7,D m 7,G 7,C maj7,B m 7 -5,E 7")



