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
ECHO             /                          (this is the logo)                           \
echo             \_______________________________________________________________________/
::logo
ECHO.
ECHO.
ECHO.
echo.
::ask
echo                         "<*>" (any key) to start the game
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
ECHO             /                          (this is the logo)                           \
echo             \_______________________________________________________________________/
::logo
ECHO.
ECHO.
ECHO 1 to open backpack, 2 to walk, 5 to buy, \/\/ E to save and exit, S to save the game,
echo d to go inside of the house
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
echo In backpack you have:%backpack%
echo you have %money% ($) dollars
echo                         "<*>" (any key) to continue...
echo.
pause > nul
call :choice


:save_found
cls
set /P back=do you want to load your save game? "<(Y)>,<(N(>":
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
echo you found %money_get% dollars!!
set /A money=%money%+%money_get%
echo you have %money% ($) dollars!!
echo                         "<*>" (any key) to continue...
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
echo you found paper!!
set /P sell=do you want to sell it? "<(Y)>,<(N(>":
if "%sell%" == "Y" (
   set /A money=%money% +2
   goto :choice
)
if "%sell%" == "y" (
   set /A money=%money% +2
   goto :choice
)
if "%sell%" == "n" (set backpack=%backpack%, paper)
if "%sell%" == "N" (set backpack=%backpack%, paper) else goto :found_paper
echo                         "<*>" (any key) to continue...
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
echo you have %money% ($) dollars
echo.
echo.
echo      2 $ to buy paper, 100 $ to buy medium pc, 250 $ to buy fast pc,
echo      500 $ to buy gaimng pc (best deal), 1250 $ to buy a house,
echo      (to buy something type the COST (2 to buy paper...).)
:buy_ask
SET /P buy=        what do you want to buy?  
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
   echo you dont have the money to buy it
   pause > nul
   goto :choice

)
set backpack=%backpack%, paper

:medium_pc
if %money% lss 100 (
   echo you dont have the money to buy it
   pause > nul
   goto :choice

)
set /A money=%money%-100
set backpack=%backpack%, medium pc
goto :choice

:new_pc
if %money% lss 250 (
   echo you dont have the money to buy it
   pause > nul
   goto :choice

)
set /A money=%money%-250
set backpack=%backpack%, fast pc
goto :choice

:gaming_pc
if %money% lss 500 (
   echo you dont have the money to buy it
   pause > nul
   goto :choice

)
if "%house%" == "0" (
   echo you dont have a house
   pause > nul
   goto :choice

)
set /A money=%money%-500
set in_house=%in_house%, gaming pc
set gaming=1
goto :choice

:house
if %money% lss 1250 (
   echo you dont have the money to buy it
   pause > nul
   goto :choice

)
if "%house%" == "1" (
   echo you have already a house
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
   echo you dont have a house
   pause > nul
   goto :choice

)
echo you have %money% ($) dollars
echo in house you have:%in_house%
echo what do you want to use?
echo ("gaming pc" to make videos/stream (makes more money)...)
echo (to exit from the house type "EXIT"...)
echo ("1" is to use "gaming pc"...)
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