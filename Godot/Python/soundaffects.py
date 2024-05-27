import numpy as np
from scipy.io.wavfile import write
import matplotlib.pyplot as plt

# Parameters
sample_rate = 44100  # Sample rate in Hz
freq_low = 140  # Frequency of the sine wave in Hz
freq_high = 142  # Frequency of the sine wave in Hz
duration = 5  # Duration in seconds
distortion = 3.4  # Distortion factor
amplitude = 0.5  # Amplitude of the sine wave
# Generate the time values
t = np.arange(sample_rate * duration) / sample_rate
freq_range = (np.sin(2 * np.pi * 1 * t) + 1) / 2 * (freq_high - freq_low) + freq_low

# Generate the sine wave
y = np.sin(2 * np.pi * freq_range * t)

# Apply distortion
y_distorted = np.tanh(distortion * y)

# Normalize to 16-bit range
y_norm = np.int16(y_distorted * 32767)

# Write to a wave file
write("sine.wav", sample_rate, y_norm)

# Plot the first second of the wave
plt.figure(figsize=(10, 4))
plt.plot(t[:sample_rate], y_norm[:sample_rate])
plt.title('Sine Wave')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.grid(True)
plt.show()