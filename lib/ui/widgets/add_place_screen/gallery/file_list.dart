import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileList extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;

  const FileList({
    required this.files,
    required this.onOpenedFile,
    Key? key,
  }) : super(key: key);

  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Selected Files'),
      ),
      body: ListView.builder(
        itemCount: widget.files.length,
        itemBuilder: (context, index) {
          final file = widget.files[index];

          // ignore: avoid-returning-widgets
          return buildFile(file);
        },
      ),
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
            : const SizedBox(
                width: 80,
                height: 80,
              ),
        title: Text(file.name),
        subtitle: Text(file.extension.toString()),
        trailing: Text(
          size,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
