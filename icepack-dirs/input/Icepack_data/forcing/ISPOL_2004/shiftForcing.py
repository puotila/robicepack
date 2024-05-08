#!/usr/bin/python3
"""
Shift icepack ISPOL forcing so
that it starts at the beginning of the
melting season in 2004 day of year 366 - 100
"""
import re
import numpy as np

fp = open('ISPOL_atm_forcing_05092018.txt','r')
lines = fp.readlines()
fp.close()

valmat = []
values = []
for line in lines:
    lst = line.split()
    for lstval in lst:
        m = re.match(';',lstval)
        if m is None:
            values.append(lstval)
        else:
            valmat.append(values)
            values = [] 

fp = open('ISPOL_atm_forcing_shifted.txt','w')
for valno in range(len(valmat)):
    values = valmat[valno]
    icol = 0
    if len(values)==366:
        vidxs = np.hstack((np.arange(366-100,366),np.arange(366-100)))
    else: # 366*4    
        vidxs = np.hstack((np.arange(366*4-400,366*4),np.arange(366*4-400)))
    for vidx in vidxs:
        fp.write(f"{values[vidx]} ")
        icol = icol + 1
        if icol%4 == 0:
            fp.write('\n')
    fp.write(' ;\n')
fp.close()

# ocean data are monthly
fp = open('pop_frc.gx1v3.051202_but_hblt_from_010815_ispol.txt','r')
lines = fp.readlines()
fp.close()

valmat = []
values = []
icol = 0
for line in lines:
    lst = line.split()
    for lstval in lst:
        values.append(lstval)
        icol = icol + 1
        if icol==12:
            valmat.append(values)
            icol = 0
            values = []
fp = open('pop_frc.gx1v3.051202_but_hblt_from_010815_ispol_shifted.txt','w')
vidxs = [9,10,11,0,1,2,3,4,5,6,7,8]
for valno in range(len(valmat)):
    values = valmat[valno]
    for vidx in vidxs:
        fp.write(f"{values[vidx]} ")
    fp.write(' \n')
fp.close()
print('Finnished!')
