import os
import pickle
import numpy as np
from extract_mfcc import extractMfcc
import sys

def identify(audioFile, threshold = -50):

    model_path = "./GMMs/"

    # list of gmm_files available
    gmm_files = [os.path.join(model_path, fname) for fname in
                 os.listdir(model_path) if fname.endswith('.gmm')]

    # name of the model of speaker = same as the name of speaker
    speakers = [fname.split("/")[-1].split(".gmm")[0] for fname in gmm_files]

    # list of existing models
    # rb stands for  reading the binary file
    models = [pickle.load(open(gmm_file, 'rb')) for gmm_file in gmm_files]

    # features of the file to be predicted
    mfcc = extractMfcc(audioFile, file=True)

    score_of_individual_comparision = np.zeros(len(models))

    for i in range(len(models)):
        gmm = models[i]  # checking with each model one by one
        scores = np.array(gmm.score(mfcc))
        score_of_individual_comparision[i] = scores.sum()

    winner = np.argmax(score_of_individual_comparision)

    predicted_speaker = speakers[winner]
    likelihood = np.max(score_of_individual_comparision)
    if likelihood < threshold:
        predicted_speaker = 'imposter'

    return predicted_speaker, score_of_individual_comparision


# audioFile = '../../audioFiles/dev-clean/LibriSpeech/dev-clean/84/121123/84-121123-0000.flac'
audioFile = './audio/test/'
if __name__ == "__main__":
    speaker = sys.argv[1]
    speaker = identify(audioFile + speaker)
    print(speaker)