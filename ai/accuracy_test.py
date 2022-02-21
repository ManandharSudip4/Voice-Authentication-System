import os
from re import A
from identify import identify

AUDIOPATH = './audio/test/'

def getSpeaker(filename):
    filename = filename.split('.')[0]
    return filename.split('_')[0]

def __calculateAccuracy(testpath):
    correct_prediction = 0
    incorrect_prediction = 0
    for root, dirs, files in os.walk(testpath, topdown=False):
        for file in files:
            real_speaker = getSpeaker(file)
            predicted_speaker, _= identify(root + file)
            if real_speaker == predicted_speaker:
                correct_prediction += 1
            else:
                incorrect_prediction += 1 
            print(predicted_speaker)
    accuracy = correct_prediction / (correct_prediction + incorrect_prediction) * 100
    return accuracy

if __name__ == "__main__":
    accuracy = __calculateAccuracy(AUDIOPATH)
    print(f'Accuracy: {accuracy}')
    