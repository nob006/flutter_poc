import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/preview.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;

  const CameraPage({@required this.camera});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _cameraController;
  Future<void> _initializeControllerFuture;
  List cameras;

  @override
  void initState() {
    super.initState();

    availableCameras().then((availableCameras) {

      cameras = availableCameras;
      if (cameras.length > 0) {
        _cameraController =
            CameraController(cameras[0], ResolutionPreset.medium);
        _initializeControllerFuture = _cameraController.initialize();
        print("camera available");
        setState(() {
          // just update state view
        });
      }else{
        print("No camera available");
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });

    // _cameraController =
    //     CameraController(widget.camera, ResolutionPreset.medium);
    // _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_cameraController);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.camera_alt), onPressed: () async {
        try {
          // Ensure that the camera is initialized.
          await _initializeControllerFuture;

          // Construct the path where the image should be saved using the path
          // package.
          final path = join(
            // Store the picture in the temp directory.
            // Find the temp directory using the `path_provider` plugin.
            (await getTemporaryDirectory()).path,
            '${DateTime.now()}.png',
          );

          // Attempt to take a picture and log where it's been saved.
          await _cameraController.takePicture(path);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreviewPage(imagePart: path,),
            ),
          );

        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }

      }),
    );
  }
}
