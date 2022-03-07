import os
import pickle
import numpy as np
from extract_mfcc import extractMfcc
import sys

claimedUser = sys.argv[1]


def identify(audioFile, threshold = 51):

    model_path = "../GMMs/"

    # list of gmm_files available
    gmm_files = [os.path.join(model_path, fname) for fname in
                 os.listdir(model_path) if fname.endswith('.gmm')]
    # gmm_file = model_path + claimedUser + '.gmm'

    # name of the model of speaker = same as the name of speaker
    speakers = [fname.split("/")[-1].split(".gmm")[0] for fname in gmm_files]
    login_speaker = audioFile.split("/")[-1].split(".")[0]
    print(f'audio_file: {audioFile}')
    print(f'login_speaker: {login_speaker}')
    # list of existing models
    # rb stands for  reading the binary file
    models = [pickle.load(open(gmm_file, 'rb')) for gmm_file in gmm_files]
    # model = pickle.load(open(gmm_file, 'rb'))

    # features of the file to be predicted
    mfcc = extractMfcc(audioFile, file=True)

    score_of_individual_comparision = np.zeros(len(models))

    for i in range(len(models)):
        gmm = models[i]  # checking with each model one by one
        scores = np.array(gmm.score(mfcc))
        score_of_individual_comparision[i] = scores.sum()

    winner = np.argmax(score_of_individual_comparision)

    likelihood = np.max(score_of_individual_comparision)
    print(f'Predicted speaker: {speakers[winner]}')
    print(f'Obtained score: {likelihood}')
    print(f'Threshold: {threshold}')
    
    if (likelihood >= threshold) and (speakers[winner] == login_speaker):
        print('Real user')
        print(True, end='')
    else:
        print('Imposter')
        print(False, end='')
    # score = np.array(model.score(mfcc))
    # print(f'Obtained score: {score}')

    # if score >= -51:
    #    print(True, end='')
    # else:
    #    print(False, end='')


# audioFile = '../../audioFiles/dev-clean/LibriSpeech/dev-clean/84/121123/84-121123-0000.flac'
audioFile = f'./public/assets/uploads/login/{claimedUser}.wav'
identify(audioFile, -51)
