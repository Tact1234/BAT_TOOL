@ECHO OFF
REM �ϐ��錾
SET _INPUT_USR_STR=
SET _FLG_EXCEPTION_INPUT= REM ��O���̓t���O�i1:��O�j
SET _FILE_OUTPUT=
SET _PATH_CURRENT=%~dp0
SET _RC=

ECHO ---------------------------------------------------------
ECHO -               �t�@�C���ꗗ�o�̓X�N���v�g              -
ECHO ---------------------------------------------------------
setlocal ENABLEDELAYEDEXPANSION

REM --------------
REM �又��
REM --------------
REM ���[�U�[���͑ҋ@
:RESTART
SET /P _INPUT_USR_STR="�o�͌`����I��ł��������B�il:���X�g�^t:�c���[�j> "
SET _FLG_EXCEPTION_INPUT=1

REM ���X�g�o��
IF /i %_INPUT_USR_STR% EQU l (
	SET _FLG_EXCEPTION_INPUT=0
	SET _FILE_OUTPUT=%_PATH_CURRENT%list.txt
	DIR /S /B > !_FILE_OUTPUT!
	SET _RC=%ERRORLEVEL%
)

REM �c���[�o��
IF /i %_INPUT_USR_STR% EQU t (
	SET _FLG_EXCEPTION_INPUT=0
	SET _FILE_OUTPUT=%_PATH_CURRENT%tree.txt
	TREE /f > !_FILE_OUTPUT!
	SET _RC=%ERRORLEVEL%
)

REM ���ʏo��
CALL :OUTPUT_RESULT

REM �Ď��{�m�F
ECHO;
SET /P _FLG_RESTART="�ēx���{���܂����H�iy:�͂��^n:�������j"
ECHO;
IF /i %_FLG_RESTART% EQU y (
	ECHO ---------------------------------------------------------
	GOTO :RESTART
)

REM --------------
REM �I������
REM --------------
ENDLOCAL
ECHO �I�����܂��B

PAUSE;
EXIT /B

REM --------------
REM ���ʏo��
REM --------------
:OUTPUT_RESULT
	IF %_FLG_EXCEPTION_INPUT% NEQ 0 (
		ECHO;
		ECHO ���͌`���Ɍ�肪����܂��Bl��t����͂��Ă��������B
		EXIT /B
	)

	IF %_RC% EQU 0 (
		ECHO %_FILE_OUTPUT% �ɏo�͂��܂����B
	) ELSE (
		ECHO �o�͂Ɏ��s���܂����B
	)
EXIT /B

