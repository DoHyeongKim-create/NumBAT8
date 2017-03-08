""" Calculate the backward SBS gain spectra of a
    silicon waveguide surrounded in air.

    Show how to save simulation objects (eg EM mode calcs)
    to expedite the process of altering later parts of
    simulations.
"""

import time
import datetime
import numpy as np
import sys
from multiprocessing import Pool
sys.path.append("../backend/")
import matplotlib
matplotlib.use('pdf')
import matplotlib.pyplot as plt

import materials
import objects
import mode_calcs
import integration
import plotting
from fortran import NumBAT

# Select the number of CPUs to use in simulation.
num_cores = 5

# Geometric Parameters - all in nm.
wl_nm = 1550
unitcell_x = 5*wl_nm
unitcell_y = unitcell_x
inc_shape = 'circular'

# Optical Parameters
# n_inc_a = 1.4682 # n_eff Corning SMF 28
n_inc_a = 1.465
num_EM_modes = 20
num_AC_modes = 70
EM_ival1=0
EM_ival2=EM_ival1
AC_ival='All'

# Silca - Laude AIP Advances 2013
s = 2203  # kg/m3
c_11 = 78e9; c_12 = 16e9; c_44 = 31e9
p_11 = 0.12; p_12 = 0.270; p_44 = -0.073
eta_11 = 1.6e-3 ; eta_12 = 1.29e-3 ; eta_44 = 0.16e-3  # Pa s
inc_a_AC_props = [s, c_11, c_12, c_44, p_11, p_12, p_44,
                  eta_11, eta_12, eta_44]

# Expected effective index of fundamental guided mode.
n_eff=1.18
freq_min = 4 
freq_max = 12

width_min = 600
width_max = 2000
num_widths = 300
inc_a_x_range = np.linspace(width_min, width_max, num_widths)
num_interp_pts=2000


def modes_n_gain(inc_a_x):
    inc_a_y = inc_a_x
    # Use all specified parameters to create a waveguide object.
    wguide = objects.Struct(unitcell_x,inc_a_x,unitcell_y,inc_a_y,inc_shape,
                            bkg_material=materials.Material(1.0 + 0.0j),
                            inc_a_material=materials.Material(n_inc_a),
                            loss=False, inc_a_AC=inc_a_AC_props,
                            lc_bkg=3, lc2=1000.0, lc3=5.0)

    sim_EM_wguide = wguide.calc_EM_modes(wl_nm, num_EM_modes, n_eff=n_eff)
    k_AC = 2*np.real(sim_EM_wguide.Eig_values[0])
    shift_Hz = 4e9
    sim_AC_wguide = wguide.calc_AC_modes(wl_nm, num_AC_modes, k_AC=k_AC,
        EM_sim=sim_EM_wguide, shift_Hz=shift_Hz)

    set_q_factor = 600.
    SBS_gain, SBS_gain_PE, SBS_gain_MB, alpha = integration.gain_and_qs(
        sim_EM_wguide, sim_AC_wguide, k_AC,
        EM_ival1=EM_ival1, EM_ival2=EM_ival2, AC_ival=AC_ival, fixed_Q=set_q_factor)

    interp_values = plotting.gain_specta(sim_AC_wguide, SBS_gain, SBS_gain_PE, SBS_gain_MB, alpha, k_AC,
        EM_ival1, EM_ival2, AC_ival, freq_min, freq_max, num_interp_pts=num_interp_pts)

    return interp_values

# Run widths in parallel across num_cores CPUs using multiprocessing package.
pool = Pool(num_cores)
width_objs = pool.map(modes_n_gain, inc_a_x_range)


gain_array = np.zeros((num_interp_pts, num_widths))
for w, width_interp in enumerate(width_objs):
    gain_array[:,w] = width_interp[::-1]

# np.savez('wguide_data_AC_gain', gain_array=gain_array)
# npzfile = np.load('wguide_data_AC_gain.npz')
# gain_array = npzfile['gain_array']

# plt.clf()
fig = plt.figure()
ax1 = fig.add_subplot(1,1,1)
blah = ax1.matshow(gain_array, aspect='auto', interpolation = 'none')

num_xticks = 5
num_yticks = 5
ax1.xaxis.set_ticks_position('bottom')
ax1.set_xticks(np.linspace(0,(num_widths-1),num_xticks))
ax1.set_yticks(np.linspace((num_interp_pts-1),0,num_yticks))
ax1.set_xticklabels(["%4.0f" % i for i in np.linspace(width_min,width_max,num_xticks)])
ax1.set_yticklabels(["%4.0f" % i for i in np.linspace(freq_min,freq_max,num_yticks)])

plt.xlabel(r'Width ($\mu m$)')
plt.ylabel('Frequency (GHz)')
plt.savefig('gain-width_scan.pdf')
plt.close()