import os
import pickle
import numpy as np
from extract_mfcc import extractMfcc
import sys

# Assign argument values to variables
claimedUser = sys.argv[1]
audioFile = f'./public/assets/uploads/login/{claimedUser}.wav'


# Function to predict the user based on the given voice and calculate score
def identify(audioFile, threshold = -51):
    # Path to stored GMM Files
    model_path = "../GMMs/"
    # List of gmm_files available
    gmm_files = [os.path.join(model_path, fname) for fname in
                 os.listdir(model_path) if fname.endswith('.gmm')]
    # List of speakers whose GMMs are available
    speakers = [fname.split("/")[-1].split(".gmm")[0] for fname in gmm_files]

    print(f'Audio file: {audioFile}')
    print(f'Claimed User: {claimedUser}')
    # Read the binary files of the available users.
    models = [pickle.load(open(gmm_file, 'rb')) for gmm_file in gmm_files]
    # MFCC features extracted for the given audioFile
    mfcc = extractMfcc(audioFile)
    score_of_individual_comparision = np.zeros(len(models))
    # Loop through the available models and score each one
    for i in range(len(models)):
        gmm = models[i]
        scores = np.array(gmm.score(mfcc))
        score_of_individual_comparision[i] = scores.sum()

    # Winner gets the maximum score and the user will be selected
    winner = np.argmax(score_of_individual_comparision)
    likelihood = np.max(score_of_individual_comparision)
    print(f'Predicted speaker: {speakers[winner]}')
    print(f'Obtained score: {likelihood}')
    print(f'Threshold: {threshold}')
    
    # check if the obtained score crossed the threshold and whether the claimed user is same as predicted user.
    if (likelihood >= threshold) and (speakers[winner] == claimedUser):
        print('Real user')
        print(True, end='')
    else:
        print('Imposter')
        print(False, end='')

try:
    identify(audioFile, -51)
except Exception as e:
    print(e)
    print('Exception while running identify.py')
    print("error", end='')