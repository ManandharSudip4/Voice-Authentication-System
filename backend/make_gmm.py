import pickle
from sklearn.mixture import GaussianMixture
from extract_mfcc import extractMfcc
import sys
# import numpy as np

# Documentation at: https://scikit-learn.org/stable/modules/generated/sklearn.mixture.GaussianMixture.html
# Description of the functional parameters
# these functional parameters needs to be tuned.

# gmm = GMM(n_components=16, n_iter=200, covariance_type='diag', n_init=3)

# audioPath = '../../audioFiles/dev-clean/LibriSpeech/dev-clean/174'
# speakerName = '174'

speakerName = sys.argv[1]
# print(speakerName)
# audioPath = 'node_api/public/assets/uploads/register/' + speakerName + '.wav'
audioPath = './public/assets/uploads/register/' + speakerName + '.wav'
# print("py file triggered")
# sys.stdout.flush()


def makeGmm(audioPath, speakerName):
    # print("test1")
    # gmm_path = "./GMMs/"
    gmm_path = "../GMMs/"
    model_name = speakerName + '.gmm'
    mfcc = extractMfcc(audioPath)
    if(mfcc == 'error'):
        return False
    gmm = GaussianMixture(
        n_components=16, covariance_type='diag', max_iter=500, n_init=3, verbose=1, reg_covar=0.1)      # fitting error solved
    gmm.fit(mfcc)
    pickle.dump(gmm, open(gmm_path + model_name, 'wb'))
    return True


print(f'Making GMM for {speakerName}...')
try:
    result = makeGmm(audioPath, speakerName)
    if(result):
        print('Done')
        print(True, end='')
    else:
        print('Error occurred')
        print(False, end='')
except Exception as e:
    print(e)
    print('Exception while running make_gmm.py')
    print(False, end='')
