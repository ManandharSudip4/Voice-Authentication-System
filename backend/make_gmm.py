import pickle
from sklearn.mixture import GaussianMixture
from extract_mfcc import extractMfcc
import numpy as np

# Documentation at: https://scikit-learn.org/stable/modules/generated/sklearn.mixture.GaussianMixture.html
# Description of the functional parameters
# these functional parameters needs to be tuned.

# gmm = GMM(n_components=16, n_iter=200, covariance_type='diag', n_init=3)

audioPath = '../../audioFiles/dev-clean/LibriSpeech/dev-clean/174'
speakerName = '174'

def makeGmm(audioPath, speakerName):
    gmm_path = "./GMMs/"
    model_name = speakerName + '.gmm'
    mfcc = extractMfcc(audioPath)
    gmm = GaussianMixture(
        n_components=16, covariance_type='diag', max_iter=500, n_init=3, verbose=1)
    gmm.fit(mfcc)
    pickle.dump(gmm, open(gmm_path + model_name, 'wb'))

makeGmm(audioPath, speakerName)