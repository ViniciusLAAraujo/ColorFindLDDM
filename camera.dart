import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:color_find/home.dart';

class Page2 extends StatefulWidget{
  final List<CameraDescription>? cameras;

  const Page2({this.cameras, Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late CameraController controller;
  XFile? pictureFile;

  @override
  void initState(){
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_){
      if(!mounted){
        return;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading:false,
        title: Text(
          "ColorFind",
          style: TextStyle(
            color: Theme
                .of(context)
                .primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: 400,
                width: 400,
                child: CameraPreview(controller),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                pictureFile = await controller.takePicture();
                setState(() {});
              },
              child: const Text('Capture Image'),
            ),
          ),
          if(pictureFile != null)
            Image.network(
              pictureFile!.path,
              height: 250,
              width: 250,
            )
          //Android/IOS == Image.file(File(pictureFile!.path))

        ],
      ),

      );
  }
}











