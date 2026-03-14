# Week 6 Makefile
CC = gcc
CFLAGS = -Wall -Wextra
PYTHON = python3
RARS = java -jar $(HOME)/week04/rars1_6.jar
WEEK01 = $(HOME)/week01
WEEK05 = $(HOME)/week05

.PHONY: all clean c_tests asm_tests report

all: c_tests asm_tests report
	@echo "================================"
	@echo "  ALL DONE - check report.html"
	@echo "================================"

c_tests:
	@echo "[1/3] Compiling C library..."
	@$(CC) $(CFLAGS) $(WEEK01)/register_ops.c $(WEEK01)/test_register_ops.c \
		-o $(WEEK01)/test_register_ops 2>c_errors.txt && \
		echo "  Compile: PASS" || echo "  Compile: FAIL"
	@echo "[2/3] Running C tests..."
	@$(WEEK01)/test_register_ops > c_output.txt 2>&1 && \
		echo "  C tests: PASS" || echo "  C tests: FAIL"

asm_tests:
	@echo "[3/3] Running assembly tests..."
	@$(PYTHON) $(WEEK05)/verify.py > asm_output.txt 2>&1 && \
		echo "  ASM tests: PASS" || echo "  ASM tests: FAIL"

report: c_tests asm_tests
	@echo "Generating HTML report..."
	@$(PYTHON) generate_report.py
	@echo "  Report saved to report.html"

clean:
	@rm -f $(WEEK01)/test_register_ops
	@rm -f c_output.txt asm_output.txt c_errors.txt report.html
	@echo "Cleaned"