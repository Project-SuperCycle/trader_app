import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:trader_app/core/constants.dart';
import 'package:trader_app/features/finances/data/entities/transaction_model.dart';

class ExportReceiptButton extends StatelessWidget {
  const ExportReceiptButton({super.key, required this.transaction});

  final TransactionModel transaction;

  Future<pw.Document> _buildPdf() async {
    final pdf = await _buildPdf();

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'receipt_${transaction.id}.pdf',
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // ── Header ──
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(20),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('2A7A52'),
                    borderRadius: pw.BorderRadius.circular(12),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'إيصال معاملة',
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 22,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'رقم الشحنة: ${transaction.id}',
                        style: const pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 24),

                // ── Details ──
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColor.fromHex('3BC577'),
                      width: 0.5,
                    ),
                    borderRadius: pw.BorderRadius.circular(10),
                  ),
                  child: pw.Column(
                    children: [
                      _pdfRow('رقم الشحنة', transaction.id),
                      _pdfDivider(),
                      _pdfRow('التاريخ', transaction.date),
                      _pdfDivider(),
                      _pdfRow(
                        'الحالة',
                        transaction.isPending ? 'منتظر' : 'تم التحصيل',
                      ),
                      _pdfDivider(),
                      _pdfRow('طريقة التحصيل', transaction.paymentMethod),
                      _pdfDivider(),
                      _pdfRow(
                        'الوزن الإجمالي',
                        '${transaction.totalWeight} طن',
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 16),

                // ── Total Amount ──
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(16),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('F0FBF5'),
                    borderRadius: pw.BorderRadius.circular(10),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        '${transaction.totalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')} جنيه',
                        style: pw.TextStyle(
                          color: PdfColor.fromHex('10B981'),
                          fontSize: 22,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'إجمالي المبلغ المستحق',
                        style: pw.TextStyle(
                          color: PdfColor.fromHex('888888'),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                pw.Spacer(),

                // ── Footer ──
                pw.Center(
                  child: pw.Text(
                    'شكراً لتعاملكم معنا',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex('3BC577'),
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _pdfRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 13,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('10B981'),
            ),
          ),
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 12,
              color: PdfColor.fromHex('888888'),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _pdfDivider() {
    return pw.Divider(color: PdfColor.fromHex('E5E7EB'), thickness: 0.5);
  }

  Future<void> _exportPdf(BuildContext context) async {
    final pdf = await _buildPdf();
    final bytes = await pdf.save();

    await Printing.sharePdf(
      bytes: bytes,
      filename: 'receipt_${transaction.id}.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: kGradientButton,
          borderRadius: BorderRadius.circular(kButtonBorderRadius),
        ),
        child: ElevatedButton(
          onPressed: () => _exportPdf(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kButtonBorderRadius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.picture_as_pdf_outlined,
                size: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              const Text(
                'تصدير كـ PDF',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
