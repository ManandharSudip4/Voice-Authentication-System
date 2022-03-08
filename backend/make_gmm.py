import pickle
from sklearn.mixture import GaussianMixture
from extract_mfcc import extractMfcc
import sys


# Assign argument values to variables
speakerName = sys.argv[1]
audioPath = './public/assets/uploads/register/' + speakerName + '.wav'

# EM Algorithm---->Expectation Maximiation Algorithm


# Function to make GMM using the given audioPath and save it with name speakerName.gmm
def makeGmm(audioPath, speakerName):
    # Parameters for GMM
    n_components = 16               # The number of mixture components
    # 'diag'-->each component has its own diagonal covarianve matrix
    covariance_type = 'diag'
    max_iter = 500                  # The number of EM iterations to perform
    n_init = 3                      # The number of initializations to perform
    verbose = 1                     # Enable verbose output
    # Non-negative regularization added to the diagonal of covariance
    reg_covar = 0.1

    # Path to save GMM files
    gmm_path = "../GMMs/"
    # Name of the GMM file
    model_name = speakerName + '.gmm'

    # Extract MFCC for the audioPath
    mfcc = extractMfcc(audioPath)
    # Check if error occurred during MFCC extraction; if 'yes', return without creating GMM
    if(mfcc == 'error'):
        return False

    # Create GMM by using the extracted MFCC
    gmm = GaussianMixture(n_components=n_components, covariance_type=covariance_type, max_iter=max_iter,
                          n_init=n_init, verbose=verbose, reg_covar=reg_covar)
    gmm.fit(mfcc)
    # Save the created GMM in binary format
    pickle.dump(gmm, open(gmm_path + model_name, 'wb'))
    # Return True if GMM creation is successful
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
