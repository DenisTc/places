import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileList extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const FileList({Key? key, required this.files, required this.onOpenedFile})
      : super(key: key);

  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Selected Files'),
      ),
      body: ListView.builder(
          itemCount: widget.files.length,
          itemBuilder: (context, index) {
            final file = widget.files[index];

            return buildFile(file);
          }),
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    return InkWell(
      onTap: () => widget.onOpenedFile(file),
      child: ListTile(
        leading: (file.extension == 'jpg' || file.extension == 'png')
            ? Image.file(
                File(file.path.toString()),
                width: 80,
                height: 80,
              )
            : Container(
                width: 80,
                height: 80,
              ),
        title: Text('${file.name}'),
        subtitle: Text('${file.extension}'),
        trailing: Text(
          '$size',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}