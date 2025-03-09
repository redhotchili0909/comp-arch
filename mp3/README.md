# ENGR 3410: Miniproject 3
**Due Date:** March 13, 2025
**Course:** ENGR 3410 - Computer Architecture

## Assignment Description
In this miniproject, you will use the OSS CAD suite to design a digital circuit to produce a sinusoidal waveform through a 10-bit R-2R ladder digital-to-analog converter (DAC). You will optimize memory usage by taking advantage of symmetries within one cycle of the sine function.

### Requirements
1. Produce a sinusoidal voltage waveform with **512 samples per cycle** through the 10-bit R-2R ladder DAC.
2. Use a look-up table with **no more than 128 9-bit samples** of the first quarter cycle of a sine wave.
3. Compute sample values for the other three quarters by taking advantage of sine function symmetries.
4. Implement the circuit in **SystemVerilog**.
5. Provide a test bench and simulation results using **Icarus Verilog**.
6. Demonstrate the waveform on an oscilloscope.

### Deliverables
By **March 13, 2025**, submit the following:
- PDF report explaining your circuit design and operation.
- Simulation results showing at least one complete cycle (gtkwave plot).
- Oscilloscope measurement of the output voltage waveform.
- All SystemVerilog source files for your circuit and test bench.