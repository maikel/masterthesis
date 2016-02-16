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

octave/create_%.m: octave/upwind.m \
				   octave/transport_example.m

data/max_errors_eta_%.dat: octave/create_error_plots.m
		octave --silent --path octave octave/create_error_plots.m

data/max_errors_small_eta_0.001.dat: octave/create_error_plots_small_eta.m
		octave --silent --path octave octave/create_error_plots_small_eta.m


data/V_sinus_eta_%.dat: octave/create_example_plots.m
		octave --silent --path octave octave/create_example_plots.m


data: data/V_sinus_eta_0.100_h_0.010.dat \
	  data/V_sinus_eta_0.100_h_0.001.dat \
	  data/V_sinus_eta_0.050_h_0.001.dat \
      data/max_errors_eta_0.100_h_0.001.dat \
      data/max_errors_eta_0.050_h_0.001.dat \
      data/max_errors_eta_0.010_h_0.001.dat \
      data/max_errors_small_eta_0.001.dat

2.transportgleichung.tex: data

thesis.tex: 2.transportgleichung.tex \
	      A.transportgleichung_appendix.tex \
	      1.vorwort.tex \
	      3.variable_advektion.tex \
	      macros.tex \
	      titlepage.pdf

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

titlepage.pdf: titlepage.tex
		latexmk -pdf -pdflatex="pdflatex -shell-escape -interaction=nonstopmode" -use-make titlepage.tex

Masterarbeit.pdf: thesis.tex
		latexmk -pdf -pdflatex="pdflatex -shell-escape -interaction=nonstopmode" -use-make thesis.tex

clean:
		latexmk -CA
		rm -f thesis.run.xml
		rm -f thesis.bbl
		rm -f data/*.dat
		rm -f figures/*
		rm -f thesis.auxlock
		rm -f thesis.maf 
		rm -f thesis.mtc* 
