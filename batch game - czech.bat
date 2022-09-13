@echo off 
title batch test 
color 0f
md "%localappdata%\batch_game\"
set save_cd="%localappdata%\batch_game\batch_game.bat"
SET /A money_pc=%RANDOM% * 250 / 32768
cls
::logo
echo             ._______________________________________________________________________.
echo             /                                                                       \
echo             \                                                                       /
echo             /             HHHHH      HHHHH    RRRRRRRRR         AA                  \
ECHO             \             H   H      H   H    R    R  R        AAAA                 /
ECHO             /             H   HHHHHHHH   H    R    R  R       AA  AA                \
ECHO             \             H              H    R    RRRR      AAAAAAAA               /
ECHO             /             H   HHHHHHHH   H    R    RR       AA      AA              \
ECHO             \             H   H      H   H    R    R  R    AA        AA             /
ECHO             /             HHHHH      HHHHH    RRRRRR    R AA          AA            \
ECHO             \                                                                       /
ECHO             /                                                                       \
echo             \_______________________________________________________________________/
::logo
ECHO.
ECHO.
ECHO.
echo.
::ask
echo                         "<*>" (jakoukoliv klavesu) pro start hry
pause > nul
cls
:start_game
if exist %save_cd% (call :save_found)
:dont_load_save
set money=0
set house=0
set backpack=
set server=0
set gaming=0
:choice
cls
::logo
echo             ._______________________________________________________________________.
echo             /                                                                       \
echo             \                                                                       /
echo             /             HHHHH      HHHHH    RRRRRRRRR         AA                  \
ECHO             \             H   H      H   H    R    R  R        AAAA                 /
ECHO             /             H   HHHHHHHH   H    R    R  R       AA  AA                \
ECHO             \             H              H    R    RRRR      AAAAAAAA               /
ECHO             /             H   HHHHHHHH   H    R    RR       AA      AA              \
ECHO             \             H   H      H   H    R    R  R    AA        AA             /
ECHO             /             HHHHH      HHHHH    RRRRRR    R AA          AA            \
ECHO             \                                                                       /
ECHO             /                                                                       \
echo             \_______________________________________________________________________/
::logo
ECHO.
ECHO.
ECHO 1 pro otevreni batohu, 2 pro chozeni, 5 pro koupeni, \/\/ E pro ulozeni hry a zavzeni hry, S pro ulozeni hry,
echo d pro chozeni do dumu
choice /N /C "125ESD"
if "%errorlevel%" == "1" (call :backpack)
if "%errorlevel%" == "2" (call :walk)
if "%errorlevel%" == "4" (call :exit)
if "%errorlevel%" == "5" (call :save)
if "%errorlevel%" == "3" (call :buy)
if "%errorlevel%" == "6" (call :in_house)
goto :choice

:walk
SET /A money_get=%RANDOM% * 100 / 32768
SET /A rand=%RANDOM% * 10 / 32768
if "%rand%" == "5" (call :money_got)
if "%rand%" == "3" (call :found_paper)
call :choice

:backpack
echo V batohu mate:%backpack%
echo Mate %money% ($) dolaru
echo                         "<*>" (jakoukoliv klavesu) pro pokracovani...
echo.
pause > nul
call :choice


:save_found
cls
set /P back=chcete nacist posledni ulozenou pouici? "<(Y)>,<(N(>":
if "%back%" == "Y" (
   call %save_cd%
   goto :choice
)
if "%back%" == "y" (
   call %save_cd%
   goto :choice
)
if "%back%" == "n" (goto :dont_load_save)
if "%back%" == "N" (goto :dont_load_save) else goto :save_found
call :choice

:money_got
echo nasli jste %money_get% dolaru!!
set /A money=%money%+%money_get%
echo mate %money% ($) dolaru!!
echo                         "<*>" (jakoukoliv klavesu) pro pokracovani...
echo.
pause > nul
call :choice


