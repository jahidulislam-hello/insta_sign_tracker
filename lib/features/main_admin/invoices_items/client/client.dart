import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// COLORS (kept local to this file so it can be dropped into any project
// as a standalone screen)
// ---------------------------------------------------------------------------
class ClientColors {
  static const bg = Color(0xFFF6F8FC);
  static const cardBorder = Color(0xFFE9ECF5);
  static const textDark = Color(0xFF1E2432);
  static const textGrey = Color(0xFF8992A3);
  static const blue = Color(0xFF3E7BFA);
  static const blueLight = Color(0xFFEAF1FF);
  static const green = Color(0xFF17A567);
  static const greenLight = Color(0xFFE8F8F0);
  static const red = Color(0xFFE0435A);
  static const redLight = Color(0xFFFCEAED);
  static const greyBadgeBg = Color(0xFFF1F2F6);
  static const greyBadgeText = Color(0xFF8992A3);
}

// ---------------------------------------------------------------------------
// MODEL
// ---------------------------------------------------------------------------
enum ClientStatus { paid, unpaid, failed }

class ClientOrder {
  final int sn;
  final String invoiceNo;
  final String orderId;
  final String type;
  final String orderDate;
  final double price;
  final ClientStatus status;

  ClientOrder({
    required this.sn,
    required this.invoiceNo,
    required this.orderId,
    required this.type,
    required this.orderDate,
    required this.price,
    required this.status,
  });
}

final List<ClientOrder> clientOrders = [
  ClientOrder(sn: 1, invoiceNo: '#7511', orderId: '#7511', type: 'Sign install', orderDate: '22/01/2026', price: 200, status: ClientStatus.paid),
  ClientOrder(sn: 2, invoiceNo: '#7512', orderId: '#7512', type: 'Sign install', orderDate: '22/01/2026', price: 250, status: ClientStatus.paid),
  ClientOrder(sn: 3, invoiceNo: '#7513', orderId: '#7513', type: 'Sign install', orderDate: '22/01/2026', price: 180, status: ClientStatus.unpaid),
  ClientOrder(sn: 4, invoiceNo: '#7514', orderId: '#7514', type: 'Sign install', orderDate: '22/01/2026', price: 300, status: ClientStatus.paid),
  ClientOrder(sn: 5, invoiceNo: '#7515', orderId: '#7515', type: 'Sign install', orderDate: '22/01/2026', price: 220, status: ClientStatus.failed),
  ClientOrder(sn: 6, invoiceNo: '#7516', orderId: '#7516', type: 'Sign install', orderDate: '22/01/2026', price: 275, status: ClientStatus.paid),
  ClientOrder(sn: 7, invoiceNo: '#7517', orderId: '#7517', type: 'Sign install', orderDate: '22/01/2026', price: 260, status: ClientStatus.paid),
  ClientOrder(sn: 8, invoiceNo: '#7518', orderId: '#7518', type: 'Sign install', orderDate: '22/01/2026', price: 310, status: ClientStatus.paid),
];

