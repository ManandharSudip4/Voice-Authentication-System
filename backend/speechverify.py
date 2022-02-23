import string
from Levenshtein import distance as lev

given = "hi what is the weather like"

speechRecognised = "!hi. wh?at is the weat[h]er lik?e."

new_string = speechRecognised.translate(str.maketrans('', '', string.punctuation))

print(new_string)

percentage = (lev(given, new_string) / len(given)) * 100

print("{} %".format(percentage))

# giv = given.split()

# sr = speechRecognised.split()


# for i in range(len(giv)):
#     if giv[i] == sr[i]:
#         print("Same")