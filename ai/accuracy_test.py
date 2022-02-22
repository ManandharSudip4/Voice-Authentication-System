import os
from re import A
from identify import identify

AUDIOPATH = './audio/test/'

def getSpeaker(filename):
    filename = filename.split('.')[0]
    return filename.split('_')[0]

def calculateAccuracy(testpath = AUDIOPATH, threshold = -50):
    correct_prediction = 0
    incorrect_prediction = 0
    for root, dirs, files in os.walk(testpath, topdown=False):
        for file in files:
            real_speaker = getSpeaker(file)
            try:
                predicted_speaker, _= identify(root + file, threshold = threshold)
                if real_speaker == predicted_speaker:
                    correct_prediction += 1
                else:
                    incorrect_prediction += 1 
                # print(predicted_speaker)
            except:
                pass
    accuracy = correct_prediction / (correct_prediction + incorrect_prediction) * 100
    return accuracy

if __name__ == "__main__":
    accuracy = calculateAccuracy(AUDIOPATH)
    print(f'Accuracy: {accuracy}')
    