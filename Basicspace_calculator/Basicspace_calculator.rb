#! ruby -Ks
# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Chord/Chord"
require "../Basicspace/Basicspace"
require "../Pitchclass/Pitchclass"

# Basicspace_calculator
# =�v���p�e�B
# [chord_a] �R�[�h�l�[��(Chord)
# [chord_b] �R�[�h�l�[��(Chord)
# [a_bs] chord_a�̃x�[�V�b�N�X�y�[�X(Basicspace)
# [b_bs] chord_b�̃x�[�V�b�N�X�y�[�X(Basicspace)
# [delta] ���O�Ɍv�Z�����x�[�V�b�N�X�y�[�X����(Int)
class Basicspace_calculator
	@chord_a
	@chord_b
	@a_bs
	@b_bs
	@delta

	# �x�[�V�b�N�X�y�[�X�֐��̒l���Z�o����
	# == ����
	# [chord_a] �R�[�h�l�[��(Chord)
	# [chord_b] �R�[�h�l�[��(Chord)
	# == �߂�l
	# ����(Int)
	def	calc_basicspace (chord_a,chord_b)
		
		#�������v���p�e�B�ɋL�^����
			@chord_a = chord_a
			@chord_b = chord_b
			

		
		#�x�[�V�b�N�X�y�[�X�̐���
		
			@a_bs = Basicspace.new(@chord_a.getchordname(),@chord_a.getroot(),@chord_a.get_minorflag())
			@b_bs = Basicspace.new(@chord_b.getchordname(),@chord_b.getroot(),@chord_b.get_minorflag())
			
		#�����̎Z�o
			@delta = delta_basicspace()
		
			return @delta
	end
	
	
	# �x�[�V�b�N�X�y�[�X�ԋ������Z�o
	# == ����
	# [bs_a] �������Z�o�����x�[�V�b�N�X�y�[�X(Basicspace)
	# [bs_b] �������Z�o����x�[�V�b�N�X�y�[�X(Basicspace)
	# == �߂�l
	# ����(Int)
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
	
	# �Ō�ɋ��߂��x�[�V�b�N�X�y�[�X�ԋ�����Ԃ�
	# == �߂�l
	# ����(Int)
	def get_last_delta()
		return @delta
	end
	
	# p method �Ή�
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


