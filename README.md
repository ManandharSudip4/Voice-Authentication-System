# Voice-Authentication-System
A Voice Authentication System is simply an authentication system that authenticates a user by recognizing their voice. In this project, we have implemented the Voice Authentication System consisting of speech verification and speaker recognition. During registration, we have extracted MFCC from the audio and used it to create GMM for each user. During login, we have compared the MFCC against the existing GMMs to identify the voice and verified the speech in order to authenticate the user.
## Requirements
1. Sox
2. Python Packages
    - librosa
    - scikit-learn
    - SpeechRecognition
    - python-Levenshtein
3. Node.js Packages
    - express
    - jsonwebtoken
    - mongoose
    - multer
    - await-spawn
4. Flutter Packages
    - cupertino_icons
    - flutter_sound
    - record
    - path_provider
    - permission_handler
    - http
    - flutter_spinkit
    - shared_preferences
    - intl

## Test Environment
>### Python 3.8
>### Node 17
>### Flutter 2.10
## Instructions

### 1. Clone the repo:
>`git clone https://github.com/ManandharSudip4/Voice-Authentication-System.git`
### 2. cd into cloned directory:

>`cd Voice-Authentication-System`
### 3. Install python packages:
>`pip install -r requirements.txt`
### 4. Copy config.json.example as config.json and update it with relevant info:
>`cp backend/node_api/config.json.example backend/node_api/config.json`  

### 5. Copy config.dart.example as config.dart and update it with relevant info:
>`cp frontend/voice_auth_application/lib/config.dart.example frontend/voice_auth_application/lib/config.dart`

### 6. Update ip address:
>`./updateipaddress.py`
### 7. Install node modules:
>`cd backend/node_api`  
>`npm install`
### 8. Run the node server:
>`nodemon index`  
### 9. Build the flutter app
### 10. Run the app