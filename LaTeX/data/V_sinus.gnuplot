set title "advecton velocity"
# set grid

set term pngcairo

set title "solution of the variable advection for various steps"

do for [i=2:300] {
    set output 'V_sinus.'.i.'.png'
    plot [-2:2] "V_sinus_eps_0.1_h_0.01.dat" using 1:i title 'solution step n='.i with line lt -1
}

