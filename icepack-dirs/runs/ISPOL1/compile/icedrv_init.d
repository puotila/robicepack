icedrv_init.o icedrv_init.d : icedrv_init.F90
icedrv_init.o : icedrv_kinds.o
icedrv_init.o : icedrv_constants.o
icedrv_init.o : icedrv_domain_size.o
icedrv_init.o : icepack_intfc.o
icedrv_init.o : icedrv_system.o
icedrv_init.o : icedrv_diagnostics.o
icedrv_init.o : icedrv_calendar.o
icedrv_init.o : icedrv_history.o
icedrv_init.o : icedrv_restart_shared.o
icedrv_init.o : icedrv_flux.o
icedrv_init.o : icedrv_forcing.o
icedrv_init.o : icedrv_state.o
icedrv_init.o : icedrv_arrays_column.o
