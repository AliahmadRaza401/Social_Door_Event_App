import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  /// Variables
  File imageFile = null as File;

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
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * .2,
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
      });
    }
  }
}


// Get Image and Crop Image

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';


// class ImageUpload extends StatefulWidget {
//   ImageUpload({Key? key}) : super(key: key);

//   @override
//   _ImageUploadState createState() => _ImageUploadState();
// }

// class _ImageUploadState extends State<ImageUpload> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: null,
//     );
//   }
// }


// /// Widget to capture and crop the image
// class ImageCapture extends StatefulWidget {
//   createState() => _ImageCaptureState();
// }

// class _ImageCaptureState extends State<ImageCapture> {
//   /// Active image file
//   late File _imageFile;

//   /// Cropper plugin
//   Future<void> _cropImage() async {
//     File cropped = await ImageCropper.cropImage(
//         sourcePath: _imageFile.path,
//         // ratioX: 1.0,
//         // ratioY: 1.0,
//         // maxWidth: 512,
//         // maxHeight: 512,
//         toolbarColor: Colors.purple,
//         toolbarWidgetColor: Colors.white,
//         toolbarTitle: 'Crop It');

//     setState(() {
//       _imageFile = cropped ?? _imageFile;
//     });
//   }

//   /// Select an image via gallery or camera
//   Future<void> _pickImage(ImageSource source) async {
//     // File selected = await ImagePicker.pickImage(source: source);
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: source,
//       maxWidth: 1800,
//       maxHeight: 1800,
//     );

//     setState(() {
//       _imageFile = pickedFile as File;
//     });
//   }

//   //   _getFromGallery() async {
//   //   PickedFile? pickedFile = await ImagePicker().getImage(
//   //     source: ImageSource.gallery,
//   //     maxWidth: 1800,
//   //     maxHeight: 1800,
//   //   );
//   //   if (pickedFile != null) {
//   //     setState(() {
//   //       imageFile = File(pickedFile.path);
//   //     });
//   //   }
//   // }

//   /// Remove image
//   void _clear() {
//     setState(() => _imageFile = null as File);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             IconButton(
//               icon: Icon(
//                 Icons.photo_camera,
//                 size: 30,
//               ),
//               onPressed: () => _pickImage(ImageSource.camera),
//               color: Colors.blue,
//             ),
//             IconButton(
//               icon: Icon(
//                 Icons.photo_library,
//                 size: 30,
//               ),
//               onPressed: () => _pickImage(ImageSource.gallery),
//               color: Colors.pink,
//             ),
//           ],
//         ),
//       ),
//       body: ListView(
//         children: <Widget>[
//           if (_imageFile != null) ...[
//             Container(
//                 padding: EdgeInsets.all(32), child: Image.file(_imageFile)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 FlatButton(
//                   color: Colors.black,
//                   child: Icon(Icons.crop),
//                   onPressed: _cropImage,
//                 ),
//                 FlatButton(
//                   color: Colors.black,
//                   child: Icon(Icons.refresh),
//                   onPressed: _clear,
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(32),
//               child: Uploader(
//                 key: UniqueKey(),
//                 file: _imageFile,
//               ),
//             )
//           ]
//         ],
//       ),
//     );
//   }
// }

// /// Widget used to handle the management of
// class Uploader extends StatefulWidget {
//   final File file;

//   Uploader({required Key key, required this.file}) : super(key: key);

//   createState() => _UploaderState();
// }

// class _UploaderState extends State<Uploader> {
//   // final FirebaseStorage _storage =
//   //     FirebaseStorage(storageBucket: 'gs://fireship-lessons.appspot.com');

//   StorageUploadTask _uploadTask;

//   _startUpload() {
//     String filePath = 'images/${DateTime.now()}.png';

//     setState(() {
//       _uploadTask = ref().child(filePath).putFile(widget.file);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_uploadTask != null) {
//       return StreamBuilder(
//           stream: _uploadTask.events,
//           builder: (context, snapshot) {
//             var event = snapshot.data;

//             double progressPercent = event != null
//                 ? event.bytesTransferred / event.totalByteCount
//                 : 0;

//             return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   if (_uploadTask.isComplete)
//                     Text('🎉🎉🎉',
//                         style: TextStyle(
//                             color: Colors.greenAccent,
//                             height: 2,
//                             fontSize: 30)),
//                   if (_uploadTask.isPaused)
//                     FlatButton(
//                       child: Icon(Icons.play_arrow, size: 50),
//                       onPressed: _uploadTask.resume,
//                     ),
//                   if (_uploadTask.isInProgress)
//                     FlatButton(
//                       child: Icon(Icons.pause, size: 50),
//                       onPressed: _uploadTask.pause,
//                     ),

                    
//                   LinearProgressIndicator(value: progressPercent),
//                   Text(
//                     '${(progressPercent * 100).toStringAsFixed(2)} % ',
//                     style: TextStyle(fontSize: 50),
//                   ),
//                 ]);
//           });
//     } else {
//       return FlatButton.icon(
//           color: Colors.blue,
//           label: Text('Upload to Firebase'),
//           icon: Icon(Icons.cloud_upload),
//           onPressed: _startUpload);
//     }
//   }

//   ref() {}
// }