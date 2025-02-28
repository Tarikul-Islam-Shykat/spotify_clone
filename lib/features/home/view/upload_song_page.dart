import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/widgets/custom_dotted_border.dart';
import 'package:spotify_clone/core/widgets/custom_textForm.dart';
import 'package:spotify_clone/core/widgets/loader.dart';
import 'package:spotify_clone/core/widgets/utils.dart';
import 'package:spotify_clone/features/home/viewmodel/home_vierwmodel.dart';
import 'package:spotify_clone/features/home/widget/audio_wave.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songNameController = TextEditingController();
  final artistController = TextEditingController();
  Color selectedColor = Colors.green;
  File? selectedImage;
  File? selectedAudio;
  final formKey = GlobalKey();

  void selectImage() async {
    final pickedImage = await pickImage(); // utils
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  void selecteAudio() async {
    final pickedAudio = await pickAudio(); // utils
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    songNameController.dispose();
    artistController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
        homeViewModelProvider.select((value) => value?.isLoading == true));
    return Scaffold(
      appBar: AppBar(
        title: const Text("File Upload"),
        actions: [
          IconButton(
              onPressed: () async {
                // if(formKey.currentState.va()){

                // }
                ref.read(homeViewModelProvider.notifier).uploadSong(
                    selectedThumbNail: selectedImage!,
                    selectedAudio: selectedAudio!,
                    songName: songNameController.text,
                    artistName: artistController.text,
                    selectedColor: selectedColor);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: isLoading == true
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: selectImage,
                        child: selectedImage == null
                            ? CustomDottedBorder(
                                color: Colors.grey,
                                strokeWidth: 2,
                                dashWidth: 8,
                                dashSpace: 4,
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      Text("Select The Thumbnail"),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      selectedAudio != null
                          ? AudioWave(path: selectedAudio!.path)
                          : AuthField(
                              onTap: () {
                                selecteAudio();
                              },
                              hintText: "Pick Song",
                              textEditingController: null,
                              readOnly: true,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      AuthField(
                        onTap: () {},
                        hintText: "Artist",
                        textEditingController: null,
                        readOnly: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AuthField(
                        onTap: () {},
                        hintText: "Song Name",
                        textEditingController: null,
                        readOnly: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ColorPicker(
                          heading: const Text("Select Color"),
                          pickersEnabled: const {ColorPickerType.wheel: true},
                          onColorChanged: (Color color) {
                            setState(() {
                              selectedColor = color;
                            });
                          })
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
