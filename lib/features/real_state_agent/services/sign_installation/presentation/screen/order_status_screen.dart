import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/review_order_status.dart';

class OrderStatusScreen extends GetView<ReviewOrderStatus> {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Order Status'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        // ✅ Filter icon remove করা হয়েছে
      ),
      body: Column(
        children: [
          // ===== Search Bar =====
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: controller.searchController,
                onChanged: (value) {
                  controller.updateSearch(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.h,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ),

          // ===== Tab Bar - ✅ Scrollable এবং Bigger Size =====
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: TabBar(
              controller: controller.tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              indicator: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true, // ✅ Scrollable করা হয়েছে
              labelStyle: TextStyle(
                fontSize: 14.h, // ✅ Size বড় করা হয়েছে
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.h, // ✅ Size বড় করা হয়েছে
                fontWeight: FontWeight.w500,
              ),
              labelPadding: EdgeInsets.symmetric(
                horizontal: 16.w, // ✅ Tab এর padding বড় করা
                vertical: 0,
              ),
              tabs: [
                Tab(
                  text: 'Pending',
                  height: 50.h, // ✅ Tab height বড় করা
                ),
                Tab(
                  text: 'Assigned',
                  height: 50.h,
                ),
                Tab(
                  text: 'In Progress',
                  height: 50.h,
                ),
                Tab(
                  text: 'Completed',
                  height: 50.h,
                ),
                Tab(
                  text: 'Cancelled',
                  height: 50.h,
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // ===== Orders List =====
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                // Pending Tab
                _buildOrdersList(
                  controller.pendingOrders,
                  'Pending',
                  context,
                ),
                // Assigned Tab
                _buildOrdersList(
                  controller.assignedOrders,
                  'Assigned',
                  context,
                ),
                // In Progress Tab
                _buildOrdersList(
                  controller.inProgressOrders,
                  'In Progress',
                  context,
                ),
                // Completed Tab
                _buildOrdersList(
                  controller.completedOrders,
                  'Completed',
                  context,
                ),
                // Cancelled Tab
                _buildOrdersList(
                  controller.cancelledOrders,
                  'Cancelled',
                  context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build orders list for each tab
  Widget _buildOrdersList(
      RxList<OrderModel> orders,
      String tabName,
      BuildContext context,
      ) {
    return Obx(
          () => orders.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 60,
              color: Colors.grey[300],
            ),
            SizedBox(height: 16.h),
            Text(
              'No $tabName Orders',
              style: TextStyle(
                fontSize: 16.h,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _buildOrderCard(order, tabName);
        },
      ),
    );
  }

  // Build individual order card
  Widget _buildOrderCard(OrderModel order, String tabName) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header - Agent name and status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      order.agentName,
                      style: TextStyle(
                        fontSize: 14.h,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    tabName,
                    style: TextStyle(
                      fontSize: 11.h,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // Location
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Colors.grey[600],
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    order.location,
                    style: TextStyle(
                      fontSize: 13.h,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                if (order.isPriority)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      order.status,
                      style: TextStyle(
                        fontSize: 10.h,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 8.h),

            // Due date
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Colors.grey[600],
                ),
                SizedBox(width: 6.w),
                Text(
                  'Due : ${order.dueDate}',
                  style: TextStyle(
                    fontSize: 13.h,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            Divider(
              height: 1,
              color: Colors.grey[200],
            ),

            SizedBox(height: 10.h),

            // Service type and view details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 18,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      order.serviceType,
                      style: TextStyle(
                        fontSize: 13.h,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    controller.viewOrderDetails(order.id);
                  },
                  child: Row(
                    children: [
                      Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 12.h,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}