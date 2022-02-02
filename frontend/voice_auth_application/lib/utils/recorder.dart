import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class Recorder{
  FlutterSoundRecorder? _recorder;
  bool _isRecorderInitialized = false;

  bool get isRecording => _recorder!.isRecording;
  String?  _path;
  String? _fileName;
  String internalPath = "/storage/emulated/0/";

  Future init(String fileName) async {
    // if (!_isRecorderInitialized){
      // print("======================");
      final Directory directory = await getApplicationDocumentsDirectory();
      _path = directory.path;
      _fileName = fileName;
      // print(_path);
      // _path = _path !+ '/' + fileName;

      _recorder = FlutterSoundRecorder();
      // get permission
      var status = await Permission.microphone.request();
      var stat = await Permission.storage.request();
      await Permission.manageExternalStorage.request();
      while (status != PermissionStatus.granted || stat != PermissionStatus.granted){
        status = await Permission.microphone.request();
        stat = await Permission.storage.request();
        // st = await Permission.manageExternalStorage.request();
        // print("permission denied");
        // return;

      }

      await _recorder!.openAudioSession();
      _isRecorderInitialized = true;
    // }
  }

  void _saveFileInStorage() async{
    String filePath = _path !+ '/' + _fileName!;
    File audiofile = File(filePath);
    final Directory _appDocDirFolder = Directory('$_path');
    if (! await _appDocDirFolder.exists()){
       await _appDocDirFolder.create(recursive: true);
    }
    Uint8List bytes = await audiofile.readAsBytes();
    audiofile.writeAsBytes(bytes);
    // File testfile = File('$internalPath/$_fileName');
    // testfile.writeAsBytes(bytes);
  }

  void dispose(){
    _recorder!.closeAudioSession();
    _recorder =  null;
    _isRecorderInitialized = false;
  }

  Future startRecord() async{
    if (!_isRecorderInitialized){
      // print("Recorder is not intialized");
      return;
    }
    // print('Start Recording..');
    await _recorder!.startRecorder(
      toFile: '$_path/$_fileName',
    );
  }

  Future stopRecord() async{
    if (!_isRecorderInitialized){
      return;
    }
    await _recorder!.stopRecorder();
    _saveFileInStorage();
    // print('Stopped Recording ...');
  }

}