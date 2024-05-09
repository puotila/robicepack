#!/usr/bin/python3
"""
Plot multiple time series from different experiments in same plots
"""
import os
import re
import numpy as np
import matplotlib.pyplot as plt

def readExperiment(experiment_name):
    fn = os.path.join(experiment_name,'./ice_diag.full_ITD')
    fp = open(fn)
    lines = fp.readlines()
    fp.close()

    sit = []
    snt = []
    swr = []
    tsk = []
    for line in lines:
        if re.search('ice thickness',line):
            sit.append(np.float32(line.split()[5]))
        if re.search('shortwave radiation',line):
            swr.append(np.float32(line.split()[3]))
        if re.search('snow depth',line):
            snt.append(np.float32(line.split()[5]))
        if re.search('surface temperature',line):
            tsk.append(np.float32(line.split()[3]))
    return {'sit': np.array(sit), 'snt': np.array(snt), \
            'swr': np.array(swr), 'tsk': np.array(tsk)}

#####
if __name__ == "__main__":
   exps = ['ISPOL1','ISPOL2','ISPOL3']
   edata = {}
   for exp in exps:
       edata[exp] = readExperiment(exp)

   plt.figure(1,figsize=(5,8))
   plt.subplot(411)
   for exp in exps:
       plt.plot(np.arange(365),edata[exp]['sit'],label=exp) 
   plt.gca().legend()
   plt.ylabel('ice thickness [m]')

   plt.subplot(412)
   for exp in exps:
       plt.plot(np.arange(365),edata[exp]['snt']) 
   plt.ylabel('snow thickness [m]')

   plt.subplot(413)
   for exp in exps:
       plt.plot(np.arange(365),edata[exp]['swr']) 
   plt.ylabel('sw rad [W/m**2]')

   plt.subplot(414)
   for exp in exps:
       plt.plot(np.arange(365),edata[exp]['tsk']) 
   plt.ylabel('surface temperature [degC]')

   plt.show()
