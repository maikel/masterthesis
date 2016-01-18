set title "advecton velocity"
# set grid

set term pngcairo

set title "solution of the variable advection for various steps"

do for [i=2:300] {
    set output 'output/sin_const/'.i.'.png'
    plot [-2:2] \
        "output/a_sin_const.dat" with line lt 0 title 'velocity', \
        "output/u_sin_const.dat" using 1:i title 'solution step n='.i with line lt -1 lc 3, \
        "output/ref_sin_const.dat" using 1:i title 'reference solution step n='.i with line lt 2 lw 2
}

