#! ruby -Ks
# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Chord/Chord"
require "../Delta_chord_calcurator/Delta_chord_calcurator"


# �O���t���������邽�߂̃m�[�h�N���X
# == �ӎ��i�Q�l�����j
# ���ЁuJava �f�[�^�\���ƃA���S���Y����b�u���v�����̃R�[�h��Ruby�ɈڐA�������̂ł���D
# = �v���p�e�B
# [name] �m�[�h��
# [children] �q�m�[�h�̊i�[���ꂽArray
# [childrenCost] �q�m�[�h�ւ̃R�X�g���i�[���ꂽArray
# [pointer] �e�ւ̃|�C���^
# [g] �R�X�g
# [h] �q���[���X�e�B�b�N�l
# [f = 0] �]���l
# [hasG = false] �R�X�g�ݒ�ς݃t���O
# [hasF = false] �]���l�ݒ�ς݃t���O
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
	
	# �R���X�g���N�^
	# = ����
	# name:: �m�[�h��
	# h:: �q���[���X�e�B�b�N�l
	# =��ȓ���
	# * �m�[�h���A�q���[���X�e�B�b�N�l�̐ݒ�
	# * �u�����`������Array��Hash�̒�`
	def initialize(name , h)

		@name = name
		@children = Array.new()
		@childrenCosts = Hash.new()
		@h=h
	end
	
	# �m�[�h�̖��O��Ԃ�
	def getname()
		return @name
	end
	
	# �e�ւ̃|�C���^���Z�b�g����
	# == ����
	# [node] �e�m�[�h�I�u�W�F�N�g
	def setpointer(node)
		@pointer=node
	end
	
	# �e�ւ̃|�C���^��Ԃ�
	def getpointer()
		return @pointer
	end
	
	# g�i�R�X�g�j��Ԃ�
	def getG()
		return @g
	end
	
	# g�i�R�X�g�j���Z�b�g����
	# == ����
	# [g] �R�X�g
	def setG(g)
		@hasG = true
		@g = g
	end
	
	# h�i�q���[���X�e�B�b�N�l�j��Ԃ�
	def getH()
		return @h
	end
	
	# f�i�]���l�j��Ԃ�
	def getF()
		return @f
	end
	
	# f�i�]���l�j���Z�b�g����
	# == ����
	# [f] �]���l
	def setF(f)
		@hasF = true
		@f = f
	end
	
	# �q�m�[�h��ǉ�����
	# == ����
	# [child] �q�m�[�h�I�u�W�F�N�g
	# [cost] child�ւ̌o�H�R�X�g
	def addChild(child , cost)
		@children.push(child)
		@childrenCosts.store(child,cost)
	end
	
	# �q�m�[�h�ꗗ��Array��Ԃ�
	def getChildren()
		return @children
	end
	
	# �q�m�[�h�ւ̃R�X�g��Ԃ�
	# ==����
	# [child] �q�m�[�h�I�u�W�F�N�g
	def getCost(child)
		@childrenCosts[child].to_i
	end
	
	# p���\�b�h�Ή��̂��ߎ����B
	# ������to_s���\�b�h���Ă�ŕԂ��B
	def inspect()
		return self.to_s()
	end
	
	# print���\�b�h�Ή��̂��߂Ɏ����B
	# == �\������
	# {�m�[�h��}(h:{�q���[���X�e�B�b�N�l})[(g:{�R�X�g�l})][f:{�]���l}]
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

