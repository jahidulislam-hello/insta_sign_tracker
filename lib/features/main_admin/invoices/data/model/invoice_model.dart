enum InvoiceStatus { paid, pending, unpaid }

class InvoiceModel {
  final String invoiceNumber;
  final String title;
  final String date;
  final double amount;
  final InvoiceStatus status;

  InvoiceModel({
    required this.invoiceNumber,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
  });
}