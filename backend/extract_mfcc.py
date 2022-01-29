from re import I
import python_speech_features as psf
import librosa
import numpy as np
from timeit import default_timer as timer
import csv
import os
import torchaudio
import torch
import matplotlib.pyplot as plt
from scipy.signal.windows import hann
from nnAudio.features.mel import MFCC as nnMFCC
import subprocess
# from scipy.io import wavfile
# import pandas as pd


def main():

    for root, dirs, files in os.walk('../audioFiles/dev-clean', topdown=False):
        for name in files:
            name = os.path.join(root, name)

            try:
                subprocess.run(['sox', '-r', '16k', name,
                                name+'.wav'])

                y, sr = librosa.load(name+'.wav', sr=None)

                subprocess.run(['rm', name+'.wav'])

                mfcc = mfcc_using_librosa(y, sr)
                print(mfcc.shape)

                # mfcc = mfcc_using_psf(y, sr)
                # print(mfcc.shape)

                # mfcc = mfcc_using_torchaudio(y, sr)
                # print(mfcc.shape)

                # mfcc = mfcc_using_nnAudio(y, sr)
                # print(mfcc.shape)
            except:
                pass

    # blah(audioFile='../audioFiles/download')
    # extract_mfcc()


def mfcc_using_librosa(y, sr):
    mfcc = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=13, n_fft=512,
                                n_mels=40, hop_length=160, fmin=0, fmax=None, htk=False)
    mfcc = np.transpose(mfcc)
    return mfcc


def mfcc_using_psf(y, sr):
    mfcc = psf.base.mfcc(signal=y, samplerate=sr, winlen=512/sr, winstep=160/sr, numcep=13, nfilt=40,
                         nfft=512, lowfreq=0, highfreq=None, preemph=0.0, ceplifter=0, appendEnergy=False, winfunc=hann)
    return mfcc


def mfcc_using_torchaudio(y, sr):
    melkwargs = {"n_fft": 512, "n_mels": 40,
                 "hop_length": 160, "f_min": 0, "f_max": None}
    mfcc = torchaudio.transforms.MFCC(
        sample_rate=sr, n_mfcc=13, melkwargs=melkwargs)(torch.from_numpy(y)).to('cuda:0')
    mfcc = np.transpose(mfcc.data.cpu().numpy())
    return mfcc


def mfcc_using_nnAudio(y, sr):
    mfcc = nnMFCC(
        sr=sr, n_mfcc=13, verbose=False)(torch.from_numpy(y)).to('cuda:0')
    mfcc = np.transpose(mfcc.data.cpu().numpy()[0])
    return mfcc


if __name__ == "__main__":
    start = timer()
    main()
    print("Time:", timer()-start)


# The code below this is just for testing purposes.
# **************************************************************

