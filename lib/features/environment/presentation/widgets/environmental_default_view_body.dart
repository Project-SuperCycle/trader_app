import 'package:flutter/material.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/core/helpers/custom_back_button.dart';
import 'package:trader_app/core/utils/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class EnvironmentalDefaultViewBody extends StatelessWidget {
  const EnvironmentalDefaultViewBody({super.key});

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+201234567890');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse('https://wa.me/201234567890');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header Section
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: kGradientContainer,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(50),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.eco,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'trader_app',
                                    style: AppStyles.styleBold24(
                                      context,
                                    ).copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'نحو مستقبل أخضر مستدام',
                                    style: AppStyles.styleMedium14(
                                      context,
                                    ).copyWith(color: Color(0xFFD1FAE5)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CustomBackButton(color: Colors.white, size: 25),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Stats Container
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _StatCard(
                                icon: Icons.recycling,
                                value: '100%',
                                label: 'التزامنا بالتدوير',
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _StatCard(
                                icon: Icons.forest,
                                value: '∞',
                                label: 'هدفنا للبيئة',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  // Mission Section
                  _SectionCard(
                    icon: Icons.description_outlined,
                    title: 'ما نقدمه',
                    content:
                        'نختص بإعادة تدوير الورق، الكرتون، وجميع أنواع الدشت. نحول المخلفات الورقية إلى موارد قيمة.',
                    gradient: LinearGradient(
                      colors: [Color(0xFF10B981).withAlpha(25), Colors.white],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Impact Section
                  _SectionCard(
                    icon: Icons.eco_outlined,
                    title: 'أثرنا البيئي',
                    content:
                        'كل كيلو ورق أو كرتون يتم تدويره يساهم في إنقاذ الأشجار وتقليل استهلاك الطاقة والمياه.',
                    gradient: LinearGradient(
                      colors: [Color(0xFF059669).withAlpha(25), Colors.white],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Impact Stats Grid
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF10B981).withAlpha(15),
                          Color(0xFF059669).withAlpha(15),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Color(0xFF10B981).withAlpha(50),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'فوائد تدوير الورق',
                          style: AppStyles.styleBold20(
                            context,
                          ).copyWith(color: Color(0xFF047857)),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _ImpactItem(
                                icon: Icons.park,
                                value: '17',
                                label: 'شجرة لكل طن',
                              ),
                            ),
                            Expanded(
                              child: _ImpactItem(
                                icon: Icons.water_drop,
                                value: '50%',
                                label: 'توفير مياه',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _ImpactItem(
                                icon: Icons.bolt,
                                value: '65%',
                                label: 'توفير طاقة',
                              ),
                            ),
                            Expanded(
                              child: _ImpactItem(
                                icon: Icons.delete_outline,
                                value: '90%',
                                label: 'تقليل نفايات',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Contact Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: kGradientContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.contact_support_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'تواصل معنا',
                          style: AppStyles.styleBold20(
                            context,
                          ).copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'نحن هنا للإجابة على استفساراتك',
                          style: AppStyles.styleMedium14(
                            context,
                          ).copyWith(color: Color(0xFFD1FAE5)),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _ContactButton(
                                icon: Icons.phone,
                                label: 'اتصل بنا',
                                onTap: _launchPhone,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _ContactButton(
                                icon: Icons.chat,
                                label: 'واتساب',
                                onTap: _launchWhatsApp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppStyles.styleBold24(context).copyWith(color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppStyles.styleSemiBold12(
            context,
          ).copyWith(color: Color(0xFFD1FAE5)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final Gradient gradient;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF10B981).withAlpha(50), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF10B981).withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Color(0xFF047857), size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: AppStyles.styleBold18(
                  context,
                ).copyWith(color: Color(0xFF047857)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: AppStyles.styleMedium14(
              context,
            ).copyWith(color: Color(0xFF064E3B), height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _ImpactItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _ImpactItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Color(0xFF047857), size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppStyles.styleBold20(
            context,
          ).copyWith(color: Color(0xFF047857)),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppStyles.styleMedium12(
            context,
          ).copyWith(color: Color(0xFF059669)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(40),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withAlpha(80), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppStyles.styleSemiBold14(
                context,
              ).copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
