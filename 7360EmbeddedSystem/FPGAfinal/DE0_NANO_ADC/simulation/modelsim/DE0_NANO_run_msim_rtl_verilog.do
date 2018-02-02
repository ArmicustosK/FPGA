transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Kyle/Desktop/FPGAfinal/DE0_NANO_ADC {C:/Users/Kyle/Desktop/FPGAfinal/DE0_NANO_ADC/SPIPLL.v}
vlog -vlog01compat -work work +incdir+C:/Users/Kyle/Desktop/FPGAfinal/DE0_NANO_ADC {C:/Users/Kyle/Desktop/FPGAfinal/DE0_NANO_ADC/DE0_NANO.v}
vlog -vlog01compat -work work +incdir+C:/Users/Kyle/Desktop/FPGAfinal/DE0_NANO_ADC {C:/Users/Kyle/Desktop/FPGAfinal/DE0_NANO_ADC/ADC_CTRL.v}
vlog -vlog01compat -work work +incdir+C:/Users/Kyle/Desktop/FPGAfinal/DE0_NANO_ADC {C:/Users/Kyle/Desktop/FPGAfinal/DE0_NANO_ADC/ram.v}
vlog -vlog01compat -work work +incdir+C:/Users/Kyle/Desktop/FPGAfinal/DE0_NANO_ADC/db {C:/Users/Kyle/Desktop/FPGAfinal/DE0_NANO_ADC/db/spipll_altpll.v}

