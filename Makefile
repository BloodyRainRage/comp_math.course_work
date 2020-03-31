FC=gfortran
FFLAGS=-Wall -fimplicit-none -Wno-maybe-uninitialized 
FOPT=-O3 
DIR=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
all: clean build run

clean:
		rm -rf obj/*
		rm -rf bin/*

build:
build:
	@mkdir -p obj
	@mkdir -p bin
	$(FC) $(FFLAGS) -c "$(DIR)/src/environment/environment_x64.f90" -J "$(DIR)/obj/" -o "$(DIR)/obj/environment.o"
	$(FC) $(FFLAGS) -c "$(DIR)/src/_forsythe/src/QUANC8.f90" -I "$(DIR)/obj/" -o "$(DIR)/obj/QUANC8.o"
	$(FC) $(FFLAGS) -c "$(DIR)/src/_forsythe/src/FMIN.f90" -I "$(DIR)/obj/" -o "$(DIR)/obj/FMIN.o"
	$(FC) $(FFLAGS) $(FOPT) -c "$(DIR)/src/main.f90" -I "$(DIR)/obj/" -o "$(DIR)/obj/main.o"
	$(FC) $(FFLAGS) $(FOPT) -o "$(DIR)/bin/app" "$(DIR)/obj/environment.o" "$(DIR)/obj/QUANC8.o" "$(DIR)/obj/FMIN.o" "$(DIR)/obj/main.o"	
run:
		cd ./bin; ./app;
