# Wekinator_3-continuous_drums

**# 🥁 Gesture-Controlled Drum Machine (MPU6050 + Wekinator)

A machine learning project that turns motion into music. Originally designed to run with a physical MPU6050 gyroscope sensor and Arduino, this version simulates the sensor input in software (using mouse movement) so the full pipeline — from motion data to trained ML model to live drum sounds — can run without any hardware.

## How it works

```
Mouse movement → Simulated sensor (Processing) → OSC → Wekinator (trained ML model) → OSC → Drum machine (Processing) → Sound
```

1. **Input**: A Processing sketch simulates sensor data (pitch/roll) using mouse position, sent via OSC.
2. **Machine Learning**: [Wekinator](http://www.wekinator.org/) is trained on a small set of labeled examples — each mouse position mapped to a desired drum output — and learns to generalize between them.
3. **Output**: A second Processing sketch (built with the [Minim](https://code.compartmental.net/minim/) audio library) receives Wekinator's live predictions and plays three drum samples whose volume/activity responds continuously to the input.

## Why this matters

This project demonstrates **supervised machine learning** in its simplest form: you provide labeled examples, the model learns the underlying pattern, and it generalizes to new input it hasn't seen — all without writing a single line of ML code. Wekinator handles the model training; the surrounding sketches just handle getting data in and sound out.

## Tech stack

- **Processing** — sensor simulation & audio output
- **Wekinator** — supervised machine learning (neural network regression)
- **oscP5 / OSC** — real-time communication between programs
- **Minim** — audio playback library

## Project structure

```
├── sensor/                # Simulated sensor input sketch
├── drum-machine/           # Audio output sketch (Minim-based)
├── wekinator/               # Saved trained Wekinator project
└── screenshots/            # Demo images
```

## Running it yourself

1. Install [Processing](https://processing.org/download) and add the `oscP5` and `Minim` libraries via Sketch → Import Library → Manage Libraries.
2. Install [Wekinator](http://www.wekinator.org/).
3. Run `sensor/simulated_sensor_input.pde` in Processing.
4. In Wekinator, set up a project with 2 inputs / 3 continuous outputs, then record a few example gestures and train.
5. Run `drum-machine/Processing_Drum_3ContinuousOutputs.pde` and move your mouse to hear the model respond.

## Demo

*(Add a screenshot or short screen recording here showing the sensor window, Wekinator, and drum machine running together.)*

## Background / original inspiration

Based on a tutorial for interfacing a physical MPU6050 gyroscope with Arduino and Wekinator to control music generation. This version adapts the pipeline to run entirely in software for accessibility without requiring hardware components.**
