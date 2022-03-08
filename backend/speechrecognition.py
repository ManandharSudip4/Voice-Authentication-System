import string
from Levenshtein import distance as lev
import speech_recognition as sr
import os
import sys

# Assign argument values to variables
speakerName = sys.argv[1] + ".wav"
given = sys.argv[2]
speechType = sys.argv[3]

# Set audio_path to register or login directory
if(speechType == 'register'):
    audio_path = "./public/assets/uploads/register/"
else:
    audio_path = "./public/assets/uploads/login/"
# Complete path to the audio file
audio_file = os.path.join(audio_path, speakerName)

# Filter out punctuation marks and convert the string to lowercase
givenFilter = given.translate(
    str.maketrans('', '', string.punctuation)).lower()


# Function to extract speech from given audio and match it to required speech
def speechRecog(audio_file):
    # use audio as a source
    r = sr.Recognizer()
    with sr.AudioFile(audio_file) as source:
        audio = r.record(source)            # reads entire audio file

    # recognize speech using google speech recognition
    try:
        return r.recognize_google(audio)
    except sr.UnknownValueError:
        print("Cannot understand the audio")
        print("False", end='')
        exit(0)


try:
    # Speech from the audio
    gotit = speechRecog(audio_file)
    # Calculate closeness with the required speech
    percentage = (lev(givenFilter, gotit) / len(givenFilter)) * 100
    # 20% room for error
    # Accept the speech if error is less than 20%
    if percentage <= 20:
        print("True", end='')
    else:
        print("False", end='')
except Exception as e:
    print(e)
    print('Exception while running speechrecognition.py')
    print('error', end='')
