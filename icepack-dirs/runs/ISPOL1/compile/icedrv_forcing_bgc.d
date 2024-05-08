icedrv_forcing_bgc.o icedrv_forcing_bgc.d : icedrv_forcing_bgc.F90
icedrv_forcing_bgc.o : icedrv_kinds.o
icedrv_forcing_bgc.o : icedrv_domain_size.o
icedrv_forcing_bgc.o : icedrv_calendar.o
icedrv_forcing_bgc.o : icedrv_constants.o
icedrv_forcing_bgc.o : icepack_intfc.o
icedrv_forcing_bgc.o : icedrv_system.o
icedrv_forcing_bgc.o : icedrv_forcing.o
icedrv_forcing_bgc.o : icedrv_arrays_column.o
icedrv_forcing_bgc.o : icedrv_flux.o
