@ECHO OFF
REM 変数宣言
SET _INPUT_USR_STR=
SET _FLG_EXCEPTION_INPUT= REM 例外入力フラグ（1:例外）
SET _FILE_OUTPUT=
SET _PATH_CURRENT=%~dp0
SET _RC=

ECHO ---------------------------------------------------------
ECHO -               ファイル一覧出力スクリプト              -
ECHO ---------------------------------------------------------
setlocal ENABLEDELAYEDEXPANSION

REM --------------
REM 主処理
REM --------------
REM ユーザー入力待機
:RESTART
SET /P _INPUT_USR_STR="出力形式を選んでください。（l:リスト／t:ツリー）> "
SET _FLG_EXCEPTION_INPUT=1

REM リスト出力
IF /i %_INPUT_USR_STR% EQU l (
	SET _FLG_EXCEPTION_INPUT=0
	SET _FILE_OUTPUT=%_PATH_CURRENT%list.txt
	DIR /S /B > !_FILE_OUTPUT!
	SET _RC=%ERRORLEVEL%
)

REM ツリー出力
IF /i %_INPUT_USR_STR% EQU t (
	SET _FLG_EXCEPTION_INPUT=0
	SET _FILE_OUTPUT=%_PATH_CURRENT%tree.txt
	TREE /f > !_FILE_OUTPUT!
	SET _RC=%ERRORLEVEL%
)

REM 結果出力
CALL :OUTPUT_RESULT

REM 再実施確認
ECHO;
SET /P _FLG_RESTART="再度実施しますか？（y:はい／n:いいえ）"
ECHO;
IF /i %_FLG_RESTART% EQU y (
	ECHO ---------------------------------------------------------
	GOTO :RESTART
)

REM --------------
REM 終了処理
REM --------------
ENDLOCAL
ECHO 終了します。

PAUSE;
EXIT /B

REM --------------
REM 結果出力
REM --------------
:OUTPUT_RESULT
	IF %_FLG_EXCEPTION_INPUT% NEQ 0 (
		ECHO;
		ECHO 入力形式に誤りがあります。lかtを入力してください。
		EXIT /B
	)

	IF %_RC% EQU 0 (
		ECHO %_FILE_OUTPUT% に出力しました。
	) ELSE (
		ECHO 出力に失敗しました。
	)
EXIT /B

