import os
import pickle
import numpy as np
from extract_mfcc import extractMfcc

def testPredict(audio_path):
    '''
    @:param audio_path : Path to the audio which needs to be predicted

    @:return: Returns the speaker thus detected by comparing to the model
    '''

    model_path = "GMMs/"

    # list of gmm_files available
    gmm_files = [os.path.join(model_path, fname) for fname in
                os.listdir(model_path) if fname.endswith('.gmm')]

    # name of the model of speaker = same as the name of speaker
    speakers = [fname.split("/")[-1].split(".gmm")[0] for fname in gmm_files]


    #list of existing models
    models   = [pickle.load(open(gmm_file,'rb')) for gmm_file in gmm_files] # rb stands for  reading the binary file


    # features of the file to be predicted
    mfcc = extractMfcc(audio_path, file=True)

    score_of_individual_comparision = np.zeros(len(models))

    for i in range(len(models)):
        gmm = models[i]  # checking with each model one by one
        scores = np.array(gmm.score(mfcc))
        score_of_individual_comparision[i] = scores.sum()

    winner = np.argmax(score_of_individual_comparision)

    speaker_detected = speakers[winner]

    return speaker_detected



def identify(audioFile):
    '''
    @param file_name : name of the file inside the dataset/predicted to be predicted
    @return: name of the speaker predicted
    '''
    speaker_predicted = testPredict(audioFile)
    print(speaker_predicted)
    # return speaker_predicted

# if __name__ == "__main__":
#     predict_dir_path = 'dataset/predict/'
#     file_name = sys.argv[-1]
#     predicted =  predict(predict_dir_path+file_name)
#     print(predicted)



audioFile = '../../audioFiles/dev-clean/LibriSpeech/dev-clean/84/121123/84-121123-0000.flac'
identify(audioFile)
