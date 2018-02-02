restart -f -nowave
add wave b1
add wave b2
add wave dip
add wave clk
add wave address_sig
add wave data_sig
add wave q

force dip 1 0, 0 5000
force b2 1 0, 0 50 -r 100
force b1 1 0, 0 5, 1 10
force clk 1 0, 0 20 -r 40
run 10000