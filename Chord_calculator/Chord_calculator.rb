#! ruby -Ks
# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Modint/Modint"
require "../Chord/Chord"
require "../Basicspace_calculator/Basicspace_calculator"


# Chord_calculator
# =�v���p�e�B
# [@chord_a] �R�[�h(Chord)
# [@chord_b] �R�[�h(Chord)
# [@delta] ���O�Ɍv�Z����Chord����(Int)
class Chord_calculator
	@chord_a
	@chord_b
	@chordcircle_a
	@chordcircle_b
	@pivot_a
	@pivot_b
	@delta
	
	#chord�֐��𑪒�ł��Ȃ��������ɕԂ��i�\���傫�ȁj�萔
	CHORD_DISTANCE_UNMEASURABLE = 99


	# chord�֐�
	# == ����
	# [in1] �R�[�h(Chord)
	# [in2] �R�[�h(Chord)
	# == �߂�l
	# �R�[�h�ԋ����iInt)
	def calc_chord(in1,in2)
	
		#�������v���p�e�B�ɋL�^����
		@chord_a = in1
		@chord_b = in2
		
		#�s���H�b�g���z������߂�
		#�s���H�b�g���K�v�Ȃ��ꍇ�i�܂�^����ꂽ�R�[�h���_�C�A�g�j�b�N�̏ꍇ�j�^����ꂽ�R�[�h�������̂܂ܓ���
		
		#@chord_a��chord circle�̒���@chord_a�̃R�[�h�l�[����T������D
		@pivot_a = Array.new
		@pivot_a = pickup_pivotlist(@chord_a)
		
		#@chord_b��chord circle�̒���@chord_b�̃R�[�h�l�[����T������D
		@pivot_b = Array.new
		@pivot_b = pickup_pivotlist(@chord_b)
		
		
		@chordcircle_a = make_chordcircle(@chord_a.getroot(),@chord_a.get_minorflag())
		@chordcircle_b = make_chordcircle(@chord_b.getroot(),@chord_b.get_minorflag())
		
		#���ʊi�[�pArray
		result = Array.new
		
		#@chord_a��chord circle�̒���@chord_b�̃s���H�b�g�R�[�h�������݂��邩�D
		#�S�Ẵs���H�b�g�R�[�h�̑g�ݍ��킹��T��
		#���ݒT���ΏۂƂȂ��Ă���chord_a�̃s���H�b�g�R�[�h����pivot_a_nowcheck
		#���ݒT���ΏۂƂȂ��Ă���chord_b�̃s���H�b�g�R�[�h����pivot_b_nowcheck
		@pivot_a[0].each do |pivot_a_nowcheck|
			@pivot_b[0].each do |pivot_b_nowcheck|
				if @chordcircle_a.include?(pivot_b_nowcheck) then
					#��������
					
					#�ȉ��C�a����5�x����̋������Z�o����
					#chord_a�̘a����5�x���pivot_a_nowcheck�����݂���ʒu���C��������̋N�_base_position�Ƃ���
					base_position = Modint.new(@chordcircle_a.index(pivot_a_nowcheck),@chordcircle_a.length)
					
					#�����v���J�E���^�����Z�b�g
					counter = 0
					
					#�a����5�x�������v���ɐ�����
					@chordcircle_a.length.times do |i|
						if @chordcircle_a[base_position.get()] == pivot_b_nowcheck then
							#pivot_b_nowcheck�ƈ�v�����琔����̂���߂�
							break
						else
							#pivot_b_nowcheck�ƈ�v���Ȃ����������1�X�e�b�v���v���ɐi��
							base_position.add(1)
							counter = counter +1
						end
					end
					
					#����������ꂽ�������a����5�x���̒����̔������傫����΁C
					#�����v���ɒT���������������������ɂȂ�̂ŁC�����v���̋����ɏC������
					if counter > (@chordcircle_a.length / 2.0) then
						counter = @chordcircle_a.length - counter
					end
					
					#�a����5�x������s���H�b�g�R�[�h�Ƃ��Ă̏ꍇ�C�O�ɐL�т��}�̕���ǉ�����
					if @pivot_a[1] == true then
						counter = counter +1
					end
					if @pivot_b[1] == true then
						counter = counter +1
					end
					
					#����ꂽ���������ʊi�[Array�Ƀv�b�V������
					result.push(counter)
				
				else
					#������Ȃ�������chord�����Z�o�s��
					#�\���ɑ傫�Ȓl�����ʂƂ��ăv�b�V������
					result.push(CHORD_DISTANCE_UNMEASURABLE)
				end
				
			end
		end
		
		
		
		#@chord_b��chord circle�̒���@chord_a�̃s���H�b�g�R�[�h�������݂��邩�D
		#�S�Ẵs���H�b�g�R�[�h�̑g�ݍ��킹��T��
		#���ݒT���ΏۂƂȂ��Ă���chord_a�̃s���H�b�g�R�[�h����pivot_a_nowcheck
		#���ݒT���ΏۂƂȂ��Ă���chord_b�̃s���H�b�g�R�[�h����pivot_b_nowcheck
		@pivot_b[0].each do |pivot_b_nowcheck|
			@pivot_a[0].each do |pivot_a_nowcheck|
				if @chordcircle_b.include?(pivot_a_nowcheck) then
					#��������
					
					#�ȉ��C�a����5�x����̋������Z�o����
					#chord_b�̘a����5�x���pivot_b_nowcheck�����݂���ʒu���C��������̋N�_base_position�Ƃ���
					base_position = Modint.new(@chordcircle_b.index(pivot_b_nowcheck),@chordcircle_b.length)
					
					#�����v���J�E���^�����Z�b�g
					counter = 0
					
					#�a����5�x�������v���ɐ�����
					@chordcircle_b.length.times do |i|
						if @chordcircle_b[base_position.get()] == pivot_a_nowcheck then
							#pivot_a_nowcheck�ƈ�v�����琔����̂���߂�
							break
						else
							#pivot_a_nowcheck�ƈ�v���Ȃ����������1�X�e�b�v���v���ɐi��
							base_position.add(1)
							counter = counter +1
						end
					end
					
					#����������ꂽ�������a����5�x���̒����̔������傫����΁C
					#�����v���ɒT���������������������ɂȂ�̂ŁC�����v���̋����ɏC������
					if counter > (@chordcircle_b.length / 2.0) then
						counter = @chordcircle_b.length - counter
					end
					
					#�a����5�x������s���H�b�g�R�[�h�Ƃ��Ă̏ꍇ�C�O�ɐL�т��}�̕���ǉ�����
					if @pivot_a[1] == true then
						counter = counter +1
					end
					if @pivot_b[1] == true then
						counter = counter +1
					end
					
					#����ꂽ���������ʊi�[Array�Ƀv�b�V������
					result.push(counter)
				
				else
					#������Ȃ�������chord�����Z�o�s��
					#�\���ɑ傫�Ȓl�����ʂƂ��ăv�b�V������
					result.push(CHORD_DISTANCE_UNMEASURABLE)
				end
			end
		end
		
		#���ʊi�[�pArray�̂����C�ŏ��̂��̂��o�͂���
		minimum = result[0]		#�����l�Ƃ��Đ擪����
		result.each do |i|
			if minimum > i then
				minimum = i
			end
		end
		
		@delta = minimum
		return @delta
	end
	
	# 5�x����\���z��𐶐�����
	# == ����
	# [root] ���̃��[�g��(Int)
	# [is_minor] ����/�Z���t���O(Boolean)�yTrue->�Z��,False->�����z 
	# == �߂�l
	# 5�x���iArray)
	def make_chordcircle(root,is_minor)
		chordcircle=Array.new
		
		
		if is_minor == false then
			#�����̂Ƃ�
			#���̃��b�N�A�b�v�e�[�u���́w�R�[�h�i�s�X�^�C���u�b�N�xp.182�Ɋ�Â��D
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
			#�Z���̎�
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
	
	# �a����5�x���̒�����C�x�[�V�b�N�X�y�[�X�������ł��߂��a���i�s���H�b�g�j���z������߂�
	# == ����
	# [chord] �s���H�b�g�����߂�R�[�h(Chord)
	# == �߂�l
	# �s���H�b�g���z��iArray)�i�߂�lpivot[0]�̓s���H�b�g���R�[�h�����X�g�Cpivot[1]�̓s���H�b�g���K�v���ۂ��̃t���O�j

	def pickup_pivotlist(chord)
		#chord��chord circle�̒���chord�̃R�[�h�l�[����T������D
		#chord�̒u���ꂽ���ɑΉ�����chordcircle�𐶐�
		chordcircle = Array.new
		chordcircle[0] = make_chordcircle(chord.getroot(),chord.get_minorflag())
		chordcircle[1]  = Array.new()
		
		#�s���H�b�g���i�[�z��̐���
		#�s���H�b�g���͕�������\��������̂Ŕz��`��
		pivot = Array.new

		if chordcircle[0].include?(chord.getchordname()) == true then
			#chord circle�ɃR�[�h�l�[�����܂܂�Ă���
			#�s���H�b�g�͂���Ȃ��D���̂܂܃R�[�h�����i�[����D
			
			need_pivot_flag = false
			pivot[0] = chord.getchordname()
			
		else
			#chord circle�ɃR�[�h�l�[�����܂܂�Ă��Ȃ�
			#basicspace�֐����g���ăs���H�b�g�R�[�h��T���D
			
			need_pivot_flag = true
			
			#�x�[�V�b�N�X�y�[�X�Z�o�N���X����
			bcalc = Basicspace_calculator.new()
			#�S�Ẵ_�C�A�g�j�b�N�R�[�h��a�̃R�[�h�̃x�[�V�b�N�X�y�[�X�������Z�o����
			chordcircle[0].each_index do |i|
				#��r�ΏۃR�[�h�����o����Chord�N���X�𐶐�
				diatonic = Chord.new(chordcircle[0][i])
				diatonic.setkey(chord.getroot(),chord.get_minorflag())
				
				#�x�[�V�b�N�X�y�[�X�������Z�o���Ċi�[
				chordcircle[1][i] = bcalc.calc_basicspace(diatonic,chord)
			end
			
			#�x�[�V�b�N�X�y�[�X�����̍ŏ��l�����߂�
			minimum = chordcircle[1][0]		#�����l�Ƃ��Đ擪���x�[�V�b�N�X�y�[�X��������
			chordcircle[1].each_index do |i|
				if minimum > chordcircle[1][i] then
					minimum = chordcircle[1][i]
				end
			end
			
			#�ŏ��l�̋������������_�C�A�g�j�b�N�R�[�h�����s���H�b�g���Ƃ��Ď��o��
			chordcircle[1].each_index do |i|
			
				if chordcircle[1][i] == minimum then
					pivot.push(chordcircle[0][i])
				end
			end
		end
		
		return Array[pivot,need_pivot_flag]
	
	end
	
	# �Ō�ɋ��߂�Chord������Ԃ�
	# == �߂�l
	# ����(Int)
	def get_last_delta()
		return @delta
	end

	#p method�Ή�
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


