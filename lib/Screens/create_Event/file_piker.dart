// import 'dart:html';
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class FilePickerApp extends StatefulWidget {
//   @override
//   FilePickerAppState createState() => new FilePickerAppState();
// }

// class FilePickerAppState extends State<FilePickerApp> {
//   late String fileName;
//   late String path;
//   late Map<String, String> paths;
//   late List<String> extensions;
//   bool isLoadingPath = false;
//   bool isMultiPick = false;
//   late FileType fileType;

//   void _openFileExplorer() async {
//     setState(() => isLoadingPath = true);
//     try {
//       if (isMultiPick) {
//         path = "";
//         paths = await FilePicker.getMultiFilePath(type: fileType? fileType: FileType.any, allowedExtensions: extensions);
//       }
//       else {
//         path = (await FilePicker.getFile(type: fileType? fileType: FileType.any, allowedExtensions: extensions)) as String;
//         // paths = "";
//       }
//     }
//     on PlatformException catch (e) {
//       print("Unsupported operation" + e.toString());
//     }
//     if (!mounted) return;
//     setState(() {
//       isLoadingPath = false;
//       fileName = path != null ? path.split('/').last : paths != null
//             ? paths.keys.toString() : '...';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         appBar: new AppBar(
//           title: const Text('File Picker example app'),
//         ),
//         body: new Center(
//             child: new Padding(
//           padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//           child: new SingleChildScrollView(
//             child: new Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 new Padding(
//                   padding: const EdgeInsets.only(top: 20.0),
//                   child: new DropdownButton(
//                       hint: new Text('Select file type'),
//                       value: fileType,
//                       items: <DropdownMenuItem>[
//                         new DropdownMenuItem(
//                           child: new Text('Audio'),
//                           value: FileType.audio,
//                         ),
//                         new DropdownMenuItem(
//                           child: new Text('Image'),
//                           value: FileType.image,
//                         ),
//                         new DropdownMenuItem(
//                           child: new Text('Video'),
//                           value: FileType.video,
//                         ),
//                         new DropdownMenuItem(
//                           child: new Text('Any'),
//                           value: FileType.any,
//                         ),
//                       ],
//                       onChanged: (value) => setState(() {
//                           fileType = value;
//                       })
//                    ),
//                 ),
//                 new ConstrainedBox(
//                   constraints: BoxConstraints.tightFor(width: 200.0),
//                   child: new SwitchListTile.adaptive(
//                     title: new Text('Pick multiple files', textAlign: TextAlign.right),
//                     onChanged: (bool value) => setState(() => isMultiPick = value),
//                     value: isMultiPick,
//                   ),
//                 ),
//                 new Padding(
//                   padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
//                   child: new RaisedButton(
//                     onPressed: () => _openFileExplorer(),
//                     child: new Text("Open file picker"),
//                   ),
//                 ),
//                 new Builder(
//                   builder: (BuildContext context) => isLoadingPath ? Padding(
//                       padding: const EdgeInsets.only(bottom: 10.0),
//                       child: const CircularProgressIndicator()
//                     )
//                     : path != null || paths != null ? new Container(
//                         padding: const EdgeInsets.only(bottom: 30.0),
//                         height: MediaQuery.of(context).size.height * 0.50,
//                         child: new Scrollbar(
//                             child: new ListView.separated(
//                           itemCount: paths != null && paths.isNotEmpty ? paths.length : 1,
//                           itemBuilder: (BuildContext context, int index) {
//                             final bool isMultiPath = paths != null && paths.isNotEmpty;
//                             final int fileNo = index + 1;
//                             final String name = 'File $fileNo : ' +
//                                 (isMultiPath ? paths.keys.toList()[index] : fileName ?? '...');
//                             final filePath = isMultiPath
//                                 ? paths.values.toList()[index].toString() : path;
//                             return new ListTile(title: new Text(name,),
//                               subtitle: new Text(filePath),
//                             );
//                           },
//                           separatorBuilder: (BuildContext context, int index) => new Divider(),
//                         )),
//                       )
//                     : new Container(),
//                 ),
//               ],
//             ),
//           ),
//         )),
//       ),
//     );
//   }
// }
