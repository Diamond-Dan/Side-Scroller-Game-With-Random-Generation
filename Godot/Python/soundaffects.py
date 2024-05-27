"""Module to generate sound effects for a game using Python and SciPy."""
import os
import random
import numpy as np
from scipy.io.wavfile import write
from scipy.signal import square, sawtooth
# import matplotlib.pyplot as plt
from pydub import AudioSegment


def convert_to_wav(sample_rate, y_norm, file_name):
    """Converts the sound to a WAV file."""
    cur_dir = os.path.dirname(__file__)
    write(cur_dir + "\\sounds\\" + file_name + ".wav", sample_rate, y_norm)

# currently not using this function
# def convert_to_mp3(filename):
#     """Converts the sound to a MP3 file."""
#     audio = AudioSegment.from_wav("sounds\\"+filename + ".wav")
#     audio.export("sounds\\"+filename + ".mp3", format="mp3")


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
    """Generates an explosion sound effect using a sawtooth wave."""
    sample_rate = random.randint(500, 1000)  # Sample rate in Hz
    freq_low = random.randint(50, 100)  # Frequency of the sine wave in Hz
    freq_high = random.randint(550, 650)  # Frequency of the sine wave in Hz
    duration = random.uniform(1.0, 1.5)  # Duration in seconds
    distortion = 5  # Distortion factor
    amplitude = random.randint(2, 3)  # Amplitude of the sine wave
    file_name = "explosion_sound"
    # Generate the time values
    t = np.arange(sample_rate * duration) / sample_rate

    freq_range = (np.sin(2 * np.pi * freq_high * t) + 1) / 2 * \
        (freq_high - freq_low) - freq_high

    # Generate the sine wave
    y = amplitude * sawtooth(2 * np.pi * freq_range * t)

    # Generate an envelope that starts at 1 and decreases to 0
    envelope = np.exp(-5 * np.linspace(0, 1, len(y)))

    # Apply the envelope to the wave
    y_fadeout = y * envelope

    # Apply distortion
    y_distorted = np.tanh(distortion * y_fadeout)

    # Normalize to 16-bit range
    y_norm = np.int16(y_distorted * 32767)

    # Write to a wave file
    convert_to_wav(sample_rate, y_norm, file_name)
   


def flying_noise():
    """Generates a flying noises sound effect using a square wave."""
    sample_rate = random.randint(249, 800)  # Sample rate in Hz
    after_burner_sample_rate = sample_rate*2
    freq_low = random.randint(300, 900)  # Frequency of the sine wave in Hz
    freq_high = random.randint(1350, 1950)  # Frequency of the sine wave in Hz
    duration = random.uniform(3.0, 4.1)  # Duration in seconds
    distortion = 2  # Distortion factor
    amplitude = random.randint(6, 10)  # Amplitude of the sine wave
    file_name_1 = "engine_sound"
    file_name_2 = "afterburner_sound"
    # Generate the time values
    t = np.arange(sample_rate * duration) / sample_rate
    t_after_burner = np.arange(after_burner_sample_rate * duration) \
        / after_burner_sample_rate
    freq_range = (np.sin(2 * np.pi * 1 * t) + 1) / 2 * \
        (freq_high - freq_low) + freq_low
    freq_range_after_burner = (np.sin(2 * np.pi * 1 * t_after_burner) + 1) / \
        2 * (freq_high - freq_low) + freq_low
    # Generate the  wave
    y = amplitude * square(2 * np.pi * freq_range * t)
    y_after_burner = amplitude * \
        sawtooth(2 * np.pi * freq_range_after_burner * t_after_burner)

    # Apply distortion
    y_distorted = np.tanh(distortion * y)
    y_distorted_after_burner = np.tanh(distortion * y_after_burner)
    # Normalize to 16-bit range
    y_norm = np.int16(y_distorted * 32767)
    y_norm_after_burner = np.int16(y_distorted_after_burner * 32767)
    # Write to a wave file
    convert_to_wav(sample_rate, y_norm, file_name_1)
    convert_to_wav(after_burner_sample_rate, y_norm_after_burner, file_name_2)
    



if __name__ == '__main__':
    laser_sound()
    explosion_sound()
    flying_noise()
