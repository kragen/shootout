#implicitode: implicitode.f90 fdata.f90 autoDiff.f90 implicitode_trad
#	-g95 -o $@ -g fdata.f90 $<
#	-ifort -o $@ -g -static-libcxa fdata.f90 autoDiff.f90 $<

implicitode_trad: implicitode_trad.f90 fdata.f90
	-g95 -o $@ -g fdata.f90 $<
	-ifort -o $@ -g -static-libcxa fdata.f90 $<
