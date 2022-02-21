import os
from accuracy_test import getSpeaker
from make_gmm import makeGmm

GMMPATH = './GMMs/'
AUDIOPATH = './audio/train/'

def __train(path):
    for root, dirs, files in os.walk(path, topdown=True):
        if root == path:
            for file in files:
                speaker = getSpeaker(file)
                print(file, speaker)
                makeGmm(root + file, speaker, file=True, gmm_path=GMMPATH)
        for dir in dirs:
            speaker = getSpeaker(dir)
            print(dir, speaker)
            makeGmm(root + '/' + dir, speaker, file=False, gmm_path=GMMPATH)
            
if __name__ == "__main__":
    __train(AUDIOPATH)