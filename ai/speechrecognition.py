import speech_recognition as sr
import os
import sys

# cwd = os.getcwd()
# print(cwd)
speakerName = sys.argv[1] + ".wav"
# speakerName = "sandwich.wav"
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
        print("Required Speech: " + r.recognize_google(audio))
    except sr.UnknownValueError:
        print("Cannot understand the audio")


try:
    speechRecog(audio_file)
except Exception as e:
    print(e)