// ---------------------------------------------------------------------------
// SCREEN
// ---------------------------------------------------------------------------
class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClientColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTableCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // HEADER: title + total badge + filter/search
  // ---------------------------------------------------------------------
  Widget _buildHeader() {
    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < 640;
      final titleRow = Row(
        children: [
          const Text(
            'Client',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: ClientColors.textDark,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Total:',
            style: TextStyle(fontSize: 13, color: ClientColors.textGrey),
          ),
          const SizedBox(width: 6),
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ClientColors.blueLight,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${clientOrders.length}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: ClientColors.blue,
              ),
            ),
          ),
        ],
      );

      final controlsRow = Row(
        children: [
          _filterByStatusChip(),
          const SizedBox(width: 10),
          _searchBox(),
        ],
      );

      if (isNarrow) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleRow,
            const SizedBox(height: 14),
            controlsRow,
          ],
        );
      }
      return Row(
        children: [
          Expanded(child: titleRow),
          controlsRow,
        ],
      );
    });
  }

  Widget _filterByStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ClientColors.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filter by status',
            style: TextStyle(
              fontSize: 13,
              color: ClientColors.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down_rounded,
              size: 16, color: ClientColors.textGrey),
        ],
      ),
    );
  }

  Widget _searchBox() {
    return Container(
      width: 220,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ClientColors.cardBorder),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, size: 16, color: ClientColors.textGrey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search here...',
                hintStyle: TextStyle(fontSize: 13, color: ClientColors.textGrey),
              ),
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TABLE
  // ---------------------------------------------------------------------
  Widget _buildTableCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ClientColors.cardBorder),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _tableHeaderRow(),
              for (int i = 0; i < clientOrders.length; i++)
                _tableDataRow(clientOrders[i], isLast: i == clientOrders.length - 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableHeaderRow() {
    const style = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: ClientColors.textGrey,
      letterSpacing: 0.3,
    );
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: ClientColors.cardBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          SizedBox(width: 40, child: Text('S.N.', style: style)),
          SizedBox(width: 130, child: Text('INVOICE NO', style: style)),
          SizedBox(width: 110, child: Text('ORDER ID', style: style)),
          SizedBox(width: 110, child: Text('TYPE', style: style)),
          SizedBox(width: 110, child: Text('ORDER DATE', style: style)),
          SizedBox(width: 80, child: Text('PRICE', style: style)),
          SizedBox(width: 110, child: Text('STATUS', style: style)),
          const Expanded(child: Text('REFUND', style: style)),
          SizedBox(width: 90, child: Text('ACTION', style: style, textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _tableDataRow(ClientOrder order, {required bool isLast}) {
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: ClientColors.cardBorder)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text('${order.sn}',
                style: const TextStyle(fontSize: 13, color: ClientColors.textDark)),
          ),
          SizedBox(
            width: 130,
            child: Text(order.invoiceNo,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ClientColors.blue)),
          ),
          SizedBox(
            width: 110,
            child: Text(order.orderId,
                style: const TextStyle(fontSize: 13, color: ClientColors.textDark)),
          ),
          SizedBox(
            width: 110,
            child: Text(order.type,
                style: const TextStyle(fontSize: 13, color: ClientColors.textDark)),
          ),
          SizedBox(
            width: 110,
            child: Text(order.orderDate,
                style: const TextStyle(fontSize: 13, color: ClientColors.textDark)),
          ),
          SizedBox(
            width: 80,
            child: Text('\$${order.price.toStringAsFixed(0)}',
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ClientColors.textDark)),
          ),
          SizedBox(width: 110, child: _statusBadge(order.status)),
          Expanded(child: _refundButton()),
          SizedBox(
            width: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionIcon(Icons.visibility_outlined),
                const SizedBox(width: 8),
                _pdfButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(ClientStatus status) {
    late Color bg;
    late Color fg;
    late String label;
    switch (status) {
      case ClientStatus.paid:
        bg = ClientColors.greenLight;
        fg = ClientColors.green;
        label = 'Paid';
        break;
      case ClientStatus.unpaid:
        bg = ClientColors.greyBadgeBg;
        fg = ClientColors.greyBadgeText;
        label = 'Unpaid';
        break;
      case ClientStatus.failed:
        bg = ClientColors.redLight;
        fg = ClientColors.red;
        label = 'Failed';
        break;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 11.5, fontWeight: FontWeight.w600, color: fg),
          ),
        ),
        if (status == ClientStatus.unpaid) ...[
          const SizedBox(width: 6),
          const Icon(Icons.edit_outlined, size: 13, color: ClientColors.textGrey),
        ],
      ],
    );
  }

  Widget _refundButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ClientColors.cardBorder),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.replay_rounded, size: 14, color: ClientColors.textGrey),
          SizedBox(width: 6),
          Text(
            'Refund',
            style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: ClientColors.textDark),
          ),
        ],
      ),
    );
  }

  Widget _actionIcon(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(color: ClientColors.cardBorder),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 14, color: ClientColors.textGrey),
    );
  }

  Widget _pdfButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: ClientColors.blue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.download_rounded, size: 12, color: Colors.white),
          SizedBox(width: 4),
          Text(
            'PDF',
            style: TextStyle(
                fontSize: 11.5, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ],
      ),
    );
  }
}