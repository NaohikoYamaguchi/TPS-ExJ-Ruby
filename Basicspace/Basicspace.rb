#! ruby -Ks
# Author::    Naohiko Yamaguchi
# Copyright:: Copyright (c) 2011 Naohiko Yamaguchi,Kogakuin Univ.
# License::   New BSD License

require "../Modint/Modint"
require "../Pitchclass/Pitchclass"

# Basicspace
# = �v���p�e�B
# [@bs] �x�[�V�b�N�X�y�[�X(Array)
class Basicspace
	@bs
	
	# �R���X�g���N�^
	# = ����
	# [chordname] �R�[�h�l�[��(String)
	# [root] ���̃��[�g(Int)
	# [is_minor] ����/�Z���t���O(True->�Z��,False->����)(Boolean)
	# =����
	# *�x�[�V�b�N�X�y�[�X�̐���
	def initialize(chordname,root,is_minor)
		
		#�x�[�V�b�N�X�y�[�X�̐���
		self.genbs(chordname,root,is_minor)
		
	end
	
	# �x�[�V�b�N�X�y�[�X�𐶐�����
	# == ����
	# [chordname] �R�[�h�l�[��(String)
	# [root] ���̃��[�g(Int)
	# [is_minor] ����/�Z���t���O(True->�Z��,False->����)(Boolean)
	def genbs(chordname,root,is_minor)
		#�z��̏�����
		#�����l�͂��ׂ�1
		@bs = Array.new(12,1)
		
		#���\�����̏d�݂�1���x�����₷
		self.genbs_keyconstructnote(root,is_minor)
		
		#�R�[�h�l�[������a�����\������
		self.genbs_chordstructnote(chordname)
	end
	
	# �x�[�V�b�N�X�y�[�X�̒��\�������x��������
	# == ����
	# [root] ���̃��[�g(Int)
	# [is_minor] ����/�Z���t���O(True->�Z��,False->����)(Boolean)
	def genbs_keyconstructnote(root,is_minor)
		#���̃��[�g�̃s�b�`�N���X�����߂�
		nowpc = Modint.new(root,12)
		
		
		#����/�Z���ŏꍇ�킯
		if is_minor then
			#�Z���̏ꍇ�i���R�Z���K�j
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#�S
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(1)	#��
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#�S
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#�S
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(1)	#��
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#�S
			@bs[nowpc.get]=@bs[nowpc.get]+1
		else
			#�����̏ꍇ
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#�S
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#�S
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(1)	#��
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#�S
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#�S
			@bs[nowpc.get]=@bs[nowpc.get]+1
			
			nowpc.add(2)	#�S
			@bs[nowpc.get]=@bs[nowpc.get]+1
		end

	end

	# �x�[�V�b�N�X�y�[�X�̘a���\�������x��������
	# == ����
	# [chordname] �R�[�h�l�[��(String)
	# == �R�[�h�l�[���p�[�T�ɑ΂��钍��
	# ���̃R�[�h�l�[���p�[�T�͎b��łł���C�ȉ��̐�������D
	# *���[�g���C�e�R�[�h�l�[�����\�����镔�i�͔��p�X�y�[�X�ŋ�؂�K�v������(��:"Cm7-5"->"C m 7 -5")
	# *�R�[�h�l�[���̕��@���ɂ��Ă͍l�����Ă��Ȃ�
	# == �Ή�����R�[�h�l�[��
	# ���݁C�ȉ��Ɏ����R�[�h�l�[���ɑΉ����Ă���D(@�̓R�[�h�̎剹�j
	# [@] ���W���[�R�[�h
	# [@m] �}�C�i�[�R�[�h
	# [@maj7] ���W���[�E�Z�u���X
	# [@mmaj7] �}�C�i�[�E���W���[�E�Z�u���X
	# [@aug] �I�[�M�������g(��5�x)
	# [@-5] (alt�Ɠ����Ӗ�)�t���b�g�t�@�C�u(��5�x)
	# [@alt] (-5�Ɠ����Ӗ�)�A���^�[�h(��5�x)
	# [@7] �Z�u���X
	# [@m7] �}�C�i�[�E�Z�u���X
	# [@aug7] �I�[�M�������g�E�Z�u���X
	# [@7-5] �A���^�[�h�E�Z�u���X
	# [@dim] �f�B�~�j�b�V��(�����ł̓N���V�b�N���y���_���ɎO�a���Ƃ��Ē�`)
	# [@m7-5] �}�C�i�[�Z�u���E�t���b�e�b�h�t�@�C�u
	# [@dim(M7)] �f�B�~�j�b�V���h�E���W���[�Z�u���X
	# [@sus4] �T�X�y���f�b�h�E�t�H�[
	# [@7sus4] �Z�u���X�E�T�X�y���f�b�h�E�t�H�[
	def genbs_chordstructnote(chordname)
		#�b���
		chord = chordname.split(" ")
		
		#���[�g��
		buf = Pitchclass.new(chord[0])
		rootpc=Modint.new(buf.get,12)
		nowpc=Modint.new(rootpc.get,12)
		@bs[nowpc.get]=6
		
		#��3���Ƒ�5�����Z�b�g���ꂽ���ǂ����̃t���O
		setno3 = false
		setno5 = false
		
		#m�̏ꍇ
		if chord[1]=="m" then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(3)
			@bs[nowpc.get]=4
			setno3 = true
			
		end
		
		#dim�̏ꍇ
		if chord[1]=="dim" then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(3)
			@bs[nowpc.get]=4
			setno3 = true
			
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(6)
			@bs[nowpc.get]=5
			setno5 = true
			
			#�N���V�b�N���y�̋L�@�ɍ��킹��dim�͎O�a���Ƃ���D
			#�ȉ��̃R�����g���O����4�a���ƂȂ�
			#nowpc=Modint.new(rootpc.get,12)
			#nowpc.add(9)
			#@bs[nowpc.get]=3
		end
		
		#aug������ꍇ
		if chord.include?("aug") then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(8)
			@bs[nowpc.get]=5
			setno5 = true
		end
		
		#-5������ꍇ
		if (chord.include?("-5") || chord.include?("alt")) then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(6)
			@bs[nowpc.get]=5
			setno5 = true
		end
		
		#sus4������ꍇ
		if chord.include?("sus4") then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(5)
			@bs[nowpc.get]=4
			setno3 = true
		end
		
		#7th������ꍇ
		if chord.include?("7") then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(10)
			@bs[nowpc.get]=3
		end
		
		#maj7th������ꍇ
		if chord.include?("maj7") then
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(11)
			@bs[nowpc.get]=3
		end


		
		#��3�����Z�b�g����Ă��邩�ǂ����m�F
		if setno3 == false then
			#�Z�b�g����Ă��Ȃ���ΕW���̒l�i���[�g���璷3�x�j���Z�b�g
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(4)
			@bs[nowpc.get]=4
			setno3 = true
		end
		
		#��5�����Z�b�g����Ă��邩�ǂ����m�F
		if setno5 == false then
			#�Z�b�g����Ă��Ȃ���ΕW���̒l�i���[�g���犮�S5�x�j���Z�b�g
			nowpc=Modint.new(rootpc.get,12)
			nowpc.add(7)
			@bs[nowpc.get]=5
			setno5 = true
		end

	end
	
	#basicspace��Ԃ�
	def get_bs()
		return @bs
	end

	# p method �Ή�
	def inspect()
		print "\tfedcba\n--------------\n"
		12.times do |i|
		buf = Pitchclass.new(i)
		print buf.getname,"\t"
		@bs[i].times do |j|
			print "*"
		end
		print "\n"
		end
	return nil
	end


	
end


