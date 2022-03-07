import librosa
import numpy as np
import os
import subprocess

# audioPath = '../../audioFiles/dev-clean/LibriSpeech/dev-clean/84'


def extractMfcc(audioPath):
    fmin = 100              # Minimum Frequency
    fmax = 8000             # Maximum Frequency
    sr = 22050              # Sampling Rate (Number of samples in 1 sec)
    n_mfcc = 13             # Number of coefficients to extract
    n_mels = 40             # Number of mel bins
    hop_length = 160        # Number of samples to shift window by
    n_fft = 512             # Number of samples in a window

    # flag = 0

    # if file:
    try:
        # print(audioPath)
        subprocess.run(['sox', audioPath, audioPath+'.wav'])
        y, sr = librosa.load(audioPath+'.wav', sr=sr)
        subprocess.run(['rm', audioPath+'.wav'])
        mfcc = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=n_mfcc, n_fft=n_fft,
                                    n_mels=n_mels, hop_length=hop_length, fmin=fmin, fmax=fmax)
        mfcc = np.transpose(mfcc)
        print(mfcc.shape)

        return mfcc
    except Exception as e:
        print(e)
        print('Exception while running extract_mfcc.py')
        return 'error'
    # else:
    #     for root, dirs, files in os.walk(audioPath, topdown=False):
    #         for name in files:
    #             name = os.path.join(root, name)

    #             try:
    #                 subprocess.run(['sox', name,
    #                                 name+'.wav'])

    #                 y, sr = librosa.load(name+'.wav', sr=sr)

    #                 subprocess.run(['rm', name+'.wav'])

    #                 currentMfcc = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=n_mfcc, n_fft=n_fft,
    #                                                    n_mels=n_mels, hop_length=hop_length, fmin=fmin, fmax=fmax)
    #                 currentMfcc = np.transpose(currentMfcc)

    #                 if(flag == 1):
    #                     mfcc = np.vstack((mfcc, currentMfcc))
    #                 else:
    #                     flag = 1
    #                     mfcc = currentMfcc

    #                 print(mfcc.shape)

    #             except Exception as e:
    #                 print(e)
    # return mfcc

# extractMfcc(audioPath)
