.PHONY: all
.DEFAULT_GOAL := all

CC = xelatex
CV_DIR = cv
EN_DIR = cv/en
FR_DIR = cv/fr
EN_CV_SRCS = $(shell find $(EN_DIR) -name '*.tex')
FR_CV_SRCS = $(shell find $(FR_DIR) -name '*.tex')

all: $(foreach x, en fr, $x.pdf)

en.pdf: $(CV_DIR)/en.tex $(EN_CV_SRCS)
	$(CC) -output-directory=$(CV_DIR) -interaction=nonstopmode $<

fr.pdf: $(CV_DIR)/fr.tex $(CV_DIR)/fr.tex $(FR_CV_SRCS)
	$(CC) -output-directory=$(CV_DIR) -interaction=nonstopmode $<

clean:
	rm -rf $(CV_DIR)/*.pdf