import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_door/Screens/create_Event/create_event_provider.dart';

// class ThumnailUploader extends StatefulWidget {
//   ThumnailUploader({Key? key}) : super(key: key);

//   @override
//   _ThumnailUploaderState createState() => _ThumnailUploaderState();
// }

// class _ThumnailUploaderState extends State<ThumnailUploader> {
//   final GlobalKey exportKey = GlobalKey();
//   var filePickerCross;

//   String _fileString = '';
//   var lastFiles;
//   FileQuotaCross quota = FileQuotaCross(quota: 0, usage: 0);

//   @override
//   void initState() {
//     FilePickerCross.listInternalFiles()
//         .then((value) => setState(() => lastFiles = value.toSet()));
//     FilePickerCross.quota().then((value) => setState(() => quota = value));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           primaryColor: Colors.blueGrey, accentColor: Colors.lightGreen),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: ListView(
//           padding: EdgeInsets.all(8),
//           children: <Widget>[
//             Text(
//               'Last files',
//               style: Theme.of(context).textTheme.headline5,
//             ),
//             (lastFiles == null)
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     primary: false,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) => ListTile(
//                       leading: Text('$index.'),
//                       title: Text(lastFiles.toList()[index]),
//                       onTap: () async => setFilePicker(
//                           await FilePickerCross.fromInternalPath(
//                               path: lastFiles.toList()[index])),
//                     ),
//                     itemCount: lastFiles.length,
//                   ),
//             Builder(
//               builder: (context) => ElevatedButton(
//                 onPressed: () => _selectFile(context),
//                 child: Text('Open File...'),
//               ),
//             ),
//             (filePickerCross == null)
//                 ? Text('Open a file first, to save')
//                 : ElevatedButton(
//                     key: exportKey,
//                     onPressed: _selectSaveFile,
//                     child: Text('Save as...'),
//                   ),
//             Text(
//               'File system details',
//               style: Theme.of(context).textTheme.headline5,
//             ),
//             Text('Quota: ${(quota.quota / 1e6).round()} MB'),
//             Text(
//                 'Usage: ${(quota.usage / 1e6).round()}; Remaining: ${(quota.remaining / 1e6).round()}'),
//             Text('Percentage: ${quota.relative.roundToDouble()}'),
//             Text(
//               'File details',
//               style: Theme.of(context).textTheme.headline5,
//             ),
//             Text(
//                 'File path: ${filePickerCross.path ?? 'unknown'} (Might cause issues on web)\n'),
//             Text('File length: ${filePickerCross.length == 0}\n'),
//             Text('File as String: $_fileString\n'),
//           ],
//         ),
//       ),
//     );
//   }

//   void _selectFile(context) {
//     FilePickerCross.importMultipleFromStorage().then((filePicker) {
//       setFilePicker(filePicker[0]);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('You selected ${filePicker.length} file(s).'),
//         ),
//       );

//       setState(() {});
//     });
//   }

//   void _selectSaveFile() {
//     RenderObject? renderBox = exportKey.currentContext!.findRenderObject();
//     // Offset position = renderBox.localToGlobal(Offset.zero);
//     filePickerCross.exportToStorage(
//       subject: filePickerCross.fileName,
//       // sharePositionOrigin: Rect.fromLTWH(
//       //     //
//       //     position.dx,
//       //     position.dy,
//       //     renderBox!.width,
//       //     renderBox.size.height)
//     );
//   }

//   setFilePicker(FilePickerCross filePicker) => setState(() {
//         filePickerCross = filePicker;
//         filePickerCross.saveToPath(path: filePickerCross.fileName.toString());
//         FilePickerCross.quota().then((value) {
//           setState(() => quota = value);
//         });
//         lastFiles.add(filePickerCross.fileName.toString());
//         try {
//           _fileString = filePickerCross.toString();
//         } catch (e) {
//           _fileString = 'Not a text file. Showing base64.\n\n' +
//               filePickerCross.toBase64();
//         }
//       });
// }
class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  /// Variables
  File imageFile = null as File;
  late CreateEventProvider _createEventProvider;

  @override
  void initState() {
    super.initState();
    _createEventProvider =
        Provider.of<CreateEventProvider>(context, listen: false);
  }

  /// Widget
  @override
  Widget build(BuildContext context) {
    return imageFile == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Pick image from"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox.fromSize(
                    size: Size(
                        MediaQuery.of(context).size.width * 0.2,
                        MediaQuery.of(context).size.height *
                            0.09), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Colors.greenAccent, // button color
                        child: InkWell(
                          splashColor: Colors.orange, // splash color
                          onTap: () {
                            _getFromGallery();
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add_photo_alternate_rounded), // icon
                              Text("Gallery"), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size(
                        MediaQuery.of(context).size.width * 0.2,
                        MediaQuery.of(context).size.height *
                            0.09), // button width and height
                    child: ClipOval(
                      child: Material(
                        color: Colors.lightGreenAccent, // button color
                        child: InkWell(
                          splashColor: Colors.orange, // splash color
                          onTap: () {
                            _getFromCamera();
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add_a_photo_sharp), // icon
                              Text("Camera"), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        : Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          imageFile = null as File;
                          print('imageFile: $imageFile');
                        });
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Color(0xffff5018),
                        size: MediaQuery.of(context).size.width * .1,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * .8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
    //  Scaffold(
    //     appBar: AppBar(
    //       title: Text("Image Picker"),
    //     ),
    //     body: Container(
    //         child: imageFile == null
    //             ? Container(
    //                 alignment: Alignment.center,
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: <Widget>[
    //                     RaisedButton(
    //                       color: Colors.greenAccent,
    //                       onPressed: () {
    //                         _getFromGallery();
    //                       },
    //                       child: Text("PICK FROM GALLERY"),
    //                     ),
    //                     Container(
    //                       height: 40.0,
    //                     ),
    //                     RaisedButton(
    //                       color: Colors.lightGreenAccent,
    //                       onPressed: () {
    //                         _getFromCamera();
    //                       },
    //                       child: Text("PICK FROM CAMERA"),
    //                     )
    //                   ],
    //                 ),
    //               )
    //             : Container(
    //                 child: Image.file(
    //                   imageFile,
    //                   fit: BoxFit.cover,
    //                 ),
    //               )));
  }

  /// Get from gallery

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print('imageFile: $imageFile');
        _createEventProvider.imagefile = imageFile;
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        _createEventProvider.imagefile = imageFile;
      });
    }
  }
}


