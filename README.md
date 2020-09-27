# TPS-ExJ

Library of TPS-ExJ (Tonal Pitch Space - EXtended for Jazz). 
#Preface : �͂��߂�
This libraly (TPS-EXJ : Tonal Pitch Space - EXtended for Jazz) is deliverable on Naohiko Yamaguchi's master thesis, Improving TPS to Tackle Non Key Constituent Note.
This works tried extend TPS, computational music theory by Fread Lerdahl, for jazz music theory.

���̃��C�u����(Tonal Pitch Space EXtended for Jazz)�́A�R�����F�̏C�m����
�u�񒲍\�������܂ޘa���ւ̑Ή���ړI�Ƃ���Tonal Pitch Space�̊g���v
�̐��ʕ��ł��B
Fred Lerdahl�ɂ���Ē񏥂��ꂽ�v�Z�_�I���y���_TPS(Tonal Pitch Space)���A
��蕡�G�Șa����������悤�Ɋg�������邱�Ƃ����݂܂����B
�Z�p�I�ȏڍׂ͎Q�l���������Q�Ƃ��������B

# Requirements : �����

This library run with Ruby 1.9 on (Japanese) windows.
Perhaps, it can run on UNIX or MacOS if you convert appropriate character set.

���s�ɂ�Ruby��������K�v�ł��B
Windows��ɃC���X�g�[������Ruby 1.9�Ő��삵�A������m�F���Ă��܂��B
����OS�⑼�̃��C�u�����Ɉˑ�����悤�ȕ����͂���܂���̂ŁAUNIX��MacOS��ł��A
�\�[�X�t�@�C���̕����R�[�h��ϊ�����Γ��삷��Ǝv���܂����A���m�F�ł��B

# License : ���C�Z���X

This libraly release by New BSD License.

�{���C�u�����͏C��BSD���C�Z���X�iNew BSD License�j���̗p���Ă��܂��B
�{���C�u�����𗘗p���ꂽ�ꍇ�ɂ́A�g�p���ꂽ�|����҂܂ł��A������������΍K���ł��B
�i�����܂ł��肢�ł���A�����ł͂���܂���j
�܂��A���C�u�������̂��̂̉��������}�������܂��B

# How to Use : �g����

If you would like to try this libraly, Run Music/Music.rb at first.

On line 458, explain method get code name list of head of "Fly me to the moon".
Explain method calculate distance between adjacent chord. And return appropriate interpretation.

You can read document made by RDoc in doc/index.html.

�Ƃ肠�����A�{���C�u�����𓮂����Ă݂������́ARuby���s����Music�f�B���N�g��
�ɂ���Music.rb�����s���Ă݂ĉ������B

���t�@�C������(458�s�ځj�ł�"Fly me to the moon"�`�������̃R�[�h�i�s��explain���\�b�h��
�󂯎���Ă��܂��B
�@#"Fly me to the moon"�`�������̃R�[�h�i�s��explain���\�b�h�ɗ^������
�@test_music.explain("A m 7,D m 7,G 7,C maj7, F maj7,B m 7 -5,E 7,A m �c

explain���\�b�h�́A�^����ꂽ�R�[�h�l�[���񂩂�A�ׂ荇���R�[�h���m�̘a���ԋ�����
�Z�o���A�ł��Ó����̂���a�����߂��v�Z���ĕԂ��܂��B

RDoc��p���Đ��������h�L�������g��doc�f�B���N�g������index.htm����{���ł��܂��B
�e�N���X�̃��\�b�h��v���p�e�B�ɂ��Ă͂���������Q�Ƃ��������B

