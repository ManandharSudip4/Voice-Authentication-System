import librosa
import numpy as np
import subprocess


# Function to extract MFCC from the given audio file.
def extractMfcc(audioPath):
    # Parameters for MFCC
    fmin = 100              # Minimum Frequency
    fmax = 8000             # Maximum Frequency
    sr = 22050              # Sampling Rate (Number of samples in 1 sec)
    n_mfcc = 13             # Number of coefficients to extract
    n_mels = 40             # Number of mel bins
    hop_length = 160        # Number of samples to shift window by
    n_fft = 512             # Number of samples in a window

    try:
        # Get the format of the audioPath
        audioFormat = audioPath.split('.')[-1]

        # Convert the audio into wav format in case it already is not by the help of sox tool
        # The new file is deleted afterwards
        # The audio signal is loaded into variable y with sampling rate sr
        if(audioFormat != 'wav'):
            subprocess.run(['sox', audioPath, audioPath+'.wav'])
            y, sr = librosa.load(audioPath+'.wav', sr=sr)
            subprocess.run(['rm', audioPath+'.wav'])
        else: 
            y, sr = librosa.load(audioPath, sr=sr)

        # The mfcc from the audio signal i.e. y is extracted using the specified parameters
        mfcc = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=n_mfcc, n_fft=n_fft,
                                    n_mels=n_mels, hop_length=hop_length, fmin=fmin, fmax=fmax)
        mfcc = np.transpose(mfcc)
        print(mfcc.shape)

        # return the extracted mfcc
        return mfcc
    except Exception as e:
        print(e)
        print('Exception while running extract_mfcc.py')
        # return 'error' in case some exception occurs
        return 'error'
