import argparse
import sys
import matplotlib.pyplot as plt
from accuracy_test import AUDIOPATH, calculateAccuracy

AUDIOPATH = './audio/test/'

def __plot(accuracy_list):
    epoch = list(range(1, len(accuracy_list) + 1))
    plt.plot(epoch, accuracy_list)
    plt.xlabel("Epoch")
    plt.ylabel("Accuracy")
    plt.title("Accuracy list")
    plt.show()

def __argument():
    parser = argparse.ArgumentParser()
    parser.add_argument("--learning_rate", type = float, \
        help= "Learning rate", default = 0.1)
    parser.add_argument("--start", type = int, \
        help = "Starting threshold", default = -45)
    parser.add_argument("--end", type = int, \
        help = "Ending threshold", default = -60)
    args = parser.parse_args()
    return args

if __name__ == "__main__":
    arguments = __argument()
    accuracy_list = []
    start = arguments.start
    end = arguments.end
    learning_rate = arguments.learning_rate
    epoch = 1
    while(start > end):
        print(f"Epoch: {epoch} Threshold: {start}")
        accuracy = calculateAccuracy(testpath=AUDIOPATH, threshold=start)
        accuracy_list.append(accuracy)
        print(f'Accuracy: {accuracy}')
        start -= learning_rate
        epoch += 1
    print('---------------------')

    print(accuracy_list)
    __plot(accuracy_list)

    pass