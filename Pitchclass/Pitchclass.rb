#! ruby -Ks


# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

# �s�b�`�N���X
# =�v���p�e�B
# [@value] pc�ԍ�
class Pitchclass
	@value
	
	# �R���X�g���N�^
	# == ����
	# [val] �l�ipc�ԍ�(int)�������͉p�ꉹ��(String)�j
	# == ����
	# * �l��ݒ肷��
	def initialize(val)
		# �l�̐ݒ�
		case val
			when Integer,String
				self.set(val)
			else
				raise TypeError
		end
	end
	
	
	# pc�ԍ���Ԃ�
	# == �߂�l
	# pc�ԍ��iInt)
	def get()
		return @value
	end
	
	# �p�ꉹ����Ԃ�
	# == �߂�l
	# �p�ꉹ���iString)
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
	
	# �p�ꉹ����Ԃ��i�Z�k�Łj
	# * �����͒ʏ�ʂ�
	# * �����̓t���b�g�\�L�ɓ���
	# == �߂�l
	# �Z�k�p�ꉹ���iString)
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
	
	# �s�b�`�N���X�̒l��ݒ�
	# == ����
	# val:: �l(pc�ԍ�(int)�܂��͉���(String)�j
	def set(val)
		case val
		when Integer
			#�l��0����11�܂�
			if (0<=val) && (val <=11) then
				@value = val
			else
				raise ArgumentError
			end
		when String
			#�����𑵂��邽�߂ɑ啶���ɕϊ�
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

	
	
	#  p method �Ή�
	def inspect()
		return @value.to_s + "(" + self.getname + ")"
	end
end

