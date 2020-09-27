#! ruby -Ks
# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Chord/Chord"
require "../Basicspace/Basicspace"
require "../Pitchclass/Pitchclass"

# Region_calculator
# = �v���p�e�B
# [chord_a] �R�[�h(Chord)
# [chord_b] �R�[�h(Chord)
# [delta] ���O�Ɍv�Z����Region����(Int)

class Region_calculator
	@chord_a
	@chord_b
	@delta
	
	# 2��region(��)�ԋ������Z�o
	# �����̌ܓx���Ɋ�Â��ĎZ�o�i�Z����̘a���͗\�ߕ��s���ɕϊ�����K�v������j
	# == ����
	# [chord_a] �R�[�h�l�[��(Chord)
	# [chord_b] �R�[�h�l�[��(Chord)
	# == �߂�l
	# ����(Int)

	def calc_region(chord_a,chord_b)
		#�������v���p�e�B�ɋL�^����
		@chord_a = chord_a
		@chord_b = chord_b
		
		#�e�R�[�h�̒����[�g�����o���āAModint�^�̐��l�Ƃ���
		key_chord_a = Modint.new(@chord_a.getroot,12)
		key_chord_b = Modint.new(@chord_b.getroot,12)
		
		#�e�R�[�h���Z���������ꍇ�A����𕽍s���i����������p���钷���j�ɕϊ�����
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
		
		#���b�N�A�b�v�e�[�u�����Q�Ƃ��Ēl��Ԃ�
		#regiontable�̃f�[�^�͘_���Ɋ�Â��B
		#12�s1��ڂ̒l�͘_���̌��ł���C�����ς�
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
	
	# �Ō�ɋ��߂�Region������Ԃ�
	# == �߂�l
	# ����(Int)
	def get_last_delta()
		return @delta
	end

	
	# p method �Ή�
	def inspect()
		print "Region(",@chord_a.getkeyname," , ",@chord_b.getkeyname," ) = ",@delta,"\n"
	end


end

