# ELBOW_EXOSKELETON_CONTROL
Control system design for an elbow exoskeleton with passive/active modes, cascaded PI loops, and ESO-based Human-interaction estimation


## 🧩 Overview

This project presents the design and simulation of an elbow rehabilitation exoskeleton developed as part of a diploma work.

The system supports two rehabilitation modes:

* Passive mode – the exoskeleton moves the patient’s arm along a predefined trajectory
* Active mode – the patient applies force, and the system adapts to human interaction

The goal is to achieve safe, smooth, and controllable motion while accounting for unknown human-applied forces.

---

## ⚙️ System Architecture

The exoskeleton system consists of:

* Electric motor with transmission
* Encoder for position feedback
* Phase current sensing
* Embedded control system

Control structure:

LOW LEVEL CONTROL

* Inner loop: Current control (PI)
* Middle loop: Speed control (PI)
* Outer loop: Position control with sequential correction

 

HIGH LEVEL CONTROL

* Admittance control based on measurement of the human interaction force estimated via ESO

  

---

---

## Control Strategy

### Cascaded Control (Каскадная система)

A multi-loop control structure is used to ensure:

* fast inner-loop dynamics
* stable outer-loop position tracking

### Extended State Observer (ESO)

An ESO is designed to estimate:

* human interaction torque

This allows the system to operate without direct force/torque sensors, simplifying hardware.

---

## Rehabilitation Strategy

### Passive Mode

* The system follows a predefined trajectory
* Smooth motion planning ensures patient safety

### Active Mode

* The patient applies force
* Interaction torque is estimated via ESO
* The system acts as a Spring-Damper to resist the human force

---

## Trajectory Planning

Trajectory generation ensures:

* S-curve smooth position profile
* limited and controlled velocity and acceleration 

---

##  Simulation

The system was developed and validated using:

* **MATLAB / Simulink**
* **Simscape (multibody model)**

Simulation includes:

* dynamic model of the elbow joint
* control system integration
* graphical motion visualization

---

## Hardware Considerations

Current simplified design:

* encoder feedback
* current-phase measurements to run inner FOC loop in hand with the encoder built-in the chosen BLDC

---

## 📁 Repository Structure

* `docs/` – theoretical background and design explanation
* `simulations/` – Simulink and Simscape models
* `control/` – control system design and tuning
* `hardware/` – PCB and sensor configuration
* `results/` – plots and simulation outputs

---

markdown
## ▶️ How to Run

1. Download or clone this repository to your local machine  
2. Open **MATLAB**  
3. Navigate to the project root folder:
elbow-exoskeleton-control/

text
4. Run the initialization script:
```matlab
init_project
Open the simulation model:

simulations/simulink_full_model.slx

or simulations/simscape_full_model.slx

Run the simulation by clicking Run (▶) inside Simulink
##  Future Work

* Implementation on embedded system (STM32)
* Real hardware validation
* Improved human-machine interaction

---
