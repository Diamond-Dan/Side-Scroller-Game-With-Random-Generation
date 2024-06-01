"""Module to generate sound effects for a game using Python and SciPy."""
import os
import random
import numpy as np
from scipy.io.wavfile import write
from scipy.signal import square, sawtooth
import matplotlib.pyplot as plt
from pydub import AudioSegment


def convert_to_wav(sample_rate, y_norm, file_name):
    """Converts the sound to a WAV file."""
    cur_dir = os.path.dirname(__file__)
    write(cur_dir + "\\sounds\\" + file_name + ".wav", sample_rate, y_norm)
    return(cur_dir + "\\sounds\\" + file_name + ".wav")
# currently not using this function
def convert_to_mp3(filename):
    """Converts the sound to a MP3 file."""
    audio = AudioSegment.from_wav("sounds\\"+filename + ".wav")
    audio.export("sounds\\"+filename + ".mp3", format="mp3")

def plot_wave(t, y_norm, duration):
    # keeping this for debugging purposes
    # Plot the first second of the wave
    plt.figure(figsize=(10, 4))
    plt.plot(t, y_norm)
    plt.title('Sine Wave')
    plt.xlabel('Time (s)')
    plt.ylabel('Amplitude')
    plt.grid(True)
    plt.xlim([0, duration])
    plt.show()

   

def laser_sound():
    """Generates a laser sound effect using a square wave."""
    sample_rate = 44100  # Sample rate in Hz
    freq_low = random.randint(130, 160)  # Frequency of the sine wave in Hz
    freq_high = random.randint(200, 247)  # Frequency of the sine wave in Hz
    duration = random.uniform(1.0, 2.1)  # Duration in seconds
    distortion = 1  # Distortion factor
    amplitude = 2  # Amplitude of the sine wave
    file_name = "laser_sound"
    # Generate the time values
    t = np.arange(sample_rate * duration) / sample_rate

    freq_range = (np.sin(2 * np.pi * freq_high * t) + 1) / 2 * \
        (freq_high - freq_low)

    # Generate the sine wave
    y = amplitude * square(2 * np.pi * freq_range * t)

    # Apply distortion
    y_distorted = np.tanh(distortion * y)

    # Normalize to 16-bit range
    y_norm = np.int16(y_distorted * 2500)

    # Write to a wave file
    convert_to_wav(sample_rate, y_norm, file_name)
    convert_to_mp3(file_name)
    return file_name
    # keeping this for debugging purposes
    # # Plot the first second of the wave
    # plt.figure(figsize=(10, 4))
    # plt.plot(t, y_norm)
    # plt.title('Sine Wave')
    # plt.xlabel('Time (s)')
    # plt.ylabel('Amplitude')
    # plt.grid(True)
    # plt.xlim([0, duration])
    # plt.show()

    # print("Amplitude range: ", np.min(y_norm), " to ", np.max(y_norm))


def explosion_sound():
    """Generates an explosion sound effect using a sine wave."""
    sample_rate = 44100  # Sample rate in Hz
    freq_low = random.randint(80, 220)  # Frequency of the sine wave in Hz
    freq_high = random.randint(60, 100)  # Frequency of the sine wave in Hz
    duration = random.uniform(1.0, 1.4)  # Duration in seconds
    distortion = 1  # Distortion factor
    amplitude = random.randint(300, 400)/100  # Amplitude of the sine wave
    modulation_freq = random.randint(1,2)  # Modulation frequency
    pitch_scale = random.randint(500, 600)/1000  # Pitch scale
    file_name = "explosion_sound"
    
    # Generate the time values
    t = np.arange(sample_rate * duration) / sample_rate

    # freq_range = (freq_low + (freq_high - freq_low) * t )
    freq_range = freq_low
    # Generate the sine wave
    y = amplitude * np.sin(2*np.pi * pitch_scale * freq_range * t)

    # Generate an envelope with a spike

    envelope = np.exp(-6 * np.linspace(0, 1, len(y)))  # Standard exponential decay
    spike_time = duration / 2  # Set spike at the halfway point
    spike_width = duration / 70 # Define the width of the spike
    
    spike = np.exp(-((t - spike_time) ** 2) / (2 * (spike_width ** 2)))  # Gaussian spike
    envelope += spike *random.uniform(.5, .9) # Add the spike to the envelope, adjust multiplier to control spike intensity
    spike_time = duration / 4  # Set spike at the quarter point
    spike_width = duration / 20 # Define the width of the spike
    spike = np.exp(-((t - spike_time) ** 2) / (2 * (spike_width ** 2)))  # Gaussian spike
    envelope += spike * .2  # Add the spike to the envelope, adjust multiplier to control spike intensity
    # Apply the envelope to the wave
    y_fadeout = y * envelope

    # Apply distortion
    y_distorted = np.tanh(distortion * y_fadeout)

    # Normalize to 16-bit range
    y_norm = np.int16(y_distorted * 32767)

    # Write to a wave file
    convert_to_wav(sample_rate, y_norm, file_name)
    # plot_wave(t, y_norm, duration)
    convert_to_mp3(file_name)
    return file_name

def flying_noise():
    """Generates flying noises sound effect using a square wave for engine and afterburner sounds with frequency oscillation."""
    sample_rate = 44100  # Sample rate in Hz
    after_burner_sample_rate = 44100
    base_freq = random.randint(55, 70)  # Base frequency for the regular engine in Hz
    base_freq_afterburner = base_freq + 100  # Base frequency for the afterburner in Hz
    duration = 5  # Duration in seconds
    distortion = 2  # Distortion factor
    amplitude = random.randint(100, 200)/1000  # Amplitude of the wave
    mod_depth = 2  # Depth of frequency modulation
    mod_freq = random.randint(2,7)  # Frequency of modulation in Hz
    file_name_1 = "engine_sound"
    file_name_2 = "afterburner_sound"

    # Generate the time values
    t = np.arange(sample_rate * duration) / sample_rate
    t_after_burner = np.arange(after_burner_sample_rate * duration) / after_burner_sample_rate
    
    # Create modulation signal
    mod_signal = mod_depth * np.sin(2 * np.pi * mod_freq * t)
    mod_signal_afterburner = mod_depth * np.sin(2 * np.pi * mod_freq * t_after_burner)
    
    # Generate the modulated square wave
    y = amplitude * square(2 * np.pi * (base_freq + mod_signal) * t)
    y_after_burner = amplitude * square(2 * np.pi * (base_freq_afterburner + mod_signal_afterburner) * t_after_burner)

    # Apply distortion
    y_distorted = np.tanh(distortion * y)
    y_distorted_after_burner = np.tanh(distortion * y_after_burner)

    # Normalize to 16-bit range
    y_norm = np.int16(y_distorted * 32767)
    y_norm_after_burner = np.int16(y_distorted_after_burner * 32767)

    # Write to wave files
    convert_to_wav(sample_rate, y_norm, file_name_1)
    convert_to_wav(after_burner_sample_rate, y_norm_after_burner, file_name_2)

    convert_to_mp3(file_name_1)
    convert_to_mp3(file_name_2)

    return file_name_1, file_name_2


if __name__ == '__main__':
    laser_sound()
    explosion_sound()
    flying_noise()