# �O���t�T�����s�Ȃ����߂�Search�N���X
# == �ӎ��i�Q�l�����j
# ���ЁuJava �f�[�^�\���ƃA���S���Y����b�u���v�����̃R�[�h��Ruby�ɈڐA���C�����������̂ł���D
# = �v���p�e�B
# [node] �m�[�h�ꗗ
# [goal] �I�_�m�[�h
# [start] �n�_�m�[�h
class Search
	@node
	@goal
	@start
	
	# �R���X�g���N�^
	# ��ԋ�Ԃ𐶐����郁�\�b�h���Ăяo��
	def initialize()
		@node = Array.new
		#makeStateSpace()
	end
	
	# ��ԋ�ԂɃm�[�h��ǉ�����
	# == ����
	# [name] �m�[�h��
	# [heuristic] �q���[���X�e�B�b�N�l
	# == �Ԃ�l
	# �o�^���ꂽ�m�[�hID(Int�j
	def newnode(name,heuristic)
		@node.push Node.new(name,heuristic)
		return @node.length-1
	end
	
	# ��ԋ�Ԃ̃m�[�h�ԂɎ}�𒣂�
	# == ����
	# [parentid] �e�̃m�[�hID
	# [childid] �q�̃m�[�hID
	# [cost] �}�̃R�X�g
	def newbranch(parentid,childid,cost)
		@node[parentid].addChild(@node[childid],cost)
	end
	
	# ��ԋ�Ԃ̎n�_�m�[�h�ƏI�_�m�[�h��o�^
	# == ����
	# [starid] �n�_�m�[�h�Ƃ���m�[�h��ID
	# [endid] �I�_�m�[�h�Ƃ���m�[�h��ID
	def setstart_goal(startid,endid)
		@start = @node[startid]
		@goal = @node[endid]
	end
	
	
	# p���\�b�h�Ή��̂��ߎ����B
	# ���߂�ꂽ�o�H���S�[�����炳���̂ڂ��ĕ\��
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
	

	
	# A(A*)�A���S���Y���ɂ��ŒZ�H�T��
	# �S�Ẵm�[�h�ɓo�^���ꂽ�q���[���X�e�B�b�N�l��0�̏ꍇ�C�_�C�N�X�g���@�Ɉ�v����
	def aStar()
		open = Array.new
		open.push(@start)
		
		@start.setG(0)
		@start.setF(0)
		
		closed = Array.new
		
		success = false
		
		step = 0
		
		while true
			#�X�e�b�v���̕\���ƃJ�E���g�A�b�v
			#print "STEP:" , step.to_s , "\n"
			step = step + 1
			
			#���ꂩ��`�F�b�N����m�[�h�̃��X�g
			#print " OPEN:" , open.to_s , "\n"
			#�`�F�b�N�̏I������m�[�h�̃��X�g
			#print " closed:" , closed.to_s , "\n"
			
			if open.size == 0 then
			#�������ׂ�ׂ��m�[�h�����݂��Ȃ��ꍇfalse��Ԃ��ďI���
				success = false
				break
			else
				#���ׂ�ׂ��m�[�h�����݂���ꍇ
				#���ɒ��ׂ�m�[�h��open����node�ֈڂ�
				node = open[0]
				open.delete_at(0)
				
				if node == @goal then
				#node���S�[���Ȃ�true��Ԃ��ďI���
					success = true
					break
				else
				#node���܂��S�[������Ȃ�
					#node�̎q�m�[�h��W�J
					children = node.getChildren()
					
					#�`�F�b�N�̏I������m�[�h���X�g��node��ǉ�
					closed.push(node)
					
					children.size.times do |i|
						#�q�m�[�h��i�Ԗڂ�m�Ɉڂ�
						m = children[i]
						
						#node�܂ł̕]���l��node->m�̃R�X�g�𑫂������̂�
						#gmn�Ƃ���
						gmn = node.getG().to_i + node.getCost(m).to_i
						
						if !open.include?(m) && !closed.include?(m) then
						#�������A�q�m�[�h��open�ɂ�closed�ɂ����݂��Ȃ��Ȃ�
						#�i�܂薢�`�F�b�N���`�F�b�N�\��ɂ����݂��Ȃ��Ȃ�j
							#m�̃R�X�g�Ƃ���gmn������
							m.setG(gmn)
						end
						
						if open.include?(m) then
						#�������A�q�m�[�h��open�ɑ��݂���Ȃ��
							if gmn < (m.getG()) then
							#�����߂��]���l���A�v�Z�ς݂̃R�X�g��菬�����Ȃ�
								#�]���l���X�V
								m.setG(gmn)
								#�e�m�[�h���X�V
								m.setpointer(node)
							end
						end
						
						fmn = gmn + m.getH()
					
						if !open.include?(m) && !closed.include?(m) then
						#�������A�q�m�[�h��open�ɂ�closed�ɂ����݂��Ȃ��Ȃ�
						#�i�܂薢�`�F�b�N���`�F�b�N�\��ɂ����݂��Ȃ��Ȃ�j
							#�e�m�[�h���X�V
							m.setpointer(node)
							
							m.setF(fmn)
							open.push(m)
						end
						
						if open.include?(m) && fmn < m.getF() then
						#�q�m�[�h���`�F�b�N�\��ɂ����ĕ]���l��fmn���Ⴂ�Ȃ�
							#�]���l��fmn�ɂ���
							m.setF(fmn)
							
							#�`�F�b�N�\��ɒǉ�
							open.push(m)
							
							#�e�m�[�h���X�V
							m.setpointer(node)
						end
						
						if closed.include?(m) && fmn < m.getF() then
							#�e�m�[�h���X�V
							m.setpointer(node)
							
							#�]���l��fmn�ɂ���
							m.setF(fmn)
							
							#closed�ɂ���ŏ���m���폜
							closed.delete_at(closed.index(m))
							
							#�`�F�b�N�\��ɒǉ�
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
# =�v���p�e�B
# [chordlist] �a���N���X�i�[�s��(Array)
# [chordgraph] �a���T���O���t(Search)
# = ����
# TPS�̌Ăяo�����D
class Music
	@chordlist
	@chordgraph
	
	# �a���i�s�̉��߂��s��
	# == ����
	# [chordsheet] �a�������J���}��؂�ŗ񋓂���������(String)
	# == ����
	# * �N���X�̏��������s���B
	# * chordlist�̐ݒ�
	# * �a���T���O���t�̐���
		def explain(chordsheet)
		#@chordlist��z��錾
		@chordlist = Array.new
		
		#�J���}��؂�œn���ꂽ�a�������z��ɕ���
		chordlistbuf = chordsheet.split(',')
		
		#�S�Ă̒��p�^�[���𐶐�
		chordlistbuf.each_index do |cd|
			@chordlist.push(Array.new)
			(0..11).each do |rootpc|
				@chordlist[cd].push(Array[chordlistbuf[cd],rootpc,false])
				@chordlist[cd].push(Array[chordlistbuf[cd],rootpc,true])
			end
		end
		
		#��������T���O���t�̍쐬
		#�O���t�N���X����
		@chordgraph = Search.new
		
		#�O���t�N���X�Ƀm�[�h��o�^���C�m�[�h�ԍ����L�^
		@chordlist.each_index do |i|
			@chordlist[i].each_index do |j|
				nodename = @chordlist[i][j][0] + "/" + @chordlist[i][j][1].to_s + @chordlist[i][j][2].to_s
				@chordlist[i][j][3]=@chordgraph.newnode(nodename,0)
			end
		end
		
		
		#�o���m�[�h�E�I�_�m�[�h���쐬
		startid = @chordgraph.newnode("START",0)
		endid = @chordgraph.newnode("END",0)
		
		@chordgraph.setstart_goal(startid,endid)
		
		#1�ڂ̘a���́C���ׂďo���m�[�h�ƃR�X�g0�Ń����N�쐬
		@chordlist[0].each do |i|
			@chordgraph.newbranch(startid,i[3],0)
		end
		
		#�Ō�̘a���́C���ׂďI�_�m�[�h�ƃR�X�g0�Ń����N�쐬
		@chordlist[(@chordlist.length) -1 ].each do |i|
			@chordgraph.newbranch(i[3],endid,0)
		end
		
		#�e�}�̃R�X�g���v�Z���Ȃ��烊���N���쐬
		
		tps_cal = Delta_Chord_calculator.new
		
		logfile = File.open("Test_log.txt",'a')
		logfile.print "\n @@ ",chordsheet," @@@\n"
		print "\n@@@ ",chordsheet," @@@\n"
		
		
		#(@chordlist.length) -1��J��Ԃ�
		((@chordlist.length) -1).times do |i|
			#i�Ԗڂ̘a�����z��̑S�Ă���
			@chordlist[i].each do |j|
				#i+1�Ԗڂ̘a�����z��̑S�Ă�
				@chordlist[i+1].each do |k|
					#Chord�N���X�̐���
					x = Chord.new(j[0])
					x.setkey(j[1],j[2])
					
					y = Chord.new(k[0])
					y.setkey(k[1],k[2])
					
					distance = tps_cal.calc_chord_delta(x,y)
					distance_ary = Array[tps_cal.get_last_delta_chord,tps_cal.get_last_delta_region,tps_cal.get_last_delta_basicspace]
					
					#�}�쐬
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
	

	
	# p method �Ή�
	def inspect()
		return  @chordgraph.to_s
	end

end


test_music = Music.new

#Music�N���X�𐶐����Aexplain���\�b�h�ɃR�[�h�l�[�����n���ƁA�a�����߂�Ԃ��܂��B
#test_music.explain("C,A 7,D m,G 7")
#test_music.explain("C,G,C")
#test_music.explain("C,F,C")

#"Fly me to the moon"�`�������̃R�[�h�i�s��explain���\�b�h�ɗ^������
test_music.explain("A m 7,D m 7,G 7,C maj7, F maj7,B m 7 -5,E 7,A m 7,A 7,D m 7,G 7,C maj7 A 7,D m 7,G 7,C maj7,B m 7 -5,E 7")



