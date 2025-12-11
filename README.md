# Graphical-user-interface-for-electromechanical-system
Development of a software tool for analyzing the behavior of electromechanical systems under alternating current conditions

**Electromechanical Filter System – MATLAB Simulation & GUI**

This project implements a complete simulation, analysis, and visualization environment for an **AC electromechanical filter circuit**.  
The work includes mathematical modeling, transfer function computation, state-space modeling, frequency response analysis, Simulink simulations, and an interactive MATLAB GUI for real-time parameter exploration.

The project was developed as part of an engineering coursework on system modeling and control.

---

## Project Overview
The goal of the project was to analyze and simulate a filter circuit whose frequency-dependent behavior becomes significant for selected component parameters.  

The project covers:
- Mathematical derivation of circuit equations  
- Transfer function computation (symbolic & numeric)  
- Frequency response analysis  
- Parameter sensitivity study  
- State-space model  
- Simulink simulation  
- Simscape physical modeling  
- MATLAB GUI for interactive circuit analysis  

---

## Main Features

### **1. Circuit Modeling**
The circuit was analyzed using two classical methods:
- **Mesh Current Method (MSP)**
- **Node Voltage Method (MUN)**

From these, a matrix equation with impedances was derived, forming the basis for symbolic modeling.

---

### **2. Transfer Function Calculation**
Using symbolic MATLAB:
- Transfer function was derived symbolically  
- Converted to numeric form for selected component values  
- Poles and zeros extracted and tabulated  

The tool can compute:
- Input-output transfer function  
- Frequency-domain characteristics  

---

### **3. Frequency Characteristics**
The project includes:
- **Amplitude Frequency Characteristic (AFC)**  
- **Phase Frequency Characteristic (PFC)**  

The system behavior is explained by identifying:
- Filter type  
- Influence of poles/zeros  
- Expected frequency ranges  

---

### **4. Parameter Sensitivity Analysis**
The GUI and scripts allow varying:
- **L** (inductance)  
- **C** (capacitance)  
- **R** (resistance or additional parameters depending on circuit version)

Analysis demonstrates how:
- Shifting parameters affects poles/zeros  
- Resonant frequency moves  
- System stability and filter shape are altered  

---

### **5. Harmonic Response**
The system was tested with sinusoidal excitation at different frequencies to highlight:
- Phase shift regions  
- Amplitude variations  
- Transition points in frequency response  

---

### **6. State-Space Model**
Based on circuit equations:
- State-space matrices (A, B, C, D) were derived manually  
- Results were verified against transfer function calculations  

---

### **7. Simulink Simulation**
Simulation model built **from equations**, not from the transfer function:
- System response validated  
- Time-domain signals exported to MATLAB using *To Workspace* block  

Additional simulations:
- Response to square-wave input  
- Chirp signal response representing full frequency sweep  

---

### **8. Physical Simulation via Simscape**
A Simscape model was constructed to:
- Validate mathematical model  
- Compare physical simulation with theoretical response  

---

### **9. MATLAB GUI**
The final stage of the project was a custom GUI that enables:

✔ Real-time parameter tuning  
✔ Visual frequency response updates  
✔ Display of poles & zeros  
✔ Time-domain simulation  
✔ Quick comparison between parameter sets  

---