// // Get Image and Crop Image

// // import 'dart:io';

// // import 'package:flutter/material.dart';
// // import 'package:image_cropper/image_cropper.dart';
// // import 'package:image_picker/image_picker.dart';


// // class ImageUpload extends StatefulWidget {
// //   ImageUpload({Key? key}) : super(key: key);

// //   @override
// //   _ImageUploadState createState() => _ImageUploadState();
// // }

// // class _ImageUploadState extends State<ImageUpload> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //        child: null,
// //     );
// //   }
// // }


// // /// Widget to capture and crop the image
// // class ImageCapture extends StatefulWidget {
// //   createState() => _ImageCaptureState();
// // }

// // class _ImageCaptureState extends State<ImageCapture> {
// //   /// Active image file
// //   late File _imageFile;

// //   /// Cropper plugin
// //   Future<void> _cropImage() async {
// //     File cropped = await ImageCropper.cropImage(
// //         sourcePath: _imageFile.path,
// //         // ratioX: 1.0,
// //         // ratioY: 1.0,
// //         // maxWidth: 512,
// //         // maxHeight: 512,
// //         toolbarColor: Colors.purple,
// //         toolbarWidgetColor: Colors.white,
// //         toolbarTitle: 'Crop It');

// //     setState(() {
// //       _imageFile = cropped ?? _imageFile;
// //     });
// //   }

// //   /// Select an image via gallery or camera
// //   Future<void> _pickImage(ImageSource source) async {
// //     // File selected = await ImagePicker.pickImage(source: source);
// //     PickedFile? pickedFile = await ImagePicker().getImage(
// //       source: source,
// //       maxWidth: 1800,
// //       maxHeight: 1800,
// //     );

// //     setState(() {
// //       _imageFile = pickedFile as File;
// //     });
// //   }

