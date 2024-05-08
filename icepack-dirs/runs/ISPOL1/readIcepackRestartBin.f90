program main
   
      character (len=3) :: nchar
      character (len=255) :: filein, fileout
      integer, parameter :: nu_restart = 12, &
         nx = 4, ncat = 5, nilyr = 7, nslyr = 1, &
         nu_diag = 6, nu_dump = 13
      integer(kind=4) :: istep0, k 
      real(kind=8)    :: time, time_forc

      real (kind=8), allocatable, dimension(:,:) :: &
         aicen, vicen, vsnon, Tsfc, &
         scale_factor, swvdr, swvdf, swidr, swidf, &
         sst, frzmlt, alvl, vlvl, fsnow, &               
         apnd, hpnd, ipnd, dhsn, ffracn

      real (kind=8), allocatable, dimension(:,:,:) :: &
         sice, qice, qsno

      allocate(aicen(nx,ncat),vicen(nx,ncat),vsnon(nx,ncat),Tsfc(nx,ncat))
      allocate(sice(nx,nilyr,ncat),qice(nx,nilyr,ncat),qsno(nx,nilyr,ncat))
      allocate(scale_factor(nx,1),swvdr(nx,1),swvdf(nx,1),swidr(nx,1),swidf(nx,1))
      allocate(sst(nx,1),frzmlt(nx,1),alvl(nx,ncat),vlvl(nx,ncat),fsnow(nx,1))
      allocate(apnd(nx,ncat),hpnd(nx,ncat),ipnd(nx,ncat),dhsn(nx,ncat),ffracn(nx,ncat))

      filein = './restart/iced.2005-01-01-00000'
      fileout = './restart/iceadj.2005-01-01-00000'
      write(nu_diag,*) 'Using restart dump=', trim(filein)

      open(nu_restart,file=filein,form='unformatted')
      read (nu_restart) istep0,time,time_forc
      write(nu_diag,*) 'Restart read at istep=',istep0,time,time_forc
      
      write(nu_diag,*) 'min/max/sum aicen'
      call read_restart_field(nu_restart,aicen,nx,ncat,'aicen')

      write(nu_diag,*) 'min/max/sum vicen'
      call read_restart_field(nu_restart,vicen,nx,ncat,'vicen')

      write(nu_diag,*) 'min/max/sum vsnon'
      call read_restart_field(nu_restart,vsnon,nx,ncat,'vsnon')

      write(nu_diag,*) 'min/max/sum Tsfc'
      call read_restart_field(nu_restart,Tsfc,nx,ncat,'Tsfcn')

      write(nu_diag,*) 'min/max/sum sice for each layer'
      do k=1,nilyr
         write(nchar,'(i3.3)') k
         call read_restart_field(nu_restart,sice(:,k,:),nx,ncat, &
         'sice'//trim(nchar))
      enddo

      write(nu_diag,*) 'min/max/sum qice for each layer'
      do k=1,nilyr
         write(nchar,'(i3.3)') k
         call read_restart_field(nu_restart,qice(:,k,:),nx,ncat, &
         'qice'//trim(nchar))
      enddo

      write(nu_diag,*) 'min/max/sum qsno for each layer'
      do k=1,nslyr
         write(nchar,'(i3.3)') k
         call read_restart_field(nu_restart,qsno(:,k,:),nx,ncat, &
         'qsno'//trim(nchar))
      enddo

      !-----------------------------------------------------------------
      ! radiation fields
      !-----------------------------------------------------------------

      write(nu_diag,*) 'min/max/sum radiation fields'

      call read_restart_field(nu_restart,scale_factor,nx,1,'scale_factor')
      call read_restart_field(nu_restart,swvdr,nx,1,'swvdr')
      call read_restart_field(nu_restart,swvdf,nx,1,'swvdf')
      call read_restart_field(nu_restart,swidr,nx,1,'swidr')
      call read_restart_field(nu_restart,swidf,nx,1,'swidf')

      !-----------------------------------------------------------------
      ! for mixed layer model
      !-----------------------------------------------------------------
      write(nu_diag,*) 'min/max/sum sst, frzmlt'
      call read_restart_field(nu_restart,sst,nx,1,'sst')
      call read_restart_field(nu_restart,frzmlt,nx,1,'frzmlt')

      write(nu_diag,*) 'min/max/sum level ice area, volume'
      call read_restart_field(nu_restart,alvl,nx,ncat,'alvl')
      call read_restart_field(nu_restart,vlvl,nx,ncat,'vlvl')

      write(nu_diag,*) 'min/max/sum level-ice ponds'

      call read_restart_field(nu_restart,apnd,nx,ncat,'apnd')
      call read_restart_field(nu_restart,hpnd,nx,ncat,'hpnd')
      call read_restart_field(nu_restart,ipnd,nx,ncat,'ipnd')
      call read_restart_field(nu_restart,fsnow,nx,1,'fsnow')
      call read_restart_field(nu_restart,dhsn,nx,ncat,'dhsn')
      call read_restart_field(nu_restart,ffracn,nx,ncat,'ffracn')

      close(nu_restart)
       
      ! reading ends
      ! do something for data
      ! change the initial ice thickness (or rather volume) to the recommended value 
      ! which matches with category 2
      vicen(:,:) = 0.0
      vicen(:,2) = 0.7
      ! change aice of category 2 to one, so that grid cells are entirely ice covered at start
      aicen(:,:) = 0.0
      aicen(:,2) = 1.0
      ! change snow thickness of category 2 to the recommende value
      vsnon(:,:) = 0.0
      vsnon(:,2) = 0.1

      ! writing starts
      open(nu_dump,file=fileout,form='unformatted')
      write(nu_diag,*) 'Restart written at istep=',istep0,time,time_forc
      write(nu_dump) istep1,time,time_forc

      write(nu_diag,*) 'min/max/sum aicen'
      call write_restart_field(nu_dump,aicen(:,:),nx,ncat,'aicen')
      write(nu_diag,*) 'min/max/sum vicen'
      call write_restart_field(nu_dump,vicen(:,:),nx,ncat,'vicen')
      write(nu_diag,*) 'min/max/sum vsnon'
      call write_restart_field(nu_dump,vsnon(:,:),nx,ncat,'vsnon')
      write(nu_diag,*) 'min/max/sum Tsfc'
      call write_restart_field(nu_dump,Tsfc(:,:),nx,ncat,'Tsfc')

      write(nu_diag,*) 'min/max/sum sice for each layer'
      do k=1,nilyr
         write(nchar,'(i3.3)') k
         call write_restart_field(nu_dump,sice(:,k,:),nx,ncat, &
         'sice'//trim(nchar))
      enddo

      write(nu_diag,*) 'min/max/sum qice for each layer'
      do k=1,nilyr
         write(nchar,'(i3.3)') k
         call write_restart_field(nu_dump,qice(:,k,:),nx,ncat, &
         'qice'//trim(nchar))
      enddo

      write(nu_diag,*) 'min/max/sum qsno for each layer'
      do k=1,nslyr
         write(nchar,'(i3.3)') k
         call write_restart_field(nu_dump,qsno(:,k,:),nx,ncat, &
         'qsno'//trim(nchar))
      enddo

      write(nu_diag,*) 'min/max/sum radiation fields'
      call write_restart_field(nu_dump,scale_factor,nx,1,'scale_factor')
      call write_restart_field(nu_dump,swvdr,nx,1,'swvdr')
      call write_restart_field(nu_dump,swvdf,nx,1,'swvdf')
      call write_restart_field(nu_dump,swidr,nx,1,'swidr')
      call write_restart_field(nu_dump,swidf,nx,1,'swidf')

      !-----------------------------------------------------------------
      ! for mixed layer model
      !-----------------------------------------------------------------
      write(nu_diag,*) 'min/max/sum sst, frzmlt'
      call write_restart_field(nu_dump,sst,nx,1,'sst')
      call write_restart_field(nu_dump,frzmlt,nx,1,'frzmlt')

      write(nu_diag,*) 'min/max/sum level ice area, volume'
      call write_restart_field(nu_dump,alvl,nx,ncat,'alvl')
      call write_restart_field(nu_dump,vlvl,nx,ncat,'vlvl')

      write(nu_diag,*) 'min/max/sum level-ice ponds'
      call write_restart_field(nu_dump,apnd,nx,ncat,'apnd')
      call write_restart_field(nu_dump,hpnd,nx,ncat,'hpnd')
      call write_restart_field(nu_dump,ipnd,nx,ncat,'ipnd')
      call write_restart_field(nu_dump,fsnow,nx,1,'fsnow')
      call write_restart_field(nu_dump,dhsn,nx,ncat,'dhsn')
      call write_restart_field(nu_dump,ffracn,nx,ncat,'ffracn')

      close(nu_dump)

contains
!=======================================================================

! Reads a single restart field
! author Chris Newman, LANL

subroutine read_restart_field(nu,work,nx,ndim,name)

      integer (kind=4), intent(in) :: &
         nu            , & ! unit number (not used for netcdf)
         nx            , & ! grid size in x
         ndim             ! number of dimensions

      real (kind=8), dimension(:,:), intent(inout) :: &
         work              ! input array (real, 8-byte)

      character (len=*), intent(in), optional :: &
         name

      ! local variables

      integer (kind=4) :: &
         n, i               ! loop indices

      real (kind=8), dimension(nx) :: &
         work2              ! input array (real, 8-byte)

      real (kind=8) :: &
        minw, maxw, sumw    ! diagnostics

      character(len=*), parameter :: subname='(read_restart_field)'

      do n = 1, ndim
          read(nu) (work2(i), i=1,nx)
          work(:,n) = work2(:)
      enddo

      minw = minval(work)
      maxw = maxval(work)
      sumw = sum(work)
      write(nu_diag,*) subname, minw, maxw, sumw

end subroutine read_restart_field

!=======================================================================

! Writes a single restart field.
! author Chris Newman, LANL

      subroutine write_restart_field(nu,work,nx,ndim,vname)

      integer (kind=4), intent(in) :: &
         nu            , & ! unit number
         nx            , & ! grid size in x
         ndim              ! number of dimensions

      real (kind=8), dimension(nx,ndim), intent(in) :: &
         work              ! input array (real, 8-byte)

      character (len=*), intent(in), optional :: &
         vname             ! variable name for netcdf output

      ! local variables

      integer (kind=4) :: &
         n, i              ! loop indices

      real (kind=8), dimension(nx) :: &
         work2             ! input array (real, 8-byte)

      real (kind=8) :: &
        minw, maxw, sumw    ! diagnostics

      character(len=*), parameter :: subname='(write_restart_field)'

      do n = 1, ndim
          work2(:) = work(:,n)
          write(nu) (work2(i), i=1,nx)
      enddo

      minw = minval(work)
      maxw = maxval(work)
      sumw = sum(work)
      write(nu_diag,*) subname, minw, maxw, sumw

      end subroutine write_restart_field

!=======================================================================


end program
!=======================================================================