:exit
echo @set backpack=%backpack%> %save_cd%
echo @set money=%money%>> %save_cd%
echo @set house=%house%>> %save_cd%
echo @set in_house=%in_house%>> %save_cd%
echo @set server=%server%>> %save_cd%
echo @set gaming=%gaming%>> %save_cd%
exit

:found_paper
cls
echo nasli jste papir!!
set /P sell=chcete prodat papir? "<(Y)>,<(N(>":
if "%sell%" == "Y" (
   set /A money=%money% +2
   goto :choice
)
if "%sell%" == "y" (
   set /A money=%money% +2
   goto :choice
)
if "%sell%" == "n" (set backpack=%backpack%, papir)
if "%sell%" == "N" (set backpack=%backpack%, papir) else goto :found_paper
echo                         "<*>" (jakoukoliv klavesu) pro pokracovani...
echo.
pause > nul
call :choice

:save
echo @set backpack=%backpack%> %save_cd%
echo @set money=%money%>> %save_cd%
echo @set house=%house%>> %save_cd%
echo @set in_house=%in_house%>> %save_cd%
echo @set server=%server%>> %save_cd%
echo @set gaming=%gaming%>> %save_cd%
goto :choice

:: -- buy something

:buy
echo mate %money% ($) dolaru
echo.
echo.
echo      2 $ pro koupeni papiru, 100 $ pro koupeni zakladniho pocitace, 250 $ pro koupeni noveho pocitace,
echo      500 $ pro koupeni herniho pocitace, 1250 $ pro koupeni dumu,
echo      (pro koupeni neceho napiste kolit to stoji (napsat 2 pro koupeni papiru...).)
:buy_ask
SET /P buy=        co chcte koupit:  
set sell=N
if "%buy%" == "2" (
   IF %money% lss 2 goto :choice
   set /A money=%money%-2
   goto :get_paper
)
if "%buy%" == "100" (
   goto :medium_pc
)
if "%buy%" == "250" (
   goto :new_pc
)
if "%buy%" == "500" (
   goto :gaming_pc
)
if "%buy%" == "1250" (
   goto :house
)
pause > nul
goto :choice

:get_paper
if %money% lss 2 (
   echo nemate dost penez
   pause > nul
   goto :choice

)
set backpack=%backpack%, papir

:medium_pc
if %money% lss 100 (
   echo nemate dost penez
   pause > nul
   goto :choice

)
set /A money=%money%-100
set backpack=%backpack%, zakladni pocitac
goto :choice

:new_pc
if %money% lss 250 (
   echo nemate dost penez
   pause > nul
   goto :choice

)
set /A money=%money%-250
set backpack=%backpack%, novy pocitac
goto :choice

:gaming_pc
if %money% lss 500 (
   echo nemate dost penez
   pause > nul
   goto :choice

)
if "%house%" == "0" (
   echo nemate dum
   pause > nul
   goto :choice

)
set /A money=%money%-500
set in_house=in_house, herni pocitac
set gaming=1
goto :choice

:house
if %money% lss 1250 (
   echo nemate dost penez
   pause > nul
   goto :choice

)
if "%house%" == "1" (
   echo mate uz dum
   pause > nul
   goto :choice

)
set house=1
set /A money=%money%-1250
goto :choice
:: -- buy something

:: -- house

:in_house
if "%house%" == "0" (
   echo nemate dum
   pause > nul
   goto :choice

)
echo mate %money% ($) dolaru
echo v dumu mate:%in_house%
echo co chcete pouzit?
echo (napiste plni nazen toho ceho chcete pouzit...)
echo ("herni pocitac" pro streamovani...)
echo (pro to aby jste vysli s dumu napiste "EXIT"...)
echo ("1" je k pouziti "herniho pocitace"...)
set /P in_house_use=
if "%gaming%" == "1" (
   if "%in_house_use%" == "1" (
      SET /A money_pc=%RANDOM% * 250 / 32768
      set /A money=%money% + %money_pc%
      pause > nul
      goto :in_house
    )
)
if "%in_house_use%" == "EXIT" goto :choice
goto :in_house

:: -- house