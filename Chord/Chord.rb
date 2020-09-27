#! ruby -Ks


# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Pitchclass/Pitchclass"


# �R�[�h �N���X
# =�v���p�e�B
# [@chordnaame] �R�[�h�l�[��(String)�y�K�{�z
# [@root]  ���̃��[�g(Int)
# [@is_minor]  ����/�Z���t���O(Boolean)�yTrue->�Z��,False->�����z
class Chord
	@chordname
	@root
	@is_minor

	# �R���X�g���N�^
	# == ����
	# [chordname]  �R�[�h�l�[��(String)
	# == ����
	# * �R�[�h�l�[����ݒ肵�A�N���X�̏��������s���B
	def initialize(chordname)
		# �R�[�h�l�[���̐ݒ�
		self.setchordname(chordname)
	end
	
	# �R�[�h�l�[���̐ݒ�
	# == ����
	# [chordname] �R�[�h�l�[��(String)
	def setchordname(chordname)
		@chordname = chordname
	end


	# ����ݒ肷��B
	# * �����̂��������ꂩ��nil�Ȃ�ΐݒ���폜����
	# * ������2�w�肳��Ă���΁A�����[�g���ƒ����E�Z����ݒ肷��
	# == ����
	# [root] ���̃��[�g(�����������͕����w��)
	# [is_minor] ����/�Z���t���O(True->�Z��,False->����)
	def setkey(root,is_minor)
		if (root == nil) || (is_minor == nil) then
			#�����̂����ꂩ��nil�Ȃ�ݒ���폜
			@root = nil
			@is_minor = nil
		else
			
			#���[�g�̐ݒ�
			#�����ɂ��w��Ɛ����ɂ��w��ɑΉ�
			case root
				when String
					#�����i�����j�ɂ��w��
					buf = Pitchclass.new(root)
					@root = buf.get
				when Integer
					#�����ɂ��w��
					if (0<=root) && (root <= 11) then
						@root = root
					else
						#�ُ͈͈�
						raise ArgumentError
					end
				else
					raise TypeError
			end
			
			#����/�Z���t���O�̐ݒ�
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




	# �R�[�h�l�[����Ԃ�
	# == �߂�l
	# �R�[�h�l�[���iString)
	def getchordname()
		return @chordname
	end
	
	# ������Ԃ�
	# == �߂�l
	# �����iString)
	def getkeyname()
		buf = Pitchclass.new(@root)
		keyname = buf.getname
		if @is_minor then
			return keyname + " minor"
		else
			return keyname + " major"
		end
		
	end
	
	# ����/�Z���t���O��Ԃ�
	# == �߂�l
	# ����/�Z���t���O�iBoolean)
	def get_minorflag()
		return @is_minor
	end
	
	# ���̃��[�g��Ԃ�
	# == �߂�l
	# ���[�g�iInt)
	def getroot()
		return @root
	end

	
	# p method �Ή�
	def inspect()
		print "[",self.getchordname,"]"
		if @root != nil then
			print " in ", self.getkeyname
		return nil
		end
	end
end







