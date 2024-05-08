from scipy.io import FortranFile
import numpy as np

fn = 'restart/iced.2005-01-01-00000'
fp = FortranFile(fn, 'r', '>u4')
print(fp.read_ints('>i4'))
print(fp.read_ints('>i4'))
print(fp.read_reals('>f8'))
print(fp.read_reals('>f8'))
print(fp.read_reals('>f8'))
print(fp.read_reals('>f8'))
print(fp.read_reals('>f8'))
print(fp.read_reals('>f8'))
print(fp.read_reals('>f8'))
print(fp.read_reals('>f8'))
print(fp.read_reals('>f8'))
fp.close()
