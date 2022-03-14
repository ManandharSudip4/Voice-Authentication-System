from email.mime import audio
import pickle
from sklearn.mixture import GaussianMixture
from plot_gmm import plot_results
from extract_mfcc import extractMfcc
import sys
# import numpy as np

# Documentation at: https://scikit-learn.org/stable/modules/generated/sklearn.mixture.GaussianMixture.html
# Description of the functional parameters
# these functional parameters needs to be tuned.

# gmm = GMM(n_components=16, n_iter=200, covariance_type='diag', n_init=3)

# audioPath = '../../audioFiles/dev-clean/LibriSpeech/dev-clean/174'
# speakerName = '174'

# speakerName = sys.argv[1]
# print(speakerName)
# audioPath = 'node_api/public/assets/uploads/register/' + speakerName + '.wav'
# audioPath = './public/assets/uploads/register/' + speakerName + '.wav'
# print("py file triggered")
# sys.stdout.flush()


def makeGmm(audioPath, speakerName, file=True, gmm_path="./GMMs/"):
    # print("test1")
    # gmm_path = "./GMMs/"
    model_name = speakerName + '.gmm'
    mfcc = extractMfcc(audioPath, file=file)
    gmm = GaussianMixture(
        n_components=16, covariance_type='diag', max_iter=500, n_init=3, verbose=1, reg_covar=0.1)      # fitting error solved
    gmm.fit(mfcc)
    pickle.dump(gmm, open(gmm_path + model_name, 'wb'))

def gmmPlot(audioPath, speaker, file=True): 
    # print("test1")
    # gmm_path = "./GMMs/"
    mfcc = extractMfcc(audioPath, file=file)
    # print(mfcc)
    gmm = GaussianMixture(
        n_components=16, covariance_type='full', max_iter=500, n_init=3, verbose=1, reg_covar=0.1)      # fitting error solved
    gmm.fit(mfcc)
    for i in range(0, 13):
        for j in range(0, 13):
            plot_results(mfcc, gmm.predict(mfcc), gmm.means_, gmm.covariances_, 0, f'{speaker}', i, j)

if __name__ == "__main__":
    speaker = sys.argv[1]
    isfile = sys.argv[2]
    audio_path = f'./audio/train/{speaker}'
    
    if isfile == "1":
        gmmPlot(f'{audio_path}.wav', speaker)
    else:
        gmmPlot(audio_path, speaker, False)
# print(f'Making GMM for {speakerName}...')
# try:
#     makeGmm(audioPath, speakerName)
#     print('Done')
#     print(True, end='')
# except Exception as e:
#     print(e)
#     print(False, end='')

