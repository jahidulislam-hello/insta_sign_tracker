// dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/dashboard_controller.dart';
import '../widget/admin_app_drawer_widget.dart';

class DashboardScreen extends GetView<DashboardController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, color: Colors.white, size: 28.sp),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome back!",style: TextStyle(
                fontWeight: FontWeight.w700,fontSize:24.sp,color: Colors.white
            ),),
            Text("Here's what's happening today.",style: TextStyle(
                fontWeight: FontWeight.w400,fontSize:13.sp,color: Colors.white70
            )),
          ],
        ),
        actions: [
          IconButton(onPressed:(){}, icon:Icon(Icons.notifications_none,color: Colors.white,size: 28.sp))
        ],
      ),
      drawer: AdminAppDrawerWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashboard Overview + Monthly Income (COMBINED)
            Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard Overview',
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MONTHLY NET INCOME',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black.withValues(alpha: 0.6),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Obx(
                                () => Text(
                              '\$${controller.monthlyIncome.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.trending_up,
                          color: Color(0xFFEF5350),
                          size: 30.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Four Stat Cards
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              children: [
                _StatCard(
                  icon: Icons.account_balance_wallet,
                  amount: '\$${controller.todayDeposit.value.toStringAsFixed(0)}',
                  label: "TODAY'S DEPOSIT",
                  color: Color(0xFF42A5F5),
                  bgColor: Color(0xFFE3F2FD),
                ),
                _StatCard(
                  icon: Icons.shopping_cart,
                  amount: '\$${controller.pendingOrders.value.toStringAsFixed(0)}',
                  label: 'PENDING ORDERS',
                  color: Color(0xFFAB47BC),
                  bgColor: Color(0xFFF3E5F5),
                ),
                _StatCard(
                  icon: Icons.receipt_long,
                  amount: '${controller.unpaidInvoices.value}',
                  label: 'UNPAID INVOICES',
                  color: Color(0xFFEF5350),
                  bgColor: Color(0xFFFFEBEE),
                ),
                _StatCard(
                  icon: Icons.inventory_2,
                  amount: '${controller.lowStock.value}',
                  label: 'LOW STOCK',
                  color: Color(0xFF66BB6A),
                  bgColor: Color(0xFFE8F5E9),
                ),
              ],
            ),

            SizedBox(height: 28.h),

            // Total Orders Chart Section - SCROLLABLE with initial scroll
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Orders',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF212121),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Last 12 Months Performance',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '3M',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // Scrollable Chart - Scroll to last month initially
                  _ScrollableChart(),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Order Distribution Pie Chart - DYNAMIC
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Distribution',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Dynamic Donut Chart
                      Obx(
                            () => Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 120.w,
                              height: 120.w,
                              child: _DonutChart(
                                activePercentage: controller.activePercentage.value,
                              ),
                            ),
                            Text(
                              '${controller.activeOrders.value}',
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Legend - SWAP ORDER
                      Obx(
                            () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Completed first (22% - Blue)
                            _LegendItem(
                              color: Color(0xFF42A5F5),
                              label: 'Completed',
                              value: controller.completedOrders.value,
                              percentage: controller.completedPercentage.value,
                            ),
                            SizedBox(height: 16.h),
                            // Active second (78% - Green)
                            _LegendItem(
                              color: Color(0xFF66BB6A),
                              label: 'Active',
                              value: controller.activeOrders.value,
                              percentage: controller.activePercentage.value,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Recent Activity
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Activity',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF212121),
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Color(0xFF1E88E5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _ActivityItem(
                  icon: Icons.person_add,
                  title: 'New Subscriber',
                  time: '2 minutes ago',
                  iconColor: Color(0xFF42A5F5),
                ),
                SizedBox(height: 12.h),
                _ActivityItem(
                  icon: Icons.inventory_2,
                  title: 'Inventory Restocked',
                  time: '1 hour ago',
                  iconColor: Color(0xFF66BB6A),
                ),
              ],
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

// Scrollable Chart Widget with auto-scroll to last month
class _ScrollableChart extends StatefulWidget {
  @override
  State<_ScrollableChart> createState() => _ScrollableChartState();
}

class _ScrollableChartState extends State<_ScrollableChart> {
  late ScrollController _scrollController;
  final DashboardController controller = Get.find();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Scroll to last month (DEC) after widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToLastMonth();
    });
  }

  void _scrollToLastMonth() {
    // Scroll to the last month (rightmost position)
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Obx(
            () => SizedBox(
          width: controller.chartData.length * 40.w,
          height: 180.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              controller.chartData.length,
                  (index) {
                final maxValue = controller.chartData.reduce((a, b) => a > b ? a : b);
                final height = (controller.chartData[index] / maxValue) * 130.h;
                final months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
                final isLastBar = index == controller.chartData.length - 1;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 24.w,
                      height: height,
                      decoration: BoxDecoration(
                        color: isLastBar ? Color(0xFF1E88E5) : Color(0xFFBBDEFB),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(4.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      months[index],
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Stat Card Widget
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String amount;
  final String label;
  final Color color;
  final Color bgColor;

  const _StatCard({
    required this.icon,
    required this.amount,
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha:0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: color, size: 22.sp),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Color(0xFF757575),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Dynamic Donut Chart Widget - IMPROVED LOOK
class _DonutChart extends StatelessWidget {
  final int activePercentage;

  const _DonutChart({required this.activePercentage});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DonutChartPainter(activePercentage: activePercentage),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final int activePercentage;

  _DonutChartPainter({required this.activePercentage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8.w;
    final strokeWidth = 20.w;

    final completedPercentage = 100 - activePercentage;

    // Background arc (light gray) - full circle
    final backgroundPaint = Paint()
      ..color = Color(0xFFE0E0E0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * 3.14159,
      false,
      backgroundPaint,
    );

    // Completed (22% - Blue color) - START FIRST
    final completedPaint = Paint()
      ..color = Color(0xFF42A5F5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final completedAngle = (completedPercentage * 360 / 100) * 3.14159 / 180;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * 3.14159 / 180,
      completedAngle,
      false,
      completedPaint,
    );

    // Active (78% - Green color) - AFTER COMPLETED
    final activePaint = Paint()
      ..color = Color(0xFF66BB6A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final activeStartAngle = (-90 + completedPercentage * 360 / 100) * 3.14159 / 180;
    final activeAngle = (activePercentage * 360 / 100) * 3.14159 / 180;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      activeStartAngle,
      activeAngle,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.activePercentage != activePercentage;
  }
}

// Legend Item Widget - UPDATED
class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final int value;
  final int percentage;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: Color(0xFF757575),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            '$value ($percentage%)',
            style: TextStyle(
              fontSize: 12.sp,
              color: Color(0xFF9E9E9E),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

// Activity Item Widget
class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final Color iconColor;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.time,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Color(0xFFEBEBEB),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha:0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(
            Icons.chevron_right,
            color: Color(0xFFBDBDBD),
            size: 24.sp,
          ),
        ],
      ),
    );
  }
}