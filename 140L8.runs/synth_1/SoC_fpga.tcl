# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Hun/140L8/140L8.cache/wt [current_project]
set_property parent.project_path C:/Users/Hun/140L8/140L8.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/Hun/140L8/140L8.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/BUF.v
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/CMP.v
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/CNT.v
  C:/Users/Hun/140L8/140L8.srcs/sources_1/new/FMUX2.v
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/MUL.v
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/REG.v
  C:/Users/Hun/140L8/140L8.srcs/sources_1/new/SR_FF.v
  C:/Users/Hun/140L8/140L8.srcs/sources_1/new/SoC.v
  C:/Users/Hun/140L8/140L8.srcs/sources_1/new/SoC_ad.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/adder.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/alu.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/auxdec.v
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/bcd_to_7seg.v
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/button_debouncer.v
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/clk_gen.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/controlunit.v
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/cu.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/datapath.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/dmem.v
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/dp.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/dreg.v
  C:/Users/Hun/140L8/140L8.srcs/sources_1/new/fact_ad.v
  C:/Users/Hun/140L8/140L8.srcs/sources_1/new/fact_top.v
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/factorial.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/gpio_ad.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/gpio_top.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/imem.v
  C:/Users/Hun/factorial/factorial.srcs/sources_1/new/led_mux.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/maindec.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/mips.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/multiplier.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/mux2.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/mux4.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/regfile.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/signext.v
  C:/Users/Hun/L5MIPS/L5MIPS.srcs/sources_1/new/wedreg.v
  C:/Users/Hun/140L8/140L8.srcs/sources_1/new/SoC_FPGA.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Hun/140L8/140L8.srcs/constrs_1/new/SoC_FPGA.xdc
set_property used_in_implementation false [get_files C:/Users/Hun/140L8/140L8.srcs/constrs_1/new/SoC_FPGA.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top SoC_fpga -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef SoC_fpga.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file SoC_fpga_utilization_synth.rpt -pb SoC_fpga_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]