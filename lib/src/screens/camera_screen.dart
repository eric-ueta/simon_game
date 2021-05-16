import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'display_picture_screen.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  bool isSafe = false;
  //Future<void> _initializeControllerFuture;

  first() async {
    final cameras = await availableCameras();
    final camera = cameras[1];

    // _controller = CameraController(
    //   camera,
    //   ResolutionPreset.medium,
    // );

    _controller = CameraController(camera, ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        this.isSafe = true;
      });
    });

    //_initializeControllerFuture = _controller.initialize();
  }

  @override
  void initState() {
    super.initState();

    first();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   first();
  // }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //if (!_controller.value.isInitialized) {
    if (!isSafe) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Tirar foto'),
      ),
      backgroundColor: Colors.black,
      body: CameraPreview(_controller),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            final image = await _controller.takePicture();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image?.path,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
