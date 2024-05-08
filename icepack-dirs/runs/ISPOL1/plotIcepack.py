import re
import numpy as np
import matplotlib.pyplot as plt

fn = './ice_diag.full_ITD'
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

plt.figure(1,figsize=(5,8))
plt.subplot(411)
plt.plot(np.arange(365),np.array(sit)) 
plt.ylabel('ice thickness [m]')

plt.subplot(412)
plt.plot(np.arange(365),np.array(snt)) 
plt.ylabel('snow thickness [m]')

plt.subplot(413)
plt.plot(np.arange(365),np.array(swr)) 
plt.ylabel('sw rad [W/m**2]')

plt.subplot(414)
plt.plot(np.arange(365),np.array(tsk)) 
plt.ylabel('surface temperature [degC]')

plt.show()
