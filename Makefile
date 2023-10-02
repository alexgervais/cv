.PHONY: all
.DEFAULT_GOAL := all
PODMAN_GOAL ?= all

CC = xelatex
WORK_DIR = cv
WORK_DIR_EN = cv/en
WORK_DIR_FR = cv/fr
OUT_DIR = out
EN_SRCS = $(shell find $(WORK_DIR_EN) -name '*.tex')
FR_SRCS = $(shell find $(WORK_DIR_FR) -name '*.tex')

all: $(foreach x, en fr, $x.pdf)

en.pdf: $(WORK_DIR)/en.tex $(EN_SRCS)
	$(CC) -output-directory=$(WORK_DIR) -interaction=nonstopmode $<
	mkdir -p $(OUT_DIR) && cp $(WORK_DIR)/en.pdf $(OUT_DIR)

fr.pdf: $(WORK_DIR)/fr.tex $(FR_SRCS)
	$(CC) -output-directory=$(WORK_DIR) -interaction=nonstopmode $<
	mkdir -p $(OUT_DIR) && cp $(WORK_DIR)/fr.pdf $(OUT_DIR)

clean:
	rm -rf $(WORK_DIR)/*.{ps,pdf,log,aux,out,dvi,bbl,blg,snm,toc,nav}

_podman:
	podman build . -t agervais/xelatex:latest
	podman run --rm -v $(shell pwd):/data agervais/xelatex:latest make $(PODMAN_GOAL) && make clean

podman: clean _podman
