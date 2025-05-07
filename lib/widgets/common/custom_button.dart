import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  // 버튼 텍스트
  final String label;

  // 클릭 시 동작
  final VoidCallback onPressed;

  // 생성자
  const CustomButton({
    super.key, 
    required this.label, 
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: onPressed,

      // 입체감 추가, 패딩으로 크기 유지
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(12)),

      child: Text(label),
    );
  }
}
