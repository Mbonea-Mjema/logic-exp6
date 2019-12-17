onerror {quit -f}
vlib work
vlog -work work Exp6.vo
vlog -work work Exp6.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Vend_FSM_vlg_vec_tst
vcd file -direction Exp6.msim.vcd
vcd add -internal Vend_FSM_vlg_vec_tst/*
vcd add -internal Vend_FSM_vlg_vec_tst/i1/*
add wave /*
run -all
