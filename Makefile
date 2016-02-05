# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: Masterarbeit.pdf all clean

# The first rule in a Makefile is the one executed by default ("make"). It
# should always be the "all" rule, so that "make" and "make all" are identical.
all: Masterarbeit.pdf

# CUSTOM BUILD RULES

# In case you didn't know, '$@' is a variable holding the name of the target,
# and '$<' is a variable holding the (first) dependency of a rule.
# "raw2tex" and "dat2tex" are just placeholders for whatever custom steps
# you might have.

data/%.dat: octave/upwind.m \
	        octave/transport_example.m \
            octave/create_example_plots.m \
	        octave/create_error_plots.m
		octave --silent --path octave octave/create_example_plots.m
		octave --silent --path octave octave/create_error_plots.m

transportgleichung.tex: data/V_sinus_eta_0.100_h_0.010.dat \
	                    data/V_sinus_eta_0.100_h_0.001.dat \
	                    data/V_sinus_eta_0.050_h_0.001.dat \
	                    data/V_sinus_eta_0.010_h_0.001.dat

main.tex: transportgleichung.tex \
	      transportgleichung_appendix.tex \
	      vorwort.tex \
	      variable_advektion.tex \
	      burgers.tex \
	      Macros.tex

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

Masterarbeit.pdf: main.tex
		latexmk -pdf -pdflatex="pdflatex -shell-escape -interaction=nonstopmode" -use-make main.tex

clean:
		latexmk -CA
		rm -f main.run.xml
		rm -f main.bbl
		rm -f data/*.dat
		rm -f figures/*
		rm -f main.auxlock
		rm -f main.maf 
		rm -f main.mtc* 
