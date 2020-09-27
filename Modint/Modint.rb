#! ruby -Ks


# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

# ���W�������Z���鐮���N���X
# =�v���p�e�B
# [@value] �l(Int)
# [@mod] �@(Int)
class Modint
	@value = 0
	@mod = 1
	
	# �R���X�g���N�^
	# == ����
	# [val] �l(Int)
	# [mod] �@(Int)
	# == ����
	# * �l�Ɩ@��ݒ肷��
	def initialize(val,mod)
		# �@�̐ݒ�
		@mod = mod
		
		# �l�̐ݒ�
		self.set(val)
		
	end
	
	
	# �l��Ԃ�
	# == �߂�l
	# �l�iInt)
	def get()
		return @value
	end
	
	# �@��Ԃ�
	# == �߂�l
	# �@�iInt)
	def getmod()
		return @mod
	end

	
	# �l���Z�b�g����
	# == ����
	# [val] �l(Int)
	def set(val)
		@value = val % @mod
	end
	
	# p method �Ή�
	def inspect()
		return @value.to_s + " mod " + @mod.to_s
	end
	
	# �����Z
	# == ����
	# [other] �l(int)
	def add(other)
		case other
		when Integer
			buf = (@value + other) % @mod
		when Mod_int
			if other.getmod == self.getmod then
				buf = @value + other.get
			else
				raise "Divisor mismatch"
			end
		else
			raise TypeError
		end
		self.set(buf)
	end


	
end
