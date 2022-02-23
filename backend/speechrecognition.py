import string
from Levenshtein import distance as lev
import speech_recognition as sr
import os
import sys

speechType = sys.argv[3]
given = sys.argv[2]
givenFilter = given.translate(
    str.maketrans('', '', string.punctuation)).lower()
# cwd = os.getcwd()
# print(cwd)
# speakerName = "sandwich.wav"
speakerName = sys.argv[1] + ".wav"
# audio_path = "node_api/public/assets/uploads/register/"
if(speechType == 'register'):
    audio_path = "./public/assets/uploads/register/"
else:
    audio_path = "./public/assets/uploads/login/"
audio_file = os.path.join(audio_path, speakerName)
# print(audio_file)


def speechRecog(audio_file):
    # use audio as a source
    r = sr.Recognizer()
    with sr.AudioFile(audio_file) as source:
        audio = r.record(source)            # reads entire audio file

    # recognize speech using google speech recognition
    try:
        # print("Required Speech: " + r.recognize_google(audio))
        return r.recognize_google(audio)
    except sr.UnknownValueError:
        return "Cannot understand the audio"


gotit = speechRecog(audio_file)
# print(gotit)

try:
    percentage = (lev(givenFilter, gotit) / len(givenFilter)) * 100
    if percentage <= 20:
        # print(int(percentage))
        print("True", end='')
    else:
        print("False", end='')
except Exception as e:
    print(e)
