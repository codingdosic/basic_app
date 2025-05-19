import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/customMarker.dart';

class EditItemDialog extends StatefulWidget {
  final String mode;
  final bool isNew;
  final LatLng? position;
  final List<CustomMarker>? selectedMarkers;
  final String? initialTitle;
  final String? initialDescription;

  const EditItemDialog({
    super.key,
    required this.mode,
    required this.isNew,
    this.position,
    this.selectedMarkers,
    this.initialTitle,
    this.initialDescription,
  });

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
  
}

class _EditItemDialogState extends State<EditItemDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _snippetController;
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _snippetController = TextEditingController(text: widget.initialDescription ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _snippetController.dispose();
    super.dispose();
  }
  
  Future<void> _pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final bytes = await File(image.path).readAsBytes();
    final base64Image = base64Encode(bytes);

    setState(() {
      _base64Image = base64Image;
    });
  }
}


  void _save() {
    if (_formKey.currentState!.validate()) {
      // 저장 로직을 여기서 실행하거나 Navigator.pop으로 데이터 전달 가능
      Navigator.of(context).pop({
        'title': _titleController.text,
        'snippet': _snippetController.text,
        'image': _base64Image,
        'position': widget.position,
        'markers': widget.selectedMarkers,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMarker = widget.mode == 'marker';

    return AlertDialog(
      title: Text(widget.isNew
          ? (isMarker ? '마커 추가' : '여행기 추가')
          : (isMarker ? '마커 수정' : '여행기 수정')),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ 이미지 선택
              GestureDetector(
                onTap: _pickImage,
                child: _base64Image != null
                    ? Image.memory(base64Decode(_base64Image!), height: 120)
                    : Container(
                        color: Colors.grey[200],
                        height: 120,
                        child: const Center(child: Text("이미지 선택")),
                      ),
              ),
              const SizedBox(height: 12),

              // ✅ 제목 입력
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: '제목'),
                validator: (value) => value == null || value.isEmpty ? '제목을 입력하세요' : null,
              ),
              const SizedBox(height: 12),

              // ✅ 설명 입력
              TextFormField(
                controller: _snippetController,
                decoration: const InputDecoration(labelText: '설명'),
                validator: (value) => value == null || value.isEmpty ? '설명을 입력하세요' : null,
              ),

              if (!isMarker && widget.selectedMarkers != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text("총 ${widget.selectedMarkers!.length}개의 마커 포함"),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("취소"),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text("저장"),
        ),
      ],
    );
  }
}
