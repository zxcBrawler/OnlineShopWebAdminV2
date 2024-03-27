import 'dart:convert';
import 'dart:ui';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:universal_html/html.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';

class PdfService {
  /// Generates a PDF document containing a list of clothes and saves it to a file.
  ///
  /// The clothes data is represented by a list of [ClothesEntity] objects.
  /// The resulting PDF document contains a table with columns for name, price, barcode,
  /// type, and gender of each piece of clothes.
  ///
  /// This function takes a list of [clothes] as a parameter and returns a [Future]
  /// with a void value.
  ///
  /// The resulting PDF document is saved to a file with the name "clothes.pdf".
  Future<void> printsClothesPDF(List<ClothesEntity> clothes) async {
    // Create a new PDF document
    PdfDocument pdfDocument = PdfDocument();

    // Add a title to the first page of the PDF document
    pdfDocument.pages.add().graphics.drawString(
          'Clothes in shop', // Title
          PdfStandardFont(PdfFontFamily.helvetica, 20), // Font
          bounds: const Rect.fromLTWH(0, 0, 200, 50), // Bounds
          format: PdfStringFormat(alignment: PdfTextAlignment.center), // Format
        );

    // Create a grid layout for the clothes data
    PdfGrid grid = PdfGrid();

    // Add columns to the grid
    grid.columns.add(count: 5);

    // Add a header row to the grid
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];

    // Set the column headers
    header.cells[0].value = 'name clothes en';
    header.cells[1].value = 'price in rub';
    header.cells[2].value = 'barcode';
    header.cells[3].value = 'type clothes';
    header.cells[4].value = 'gender';

    // Style the header row
    header.style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.brown, // Background color
      textBrush: PdfBrushes.white, // Text color
      cellPadding:
          PdfPaddings(left: 10, right: 3, top: 4, bottom: 5), // Cell padding
      format:
          PdfStringFormat(alignment: PdfTextAlignment.center), // Text alignment
      font: PdfStandardFont(
          // Font
          PdfFontFamily.courier,
          14,
          style: PdfFontStyle.bold),
    );

    // Add rows for each piece of clothes to the grid
    for (final item in clothes) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = item.nameClothesEn;

      row.cells[1].value = item.priceClothes;
      row.cells[2].value = item.barcode;
      row.cells[3].value = item.typeClothes!.nameType;
      row.cells[4].value = item.typeClothes!.categoryClothes!.nameCategory;
    }

    // Style the grid
    grid.style = PdfGridStyle(
      backgroundBrush: PdfBrushes.white, // Background color
      textBrush: PdfBrushes.black, // Text color
      font: PdfStandardFont(
        // Font
        PdfFontFamily.courier,
        14,
      ),
    );

    // Draw the grid on a new page of the PDF document
    grid.draw(
      page: pdfDocument.pages.add(),
      bounds: const Rect.fromLTWH(0, 0, 0, 0),
    );

    // Convert the PDF document to a byte array and encode it as a base64 string
    List<int> bytes = await pdfDocument.save();

    // Create a download link for the PDF document and trigger a download
    AnchorElement(
        href:
            "data:application/pdf;charset=utf-8;base64,${base64Encode(bytes)}")
      ..setAttribute('download', 'clothes.pdf')
      ..click();

    // Dispose of the PDF document
    pdfDocument.dispose();
  }

  Future<void> printOrdersPDF(List<DeliveryInfoEntity> orders) async {
    // Create a new PDF document
    PdfDocument pdfDocument = PdfDocument();

    // Add a title to the first page of the PDF document
    pdfDocument.pages.add().graphics.drawString(
          'Orders made', // Title
          PdfStandardFont(PdfFontFamily.helvetica, 20), // Font
          bounds: const Rect.fromLTWH(0, 0, 200, 50), // Bounds
          format: PdfStringFormat(alignment: PdfTextAlignment.center), // Format
        );

    // Create a grid layout for the orders data
    PdfGrid grid = PdfGrid();

    // Add columns to the grid
    grid.columns.add(count: 7);

    // Add a header row to the grid
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];

    // Set the column headers
    header.cells[0].value = 'date order';
    header.cells[1].value = 'time order';
    header.cells[2].value = 'sum order';
    header.cells[3].value = 'current status';
    header.cells[4].value = 'type delivery';
    header.cells[5].value = 'user';

    header.cells[6].value = 'order number';

    // Style the header row
    header.style = PdfGridCellStyle(
      backgroundBrush: PdfBrushes.brown, // Background color
      textBrush: PdfBrushes.white, // Text color
      cellPadding:
          PdfPaddings(left: 10, right: 3, top: 4, bottom: 5), // Cell padding
      format:
          PdfStringFormat(alignment: PdfTextAlignment.center), // Text alignment
      font: PdfStandardFont(
          // Font
          PdfFontFamily.courier,
          14,
          style: PdfFontStyle.bold),
    );

    // Add rows for each piece of clothes to the grid
    for (final item in orders) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = item.order!.dateOrder!;
      row.cells[1].value = item.order!.timeOrder;
      row.cells[2].value = item.order!.sumOrder;
      row.cells[3].value = item.order!.currentStatus!.nameStatus;
      row.cells[4].value = item.typeDelivery!.nameType;
      row.cells[5].value = item.order!.userCard!.user!.email;

      row.cells[6].value = item.order!.numberOrder;
    }

    // Style the grid
    grid.style = PdfGridStyle(
      backgroundBrush: PdfBrushes.white, // Background color
      textBrush: PdfBrushes.black, // Text color
      font: PdfStandardFont(
        // Font
        PdfFontFamily.courier,
        14,
      ),
    );

    // Draw the grid on a new page of the PDF document
    grid.draw(
      page: pdfDocument.pages.add(),
      bounds: const Rect.fromLTWH(0, 0, 0, 0),
    );

    // Convert the PDF document to a byte array and encode it as a base64 string
    List<int> bytes = await pdfDocument.save();

    // Create a download link for the PDF document and trigger a download
    AnchorElement(
        href:
            "data:application/pdf;charset=utf-8;base64,${base64Encode(bytes)}")
      ..setAttribute('download', 'orders.pdf')
      ..click();

    // Dispose of the PDF document
    pdfDocument.dispose();
  }
}
