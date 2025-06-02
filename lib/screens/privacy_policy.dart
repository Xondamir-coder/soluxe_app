import 'package:flutter/material.dart';
import 'package:soluxe/constants/colors.dart';
import 'package:soluxe/models/policy.dart';
import 'package:soluxe/widgets/appbars/default_appbar.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final policies = [
  // Section 1
  Policy(
    titleEn: 'Information We Collect',
    textEn: '''
- Location Data: To show nearby restaurants, hotels, and attractions.
- Device Info: Device model, OS version, and settings for performance optimization.
- Usage Data: App interactions and feature usage for analytics and improvement.
- Account Info: Email, password (encrypted), and optional profile details during sign-up.
''',
    titleZh: '我们收集的信息',
    textZh: '''
- 位置数据：用于显示附近的餐厅、酒店和景点。
- 设备信息：设备型号、操作系统版本和设置，用于优化性能。
- 使用数据：应用交互和功能使用情况，用于分析和改进。
- 账户信息：注册时提供的电子邮件、加密密码以及可选的个人资料信息。
''',
  ),

  // Section 2
  Policy(
    titleEn: 'How We Use Your Data',
    textEn: '''
- To show personalized suggestions based on your location.
- To improve app functionality and user experience.
- For customer support and communication.
- To comply with legal obligations.
''',
    titleZh: '我们如何使用您的数据',
    textZh: '''
- 根据您的位置显示个性化建议。
- 改进应用功能和用户体验。
- 用于客户支持和沟通。
- 遵守法律法规。
''',
  ),

  // Section 3
  Policy(
    titleEn: 'Data Sharing',
    textEn: '''
We do not sell or rent your personal data. We may share data with:
- Map services (e.g., Google Maps, Huawei Maps)
- Analytics providers (e.g., Firebase, HMS Analytics)
- Cloud storage platforms for secure data hosting
''',
    titleZh: '数据共享',
    textZh: '''
我们不会出售或出租您的个人数据。我们可能与以下服务共享数据：
- 地图服务（如 Google 地图、华为地图）
- 分析服务（如 Firebase、HMS Analytics）
- 云存储平台用于安全数据托管
''',
  ),

  // Section 4
  Policy(
    titleEn: 'Data Retention',
    textEn: '''
We keep your data only as long as needed to provide services or comply with the law. You can request deletion at any time.
''',
    titleZh: '数据保留',
    textZh: '''
我们仅在提供服务或遵守法律所需的期限内保留您的数据。您可以随时请求删除。
''',
  ),

  // Section 5
  Policy(
    titleEn: 'Your Rights',
    textEn: '''
You have the right to:
- Access, correct, or delete your data
- Withdraw your consent at any time
- File a complaint with a data protection authority
''',
    titleZh: '您的权利',
    textZh: '''
您有权：
- 访问、修改或删除您的数据
- 随时撤回您的同意
- 向数据保护机构提出投诉
''',
  ),

  // Section 6
  Policy(
    titleEn: 'Security',
    textEn: '''
We use industry-standard measures to protect your information. However, no method is 100% secure.
''',
    titleZh: '安全性',
    textZh: '''
我们使用行业标准措施来保护您的信息。但没有任何方法能保证 100% 安全。
''',
  ),
];

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: DefaultAppbar(title: AppLocalizations.of(context)!.privacyPolicy),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.adaptiveDarkBlueOrWhite(isDark),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < policies.length; i++)
                    Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.deepBlue(
                          '${i + 1}. ${AppLocalizations.of(context)!.localeName == 'en' ? policies[i].titleEn : policies[i].titleZh}',
                          fontSize: 16,
                        ),
                        MyText(
                          AppLocalizations.of(context)!.localeName == 'en'
                              ? policies[i].textEn
                              : policies[i].textZh,
                          color: AppColors.adaptiveGreyOrDarkGrey(isDark),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
