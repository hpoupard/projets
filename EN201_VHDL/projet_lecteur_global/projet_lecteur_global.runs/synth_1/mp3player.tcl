# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.cache/wt [current_project]
set_property parent.project_path C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_cache_permissions disable [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/uart_recv.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/stop_counter.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/merger_8b_to_16b.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/ROM_Sinus.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/pwm.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/horloge_44100Hz.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/full_uart_recv.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/cmp_addr.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/transcodeur.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/mux8.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/mod8.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/gestion_freq.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/fsm_mp3.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/detect_impulsion.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/cpt_1_9.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/cpt_1_599.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/synthese_totale.vhd
  C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/sources_1/new/mp3player.vhd
}
read_xdc C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/constrs_1/new/Nexys4_Master.xdc
set_property used_in_implementation false [get_files C:/Users/hpoupard/Desktop/projet_lecteur_global/projet_lecteur_global.srcs/constrs_1/new/Nexys4_Master.xdc]

synth_design -top mp3player -part xc7a100tcsg324-1
write_checkpoint -noxdef mp3player.dcp
catch { report_utilization -file mp3player_utilization_synth.rpt -pb mp3player_utilization_synth.pb }
