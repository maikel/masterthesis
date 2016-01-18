set title "advecton velocity"
# set grid

set term pngcairo

set title "solution of the variable advection for various steps"

do for [i=2:1000] {
    set output 'output/step_hat/'.i.'.png'
    plot [-2:2] [-0.2:1.5] \
        "output/a_step_hat.dat" title 'velocity' with lines, \
        "output/u_step_hat.dat" using 1:i title 'solution step n='.i with lines
}

