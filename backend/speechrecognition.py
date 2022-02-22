import string
from Levenshtein import distance as lev
import speech_recognition as sr
import os
import sys

given = "Test Passage, to be! read by the; user to setup the user model."
givenFilter = given.translate(str.maketrans('', '', string.punctuation)).lower()
# cwd = os.getcwd()
# print(cwd)
# speakerName = "sandwich.wav"
speakerName = sys.argv[1] + ".wav"
# audio_path = "node_api/public/assets/uploads/register/"
audio_path = "./public/assets/uploads/register/"
audio_file = os.path.join(audio_path,speakerName)
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
        print("True",end='')
    else:
        print("False",end='')
except Exception as e:
    print(e)



