import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {

  // 카드 제목
  final String title;

  // 카드 내용
  final String content;

  // 생성자
  const InfoCard({
    super.key, 
    required this.title, 
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      margin: const EdgeInsets.all(8),

      child: Padding(
        
        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 8),
            
            Text(content),
          ],
        ),
      ),
    );
  }
}
