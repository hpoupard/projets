@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 69b66e703698423b81087fd93adc45ee -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot cfg_tb_synthese_totale_behav xil_defaultlib.cfg_tb_synthese_totale -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
