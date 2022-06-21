// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:book_library_flutter/models/book.dart';
import 'package:book_library_flutter/providers/api.dart';

class EditScreen extends StatefulWidget {
  EditScreen({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final ImagePicker picker = ImagePicker();

  XFile? image1;
  XFile? image2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text(
              'Image1',
              style: Theme.of(context).textTheme.headline6,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: image1 == null
                        ? Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
                            fit: BoxFit.contain,
                            width: 200,
                          )
                        : Image.file(
                            File(image1!.path),
                            fit: BoxFit.contain,
                            // height: 200,
                            width: 200,
                          ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      image1 =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {});
                      context.read<Api>().updateImage1(widget.book.id, image1!);
                    },
                    child: const Icon(
                      Icons.camera,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
            // const Spacer(),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Image2',
              style: Theme.of(context).textTheme.headline6,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: image2 == null
                        ? Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
                            fit: BoxFit.contain,
                            width: 200,
                          )
                        : Image.file(
                            File(image2!.path),
                            fit: BoxFit.contain,
                            // height: 200,
                            width: 200,
                          ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      image2 =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {});
                      context.read<Api>().updateImage2(widget.book.id, image2!);
                    },
                    child: const Icon(
                      Icons.camera,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
