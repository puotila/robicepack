icedrv_system.o icedrv_system.d : icedrv_system.F90
icedrv_system.o : icedrv_kinds.o
icedrv_system.o : icedrv_constants.o
icedrv_system.o : icedrv_state.o
icedrv_system.o : icepack_intfc.o
