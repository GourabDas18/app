import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gourab_das_internship_app/main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widget_mask/widget_mask.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
late CroppedFile croppedFile;
bool imageCropped  = false;
bool maskOn  = false;
String maskType  = "";
bool imageCroppedandSet = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
    appBar: AppBar(centerTitle: true, title: const Text("Add Image / Icon",),leading:const Icon(Icons.arrow_back)),
    body: Container(
      color:Color.fromARGB(255, 241, 241, 241),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 1,color: Colors.grey)),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height*0.11,
                        width: MediaQuery.of(context).size.width*0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 10),
                            const Text("Upload Image"),
                            const SizedBox(height: 10),
                            ElevatedButton(child: const Text("Choose from Device"),onPressed: () { 
                              ImagePicker().pickImage(source: ImageSource.gallery).then((value){  
                              ImageCropper().cropImage(
                                sourcePath: value!.path,
                                compressQuality: 100,
                                uiSettings: [AndroidUiSettings(
                                  toolbarTitle: "Crop",
                                  backgroundColor: const Color.fromARGB(255, 34, 34, 34),
                                  toolbarColor: Colors.black,
                                  toolbarWidgetColor:const Color.fromARGB(255, 228, 225, 225),
                                  cropFrameColor: Colors.grey,
                                  initAspectRatio: CropAspectRatioPreset.original,
                                  lockAspectRatio : false,
                                )]
                                ).then((value){
                                setState(() {
                                   croppedFile = value!;
                                   imageCropped = true;
                                });
                              });
                              }) ;
                            },),
                           
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
          imageCroppedandSet ? Container(
            color: Colors.transparent,
            child: Padding(padding: EdgeInsets.all(20),child: maskOn ? WidgetMask(
                      blendMode: BlendMode.srcATop,
                      childSaveLayer: true,
                      mask: Image(image: FileImage(File(croppedFile.path)),fit: BoxFit.cover,), child: Image.asset(maskType,width: MediaQuery.of(context).size.width*0.95)) : Image(image: FileImage(File(croppedFile.path)),height: MediaQuery.of(context).size.height*0.22),),
          ) : Container(),
              
            ],
          ),
    
          imageCropped ? Positioned(
            child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,color: const Color.fromARGB(131, 0, 0, 0),
            child:  Center(
              child: Container(
                height: MediaQuery.of(context).size.height*0.54,
                width: MediaQuery.of(context).size.width*0.9,
                decoration: const BoxDecoration(color: Color.fromARGB(255, 242, 233, 233),boxShadow:[BoxShadow(
                        color: Color.fromARGB(255, 71, 70, 70),
                        offset: Offset(1, 5),
                        spreadRadius: 1,
                        blurRadius: 5
                      )]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Row(mainAxisAlignment: MainAxisAlignment.end, children: [Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.cancel,color: Color.fromARGB(255, 72, 72, 72),size: 25,),
                  )],),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text("Uploaded Image",style: TextStyle(fontSize: 18),),
                  ),
                  // Preview Image ---------------------->>
                  maskOn ? WidgetMask(
                    blendMode: BlendMode.srcATop,
                      childSaveLayer: true,
                    mask: Image(image: FileImage(File(croppedFile.path)),fit: BoxFit.cover,), child: Image.asset(maskType,height: MediaQuery.of(context).size.height*0.22)) : Image(image: FileImage(File(croppedFile.path)),height: MediaQuery.of(context).size.height*0.22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Image masking buttons ---------------->>
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            maskType = "";
                            maskOn = false;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height:MediaQuery.of(context).size.width*0.12, width:MediaQuery.of(context).size.width*0.2,decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow:const [BoxShadow(
                          color: Color.fromARGB(255, 193, 192, 192),
                          offset: Offset(1, 5),
                          spreadRadius: 1,
                          blurRadius: 5
                        )]),child: const Text("Original"),),
                      )
                      ,
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            maskType = "assets/user_image_frame_1.png";
                            maskOn = true;
                          });
                        },
                        child: Container( decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow:const [BoxShadow(
                          color: Color.fromARGB(255, 193, 192, 192),
                          offset: Offset(1, 5),
                          spreadRadius: 1,
                          blurRadius: 5
                        )]),height:MediaQuery.of(context).size.width*0.12, width:MediaQuery.of(context).size.width*0.13, child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/user_image_frame_1.png",fit:BoxFit.fitWidth),
                        ),),
                      )
                      ,GestureDetector(
                        onTap: () {
                          setState(() {
                            maskType = "assets/user_image_frame_2.png";
                            maskOn = true;
                          });
                        },
                        child: Container( decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow:const [BoxShadow(
                          color: Color.fromARGB(255, 193, 192, 192),
                          offset: Offset(1, 5),
                          spreadRadius: 1,
                          blurRadius: 5
                        )]),height:MediaQuery.of(context).size.width*0.12, width:MediaQuery.of(context).size.width*0.13, child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/user_image_frame_2.png",fit:BoxFit.fitWidth),
                        ),),
                      )
                      ,GestureDetector(
                        onTap: () {
                          setState(() {
                            maskType = "assets/user_image_frame_3.png";
                            maskOn = true;
                          });
                        },
                        child: Container( decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow:const [BoxShadow(
                          color: Color.fromARGB(255, 193, 192, 192),
                          offset: Offset(1, 5),
                          spreadRadius: 1,
                          blurRadius: 5
                        )]),height:MediaQuery.of(context).size.width*0.12, width:MediaQuery.of(context).size.width*0.13, child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/user_image_frame_3.png",fit:BoxFit.fitWidth),
                        ),),
                      )
                      ,GestureDetector(
                        onTap: () {
                          setState(() {
                            maskType = "assets/user_image_frame_4.png";
                            maskOn = true;
                          });
                        },
                        child: Container( decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),color: Colors.white,borderRadius: BorderRadius.circular(15),boxShadow:const [BoxShadow(
                          color: Color.fromARGB(255, 193, 192, 192),
                          offset: Offset(1, 5),
                          spreadRadius: 1,
                          blurRadius: 5
                        )]) ,height:MediaQuery.of(context).size.width*0.12, width:MediaQuery.of(context).size.width*0.13, child:Padding(
                          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.01),
                          child: Image.asset("assets/user_image_frame_4.png",fit:BoxFit.fitWidth),
                        ),),
                      )
                    
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        imageCroppedandSet = true;
                        imageCropped = false;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.06,
                      width: MediaQuery.of(context).size.width*0.7,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 12, 163, 128),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow:const [BoxShadow(
                          color: Color.fromARGB(255, 193, 192, 192),
                          offset: Offset(1, 5),
                          spreadRadius: 1,
                          blurRadius: 5
                        )]),
                      child: const Text("Use This Image",style: TextStyle(color: Colors.white),),
                    ),
                  )
                ],
                ),
              ),
            ),
            )
            ):Container()
          , 
          
          
        ],
      ),
    )));
  }
}