transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Kyle/Desktop/FPGAP3 {C:/Users/Kyle/Desktop/FPGAP3/ram.v}
vlog -vlog01compat -work work +incdir+C:/Users/Kyle/Desktop/FPGAP3 {C:/Users/Kyle/Desktop/FPGAP3/lab3.v}

