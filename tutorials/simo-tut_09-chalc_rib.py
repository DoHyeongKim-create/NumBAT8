""" Calculate the backward SBS gain for modes in a
    silicon waveguide surrounded in air.
"""

import time
import datetime
import numpy as np
import sys

sys.path.append("../backend/")
import materials
import objects
import mode_calcs
import integration
import plotting
from fortran import NumBAT

# Naming conventions
# AC: acoustic
# EM: electromagnetic
# k_AC: acoustic wavenumber

start = time.time()

# Geometric Parameters - all in nm.
wl_nm = 1550 # Wavelength of EM wave in vacuum.
# Unit cell must be large to ensure fields are zero at boundary.
unitcell_x = 5*wl_nm
unitcell_y = 0.5*unitcell_x
# Waveguide widths.
inc_a_x = 1000
inc_a_y = 400
# Shape of the waveguide.
# inc_shape = 'rectangular'
inc_shape = 'rib_coated'

coat_x = 100
coat_y = 200
slab_a_y = 500
slab_b_y = 200

# Number of electromagnetic modes to solve for.
num_modes_EM_pump = 20
num_modes_EM_Stokes = num_modes_EM_pump
# Number of acoustic modes to solve for.
num_modes_AC = 20
# The first EM mode(s) for which to calculate interaction with AC modes.
# Can specify a mode number (zero has lowest propagation constant) or 'All'.
EM_ival_pump = 0
# The second EM mode(s) for which to calculate interaction with AC modes.
EM_ival_Stokes = EM_ival_pump
# The AC mode(s) for which to calculate interaction with EM modes.
AC_ival = 'All'

# Use specified parameters to create a waveguide object.
# Note use of rough mesh for demonstration purposes.
wguide = objects.Struct(unitcell_x,inc_a_x,unitcell_y,inc_a_y,inc_shape,
						coat_x=coat_x, coat_y=coat_y, slab_a_y=slab_a_y, slab_b_y=slab_b_y,
                        material_a=materials.Air,
                        material_b=materials.As2S3_exp,
                        material_c=materials.SiO2,
                        material_d=materials.SiO2,
                        lc_bkg=3, lc2=2000.0, lc3=1000.0)

# Expected effective index of fundamental guided mode.
n_eff = wguide.material_b.n-0.1

# Calculate the Electromagnetic modes of the pump field.
sim_EM_pump = wguide.calc_EM_modes(wl_nm, num_modes_EM_pump, n_eff)
# # np.savez('wguide_data', sim_EM_pump=sim_EM_pump)
# npzfile = np.load('wguide_data.npz')
# sim_EM_pump = npzfile['sim_EM_pump'].tolist()

# Calculate the Electromagnetic modes of the Stokes field.
sim_EM_Stokes = mode_calcs.bkwd_Stokes_modes(sim_EM_pump)
# np.savez('wguide_data2', sim_EM_Stokes=sim_EM_Stokes)
# npzfile = np.load('wguide_data2.npz')
# sim_EM_Stokes = npzfile['sim_EM_Stokes'].tolist()

# Print the wavevectors of EM modes.
print('\n k_z of EM modes \n', np.round(np.real(sim_EM_pump.Eig_values),4))

# Calculate the EM effective index of the waveguide.
n_eff_sim = np.real(sim_EM_pump.Eig_values[0]*((wl_nm*1e-9)/(2.*np.pi)))
print("\n n_eff = ", np.round(n_eff_sim, 4))

k_AC = np.real(sim_EM_pump.Eig_values[0] - sim_EM_Stokes.Eig_values[0])
print('\n AC wavenumber (1/m) = ', np.round(k_AC, 4))

# Calculate Acoustic modes.
sim_AC = wguide.calc_AC_modes(wl_nm, num_modes_AC, 
    k_AC=k_AC, EM_sim=sim_EM_pump)
# # np.savez('wguide_data_AC', sim_AC=sim_AC)
# npzfile = np.load('wguide_data_AC.npz')
# sim_AC = npzfile['sim_AC'].tolist()

# Print the frequencies of AC modes.
print('\n Freq of AC modes (GHz) \n', np.round(np.real(sim_AC.Eig_values)*1e-9, 4))


# Calculate interaction integrals and SBS gain for PE and MB effects combined, 
# as well as just for PE, and just for MB. Also calculate acoustic loss alpha.
SBS_gain, SBS_gain_PE, SBS_gain_MB, alpha, Q_factors = integration.gain_and_qs(
    sim_EM_pump, sim_EM_Stokes, sim_AC, k_AC,
    EM_ival_pump=EM_ival_pump, EM_ival_Stokes=EM_ival_Stokes, AC_ival=AC_ival)
# Print the Backward SBS gain of the AC modes.
print("\n SBS_gain PE contribution \n", SBS_gain_PE[EM_ival_Stokes,EM_ival_pump,:])
print("SBS_gain MB contribution \n", SBS_gain_MB[EM_ival_Stokes,EM_ival_pump,:])
print("SBS_gain total \n", SBS_gain[EM_ival_Stokes,EM_ival_pump,:])
# Mask negligible gain values to improve clarity of print out.
threshold = 1e-3
masked_PE = np.ma.masked_inside(SBS_gain_PE[EM_ival_Stokes,EM_ival_pump,:], 0, threshold)
masked_MB = np.ma.masked_inside(SBS_gain_MB[EM_ival_Stokes,EM_ival_pump,:], 0, threshold)
masked = np.ma.masked_inside(SBS_gain[EM_ival_Stokes,EM_ival_pump,:], 0, threshold)
print("\n SBS_gain PE contribution \n", masked_PE)
print("SBS_gain MB contribution \n", masked_MB)
print("SBS_gain total \n", masked)

end = time.time()
print("\n Simulation time (sec.)", (end - start))