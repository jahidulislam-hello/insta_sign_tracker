
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/app_colors.dart';




// ---------------------------------------------------------------------------
// PAGE
// ---------------------------------------------------------------------------
class CompanyInformationPage extends StatelessWidget {
  const CompanyInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _PageHeader(),
                  const SizedBox(height: 24),
                  const _SectionTitle('Company Information'),
                  const SizedBox(height: 12),
                  const _CompanyInformationCard(),
                  const SizedBox(height: 28),
                  const _SectionTitle('Company Account Owner Information'),
                  const SizedBox(height: 12),
                  const _CompanyOwnerCard(),
                  const SizedBox(height: 8),
                  const Divider(color: AppColors.divider, height: 40, thickness: 1),
                  const _SectionTitle('Subscription'),
                  const SizedBox(height: 12),
                  const _SubscriptionCard(),
                  const SizedBox(height: 28),
                  const _SectionTitle('View Available Plan'),
                  const SizedBox(height: 12),
                  const _AvailablePlansSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// HEADER
// ---------------------------------------------------------------------------
class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Company Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.heading,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Manage your subscription and account settings',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.subtitle,
          ),
        ),
        const SizedBox(height: 16),
        const Divider(color: AppColors.divider, height: 1, thickness: 1),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.heading,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SHARED CARD CONTAINER
// ---------------------------------------------------------------------------
class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const _Card({required this.child, this.padding = const EdgeInsets.all(20)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
// LABELED INPUT FIELD
// ---------------------------------------------------------------------------
class _LabeledField extends StatelessWidget {
  final String label;
  final String hint;
  const _LabeledField({required this.label, this.hint = 'Type here...'});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: AppColors.label,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: const TextStyle(
                      color: AppColors.placeholder,
                      fontSize: 13,
                    ),
                  ),
                  style: const TextStyle(fontSize: 13, color: AppColors.heading),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// A responsive row of two labeled fields that stacks on narrow widths.
class _TwoFieldRow extends StatelessWidget {
  final _LabeledField left;
  final _LabeledField right;
  const _TwoFieldRow({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 480;
        if (isNarrow) {
          return Column(
            children: [
              left,
              const SizedBox(height: 16),
              right,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: left),
            const SizedBox(width: 24),
            Expanded(child: right),
          ],
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// COMPANY INFORMATION CARD
// ---------------------------------------------------------------------------
class _CompanyInformationCard extends StatelessWidget {
  const _CompanyInformationCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Brand Logo',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.label,
            ),
          ),
          const SizedBox(height: 8),
          const _UploadBox(),
          const SizedBox(height: 20),
          const _TwoFieldRow(
            left: _LabeledField(label: 'Name'),
            right: _LabeledField(label: 'Email'),
          ),
          const SizedBox(height: 16),
          const _TwoFieldRow(
            left: _LabeledField(label: 'Phone'),
            right: _LabeledField(label: 'Address'),
          ),
        ],
      ),
    );
  }
}

class _UploadBox extends StatelessWidget {
  const _UploadBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.inputBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: AppColors.inputBorder,
          radius: 8,
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.upload_outlined, size: 18, color: AppColors.placeholder),
              SizedBox(height: 4),
              Text(
                'Upload',
                style: TextStyle(fontSize: 11, color: AppColors.placeholder),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0.6, 0.6, size.width - 1.2, size.height - 1.2),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final dashPath = _dashPath(path, dashArray: const [4, 3]);
    canvas.drawPath(dashPath, paint);
  }

  Path _dashPath(Path source, {required List<double> dashArray}) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      bool draw = true;
      int i = 0;
      while (distance < metric.length) {
        final len = dashArray[i % dashArray.length];
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
        i++;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// COMPANY OWNER CARD
// ---------------------------------------------------------------------------
class _CompanyOwnerCard extends StatelessWidget {
  const _CompanyOwnerCard();

  @override
  Widget build(BuildContext context) {
    return const _Card(
      child: _TwoFieldRow(
        left: _LabeledField(label: 'Name'),
        right: _LabeledField(label: 'Email'),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SUBSCRIPTION CARD
// ---------------------------------------------------------------------------
class _SubscriptionCard extends StatelessWidget {
  const _SubscriptionCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Insta Gold',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.heading,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.activeGreenBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.activeGreenText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 420;
            final dates = [
              const _DateBlock(label: 'Start date :', day: '08', month: '10', year: '2025'),
              const _DateBlock(label: 'Renewal date :', day: '08', month: '10', year: '2025'),
            ];
            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dates[0],
                  const SizedBox(height: 12),
                  dates[1],
                ],
              );
            }
            return Row(
              children: [
                dates[0],
                const SizedBox(width: 64),
                dates[1],
              ],
            );
          }),
          const SizedBox(height: 20),
          LayoutBuilder(builder: (context, constraints) {
            return Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.inputBg,
                      foregroundColor: AppColors.link,
                      side: const BorderSide(color: AppColors.inputBorder),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Renew Now',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _DateBlock extends StatelessWidget {
  final String label;
  final String day;
  final String month;
  final String year;
  const _DateBlock({
    required this.label,
    required this.day,
    required this.month,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.label,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(day,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dateText)),
            const Text(' | ',
                style: TextStyle(fontSize: 13, color: AppColors.placeholder)),
            Text(month,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.link)),
            const Text(' | ',
                style: TextStyle(fontSize: 13, color: AppColors.placeholder)),
            Text(year,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.dateText)),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// AVAILABLE PLANS
// ---------------------------------------------------------------------------
class _AvailablePlansSection extends StatelessWidget {
  const _AvailablePlansSection();

  static const features = [
    '7000 AI credits/month for creating images',
    '5000 AI credits/month for creating images',
    '7000 AI credits/month for creating images',
    '7000 AI credits/month for creating images',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 700;
        final cards = List.generate(
          3,
              (i) => const _PlanCard(
            title: 'Basic',
            price: '\$6.00',
            features: features,
          ),
        );

        if (isNarrow) {
          return Column(
            children: [
              for (int i = 0; i < cards.length; i++) ...[
                cards[i],
                if (i != cards.length - 1) const SizedBox(height: 16),
              ]
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: cards[0]),
            const SizedBox(width: 16),
            Expanded(child: cards[1]),
            const SizedBox(width: 16),
            Expanded(child: cards[2]),
          ],
        );
      },
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  const _PlanCard({
    required this.title,
    required this.price,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: AppColors.heading,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'AI Suite With:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.label,
            ),
          ),
          const SizedBox(height: 10),
          for (final f in features) ...[
            _FeatureRow(text: f),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 6),
          const Divider(color: AppColors.divider, height: 1, thickness: 1),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.heading,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 3, left: 2),
                child: Text(
                  '/month',
                  style: TextStyle(fontSize: 12, color: AppColors.subtitle),
                ),
              ),
            ],
          ),
          const Text(
            'Billed monthly',
            style: TextStyle(fontSize: 11.5, color: AppColors.subtitle),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Get Basic',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String text;
  const _FeatureRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.check, size: 14, color: AppColors.checkGreen),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: AppColors.featureText, height: 1.3),
          ),
        ),
      ],
    );
  }
}