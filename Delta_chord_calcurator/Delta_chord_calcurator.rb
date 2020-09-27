#! ruby -Ks
# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Chord/Chord"
require "../Basicspace_calculator/Basicspace_calculator"
require "../Chord_calculator/Chord_calculator"
require "../Region_calculator/Region_calculator"


# Delta_Chord_calculator
# =�v���p�e�B
# [chord_a] �R�[�h�l�[��(Chord)
# [chord_b] �R�[�h�l�[��(Chord)
# [delta] ���O�Ɍv�Z�����a����������(Int)
class Delta_Chord_calculator
	
	@chord_a
	@chord_b
	@delta
	@basicspace_cal
	@region_cal
	@chord_cal

	# �R���X�g���N�^
	# == ����
	# * �N���X�̏��������s���B
	def initialize()
		@basicspace_cal = Basicspace_calculator.new()
		@region_cal = Region_calculator.new()
		@chord_cal = Chord_calculator.new()
	end

	
	
	# delta�֐�
	# == ����
	# [chord_1] �R�[�h(Chord)
	# [chord_2] �R�[�h(Chord)
	# == �߂�l
	# �a�������iInt)
	# == ����
	# * �^����ꂽ2�̃R�[�h�́C�a���ԋ��������߂�D
	def calc_chord_delta(chord_1,chord_2)
		
		@chord_a = chord_1
		@chord_b = chord_2
		
		result =		  @basicspace_cal.calc_basicspace(@chord_a,@chord_b)
		result = result	+ @region_cal.calc_region(@chord_a,@chord_b)
		result = result	+ @chord_cal.calc_chord(@chord_a,@chord_b)
		
		@delta = result
		
		return @delta
	end
	
	def get_last_delta_chord
		return @chord_cal.get_last_delta()
	end
	
	def get_last_delta_region
		return @region_cal.get_last_delta()
	end
	
	def get_last_delta_basicspace
		return @basicspace_cal.get_last_delta()
	end
	
	# p method �Ή�
	def inspect()
		puts "***** Result *****"
		print "Region(",@chord_a.getchordname,"/",@chord_a.getkeyname,",",@chord_b.getchordname,"/",@chord_b.getkeyname,")\t=\t",@region_cal.get_last_delta(),"\n"
		print "Chord(",@chord_a.getchordname,"/",@chord_a.getkeyname,",",@chord_b.getchordname,"/",@chord_b.getkeyname,")\t=\t",@chord_cal.get_last_delta(),"\n"
		print "Basicspace(",@chord_a.getchordname,"/",@chord_a.getkeyname,",",@chord_b.getchordname,"/",@chord_b.getkeyname,")\t=\t",@basicspace_cal.get_last_delta(),"\n"

		print "\ndelta(",@chord_a.getchordname,"/",@chord_a.getkeyname,",",@chord_b.getchordname,"/",@chord_b.getkeyname,")\t=\t",@delta,"\n\n"
		
		puts "*** Details : Region ***"
		p @region_cal
		puts "*** Details : Chord ***"
		p @chord_cal
		puts "*** Details : Basicspace ***"
		p @basicspace_cal
		
	end


end

#	chord_a = Chord.new("G 7")
#	chord_a.setkey("C",false)
#	chord_b = Chord.new("C")
#	chord_b.setkey("D",true)
#
#	test = Delta_Chord_calculator.new()
#	p test.calc_chord_delta(chord_a,chord_b)
#	p test