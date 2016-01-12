set title "advecton velocity"
# set grid

set term pngcairo

set title "solution of the variable advection for various steps"

do for [i=2:1000] {
    set output 'output/sin_const/'.i.'.png'
    plot [-2:2] \
        "output/a_sin_const.dat" title 'velocity' with lines, \
        "output/u_sin_const.dat" using 1:i title 'solution step n='.i with lines
}

