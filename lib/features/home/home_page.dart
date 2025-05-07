import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../widgets/base_scaffold.dart';
import '../../widgets/common/info_card.dart';
import '../../widgets/common/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    // provider 변수 설정
    final username = context.watch<AppState>().username;

    return BaseScaffold(

      title: '홈',

      currentIndex: 0,

      // 화면 내 컨텐츠
      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              '안녕하세요, $username 님 👋',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 20),

            const InfoCard(
              title: '오늘의 공지사항',
              content: '앱의 새로운 기능이 추가되었습니다! 설정에서 확인해보세요.',
            ),

            const SizedBox(height: 20),
            
            CustomButton(

              label: '다크모드 전환',

              onPressed: () {
                context.read<AppState>().toggleDarkMode();
              },
            ),
          ],
        ),
      ),
    );
  }
}
