set title "advecton velocity"
# set grid

set term pngcairo

set title "solution of the variable advection for various steps"

do for [i=2:1000] {
    set output 'output/solution_'.i.'.png'
    plot [-1.5:1.5] [-0.2:1.5] \
        "output/a.dat" title 'velocity' with lines, \
        "output/u.dat" using 1:i title 'solution step n='.i with lines
}

