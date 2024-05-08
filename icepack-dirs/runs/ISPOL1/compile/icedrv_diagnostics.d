icedrv_diagnostics.o icedrv_diagnostics.d : icedrv_diagnostics.F90
icedrv_diagnostics.o : icedrv_kinds.o
icedrv_diagnostics.o : icedrv_constants.o
icedrv_diagnostics.o : icedrv_domain_size.o
icedrv_diagnostics.o : icepack_intfc.o
icedrv_diagnostics.o : icedrv_system.o
icedrv_diagnostics.o : icedrv_arrays_column.o
icedrv_diagnostics.o : icedrv_flux.o
icedrv_diagnostics.o : icedrv_state.o
icedrv_diagnostics.o : icedrv_calendar.o
