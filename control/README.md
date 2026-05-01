# Control System

This folder includes the design and tuning of:

- Current loop (PI)
- Speed loop (PI)
- Position loop (sequential correction)
- ESO implementation

##  Control System Design

The exoskeleton control system is based on a **cascaded control architecture** with three main loops:

- **Inner loop (Current control)** – PI regulator ensuring fast torque control of the BLDC motor  
- **Middle loop (Speed control)** – PI regulator ensuring stable velocity tracking  
- **Outer loop (Position control)** – sequential correction for accurate trajectory tracking  

To improve robustness against external disturbances (human interaction and gravity), the system includes:

- **Extended State Observer (ESO)** for estimation of unknown external torque  
- **Feedforward gravity compensation** based on dynamic model of the elbow joint  

---

### Design Methodology

Controller parameters were designed in frequency domain using Bode plot shaping:

- Current loop bandwidth: ~2 kHz  
- Speed loop bandwidth: 200–400 Hz  
- Position loop bandwidth: 4–20 Hz  

All controllers were tuned in **MATLAB / Simulink Control System Designer**.

---
## Extended State Observer (ESO)

The ESO extends the system state by including the unknown disturbance as an additional state variable, allowing real-time estimation of external torque acting on the elbow joint.

### System Representation

The system is modeled in state-space form with an augmented state vector:

- Joint angle
- Angular velocity
- External disturbance torque

### Design Approach

The observer gain is selected based on a higher bandwidth compared to the control system to ensure fast disturbance estimation.

\[
\omega_{ESO} = 6 \, \omega_c
\]


### Validation

The control system was validated in simulation using:

- MATLAB / Simulink
- Simscape multibody elbow model
- Nonlinear model including gravity and load torque

Results show stable tracking performance in both passive and active rehabilitation modes.

For complete setup and execution instructions, see the main project documentation:

➡️ [How to Run the Full System](../README.md#%EF%B8%8F-how-to-run)