// //   //   _getFromGallery() async {
// //   //   PickedFile? pickedFile = await ImagePicker().getImage(
// //   //     source: ImageSource.gallery,
// //   //     maxWidth: 1800,
// //   //     maxHeight: 1800,
// //   //   );
// //   //   if (pickedFile != null) {
// //   //     setState(() {
// //   //       imageFile = File(pickedFile.path);
// //   //     });
// //   //   }
// //   // }

// //   /// Remove image
// //   void _clear() {
// //     setState(() => _imageFile = null as File);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       bottomNavigationBar: BottomAppBar(
// //         child: Row(
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //           children: <Widget>[
// //             IconButton(
// //               icon: Icon(
// //                 Icons.photo_camera,
// //                 size: 30,
// //               ),
// //               onPressed: () => _pickImage(ImageSource.camera),
// //               color: Colors.blue,
// //             ),
// //             IconButton(
// //               icon: Icon(
// //                 Icons.photo_library,
// //                 size: 30,
// //               ),
// //               onPressed: () => _pickImage(ImageSource.gallery),
// //               color: Colors.pink,
// //             ),
// //           ],
// //         ),
// //       ),
// //       body: ListView(
// //         children: <Widget>[
// //           if (_imageFile != null) ...[
// //             Container(
// //                 padding: EdgeInsets.all(32), child: Image.file(_imageFile)),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: <Widget>[
// //                 FlatButton(
// //                   color: Colors.black,
// //                   child: Icon(Icons.crop),
// //                   onPressed: _cropImage,
// //                 ),
// //                 FlatButton(
// //                   color: Colors.black,
// //                   child: Icon(Icons.refresh),
// //                   onPressed: _clear,
// //                 ),
// //               ],
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(32),
// //               child: Uploader(
// //                 key: UniqueKey(),
// //                 file: _imageFile,
// //               ),
// //             )
// //           ]
// //         ],
// //       ),
// //     );
// //   }
// // }

// // /// Widget used to handle the management of
// // class Uploader extends StatefulWidget {
// //   final File file;

// //   Uploader({required Key key, required this.file}) : super(key: key);

// //   createState() => _UploaderState();
// // }

// // class _UploaderState extends State<Uploader> {
// //   // final FirebaseStorage _storage =
// //   //     FirebaseStorage(storageBucket: 'gs://fireship-lessons.appspot.com');

// //   StorageUploadTask _uploadTask;

// //   _startUpload() {
// //     String filePath = 'images/${DateTime.now()}.png';

// //     setState(() {
// //       _uploadTask = ref().child(filePath).putFile(widget.file);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     if (_uploadTask != null) {
// //       return StreamBuilder(
// //           stream: _uploadTask.events,
// //           builder: (context, snapshot) {
// //             var event = snapshot.data;

// //             double progressPercent = event != null
// //                 ? event.bytesTransferred / event.totalByteCount
// //                 : 0;

// //             return Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   if (_uploadTask.isComplete)
// //                     Text('🎉🎉🎉',
// //                         style: TextStyle(
// //                             color: Colors.greenAccent,
// //                             height: 2,
// //                             fontSize: 30)),
// //                   if (_uploadTask.isPaused)
// //                     FlatButton(
// //                       child: Icon(Icons.play_arrow, size: 50),
// //                       onPressed: _uploadTask.resume,
// //                     ),
// //                   if (_uploadTask.isInProgress)
// //                     FlatButton(
// //                       child: Icon(Icons.pause, size: 50),
// //                       onPressed: _uploadTask.pause,
// //                     ),

                    
// //                   LinearProgressIndicator(value: progressPercent),
// //                   Text(
// //                     '${(progressPercent * 100).toStringAsFixed(2)} % ',
// //                     style: TextStyle(fontSize: 50),
// //                   ),
// //                 ]);
// //           });
// //     } else {
// //       return FlatButton.icon(
// //           color: Colors.blue,
// //           label: Text('Upload to Firebase'),
// //           icon: Icon(Icons.cloud_upload),
// //           onPressed: _startUpload);
// //     }
// //   }

// //   ref() {}
// // }