def blah(audioFile):

    subprocess.run(['sox', '-r', '16k', '../audioFiles/download',
                   '../audioFiles/download.wav'])

    n_mfcc = 13
    n_mels = 40
    n_fft = 512
    hop_length = 160
    fmin = 0
    fmax = None
    sr = 16000
    device = 'cuda:0'

    # nbits = 16

    melkwargs = {"n_fft": n_fft, "n_mels": n_mels,
                 "hop_length": hop_length, "f_min": fmin, "f_max": fmax}

    y, sr = librosa.load('../audioFiles/download.wav', sr=None)
    # print(y)
    # print()
    # (sr, y) = wavfile.read('../audioFiles/download.wav')
    # y = y.astype(np.float64)
    # y /= 2 ** (nbits - 1)
    # print(y)

    # print()
    # print('sr:', sr)
    # print()

    # print()
    # print("From python_speech_features:")
    # mfcc = psf.base.mfcc(signal=y, samplerate=sr, winlen=n_fft/sr, winstep=hop_length/sr, numcep=n_mfcc, nfilt=n_mels,
    #                      nfft=n_fft, lowfreq=fmin, highfreq=fmax, preemph=0.0, ceplifter=0, appendEnergy=False, winfunc=hann)
    # print(mfcc)
    # with open('psf.csv', 'w') as f:
    #     writer = csv.writer(f)
    #     writer.writerows(mfcc)

    print()
    print("From librosa:")
    mfcc = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=n_mfcc, n_fft=n_fft,
                                n_mels=n_mels, hop_length=hop_length, fmin=fmin, fmax=fmax, htk=False)
    print(mfcc)
    print(mfcc.shape)
    with open('librosa.csv', 'w') as f:
        writer = csv.writer(f)
        writer.writerows(mfcc)

    # y, sr = torchaudio.load('../audioFiles/download.wav')
    print()
    print("From torchaudio:")
    mfcc = torchaudio.transforms.MFCC(
        sample_rate=sr, n_mfcc=n_mfcc, melkwargs=melkwargs)(torch.from_numpy(y)).to(device)
    mfcc = mfcc.data.cpu().numpy()
    print(type(mfcc))
    print(mfcc.shape)
    # pd.DataFrame(mfcc).to_csv('torchaudio.csv')
    np.save('torchaudio.npy', mfcc)
    # mfcc.tofile('torchaudio.csv', sep=',')
    # np.savetxt('torchaudio.csv', mfcc, delimiter=',')
    # print(mfcc.cpu().data.numpy())
    # torchaudio.save()
    # mfcc.save('torchaudio.csv')
    # with open('torchaudio.csv', 'w') as f:
    #     writer = csv.writer(f)
    #     writer.writerows(mfcc)

    # y, sr = librosa.load('/home/manandhar/Documents/Minor_Project/test/Voice-Authentication-System/audioFiles/dev-clean/LibriSpeech/dev-clean/84/121123/84-121123-0000.flac', sr=sr)

    # y, sr = librosa.load('../audioFiles/download.wav', sr=None)

    print()
    print("From nnAudio:")
    mfcc = nnMFCC(
        sr=sr, n_mfcc=n_mfcc)(torch.from_numpy(y)).to(device)
    mfcc = mfcc.data.cpu().numpy()
    print(type(mfcc))
    print(mfcc.shape)
    np.save('nnAudio.npy', mfcc)
    # with open('nnAudio.csv', 'w') as f:
    #     writer = csv.writer(f)
    #     writer.writerows(mfcc)


def extract_mfcc():
    for root, dirs, files in os.walk('../audioFiles/dev-clean', topdown=False):
        # print('ageah')
        for name in files:
            print(os.path.join(root, name))
            name = os.path.join(root, name)
            fileNameList = name.split('.')
            print(fileNameList)
            if(fileNameList[-1] == 'flac'):
                y, sr = librosa.load(name)
                mfcc = np.transpose(
                    librosa.feature.mfcc(y=y, sr=sr, n_mfcc=13))
                print(mfcc)
                with open('../dataset.csv', 'a') as f:
                    writer = csv.writer(f)
                    writer.writerows(mfcc)
        # for name in dirs:
        #     print(os.path.join(root, name))
        # pass
    # y, sr = librosa.load('../audioFiles/download')
    # mfcc = np.transpose(librosa.feature.mfcc(y=y, sr=sr, n_mfcc=13))
    # print(mfcc)
    # print(type(mfcc))
    # with open('../dataset.csv', 'w') as f:
    #     writer = csv.writer(f)
    #     writer.writerows(mfcc)


# from numba import jit, cuda
# import numpy as np
# # to measure exec time

# # normal function to run on cpu
# def func(a):
# 	for i in range(10000000):
# 		a[i]+= 1

# # function optimized to run on gpu
# @jit
# def func2(a):
# 	for i in range(10000000):
# 		a[i]+= 1
# if __name__=="__main__":
# 	n = 10000000
# 	a = np.ones(n, dtype = np.float64)
# 	b = np.ones(n, dtype = np.float32)

# 	start = timer()
# 	func(a)
# 	print("without GPU:", timer()-start)

# 	start = timer()
# 	func2(a)
# 	print("with GPU:", timer()-start)
