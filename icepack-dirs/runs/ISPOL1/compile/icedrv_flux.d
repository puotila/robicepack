icedrv_flux.o icedrv_flux.d : icedrv_flux.F90
icedrv_flux.o : icedrv_kinds.o
icedrv_flux.o : icedrv_domain_size.o
icedrv_flux.o : icedrv_constants.o
icedrv_flux.o : icepack_intfc.o
icedrv_flux.o : icedrv_system.o
icedrv_flux.o : icedrv_arrays_column.o
icedrv_flux.o : icedrv_state.o
