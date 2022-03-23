import 'dart:io';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:tashfia_export/controller/public_controller.dart';
import 'package:tashfia_export/model/purchase_list_model.dart';
import 'package:tashfia_export/pages/view_pdf_page.dart';
import 'package:tashfia_export/variables/variable.dart';

class PurchaseReportPDF{

  static Future<void> generatePurchasePDFReport(List<Purchase> dataList)async{
    PublicController.pc.loading(true);PublicController.pc.update();
    final pdf = pw.Document();
    var data = await rootBundle.load("assets/fonts/OpenSans-Medium.ttf");
    var myFont = pw.Font.ttf(data);

    var boldTextStyle = pw.TextStyle(
      font: myFont,
      fontSize: 8.0,
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.black,
    );
    var normalTextStyle = pw.TextStyle(
        font: myFont,
        fontSize: 8.0,
        fontWeight: pw.FontWeight.normal,
        color: PdfColors.black
    );
    var smallTextStyle = pw.TextStyle(
        font: myFont,
        fontSize: 6.0,
        fontWeight: pw.FontWeight.normal,
        color: PdfColors.black
    );

    Future<File> getImageFileFromAssets(String path) async {
      final byteData = await rootBundle.load('assets/$path');
      final File file = File('${(await getTemporaryDirectory()).path}/$path');
      await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      return file;
    }
    File imageFile = await getImageFileFromAssets('header_logo.png');
    final image = pw.MemoryImage(imageFile.readAsBytesSync());

    ///Sales Amount & Profit Loss Calculation
    double quantity = 0.0;
    double totalPaid= 0.0;
    double totalDue = 0.0;
    for(var element in dataList){
      if(element.quantity!=null){
        quantity = quantity+double.parse(element.quantity.toString());
      }
      if(element.paymentAmount!=null){
        totalPaid = totalPaid+double.parse(element.paymentAmount.toString());
      }
      if(element.due!=null){
        totalDue = totalDue+double.parse(element.due.toString());
      }
    }


    ///PDF UI Design
    pdf.addPage(
        pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.all(32),
            build: (pw.Context context){
              return[
                pw.Header(
                  child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        ///Left Header Section
                        pw.Expanded(
                          child: pw.Column(
                              children: [
                                pw.Row(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text('Main Shop Phone:',style: smallTextStyle),
                                      pw.Column(
                                          children: [
                                            pw.Text('+8801847092041',style: smallTextStyle),
                                            pw.Text('+8801810077440',style: smallTextStyle),
                                          ]
                                      )
                                    ]
                                ),

                                pw.Row(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text('Office Phone:',style: smallTextStyle),
                                      pw.Column(
                                          children: [
                                            pw.Text('+8801810077441',style: smallTextStyle),
                                            pw.Text('+8801810088007',style: smallTextStyle),
                                          ]
                                      )
                                    ]
                                ),

                                pw.Row(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text('Main Shop TNT:',style: smallTextStyle),
                                      pw.Text('8801711853521',style: smallTextStyle)
                                    ]
                                ),
                                pw.Row(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text('Store TNT:',style: smallTextStyle),
                                      pw.Text('+88-02-47651260',style: smallTextStyle)
                                    ]
                                ),

                                pw.Row(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text('Office Mail:',style: smallTextStyle),
                                      pw.Text('tashfiaexportoffice@gmail.com',style: smallTextStyle)
                                    ]
                                ),
                              ]
                          ),
                        ),

                        ///Header Image
                        pw.SizedBox(child: pw.Image(image),width: 250),

                        ///Right Header Section
                        pw.Expanded(
                          child: pw.Column(
                              children: [
                                pw.Row(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text('MD:',style: smallTextStyle),
                                      pw.Column(
                                          children: [
                                            pw.Text('+8801848080971',style: smallTextStyle),
                                            pw.Text('+8801711853521',style: smallTextStyle),
                                          ]
                                      )
                                    ]
                                ),

                                pw.Row(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text('MD Mail:',style: smallTextStyle),
                                      pw.Text('tashfiaexport@gmail.com',style: smallTextStyle)
                                    ]
                                ),
                                pw.Row(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text('Address:',style: smallTextStyle),
                                      pw.Text('52/2 B.B Road,Shop No\n'
                                          '#Gho 8,Gulshan Market,Nayamati,\n'
                                          'Narayanganj-1400,Bangladesh',
                                          textAlign: pw.TextAlign.right,
                                          style: smallTextStyle)
                                    ]
                                ),
                              ]
                          ),
                        )
                      ]
                  ),
                ),

                ///Title
                pw.Center(child: pw.Text('Purchase Invoice History | Tashfia Export',style: boldTextStyle.copyWith(fontSize: 11.0))),
                pw.SizedBox(height: 5.0),

                ///Table Header
                pw.Container(
                  color: PdfColors.green,
                  child: pw.Row(
                      children: [
                        pw.Container(
                          child: pw.Text('SL',style: boldTextStyle.copyWith(color: PdfColors.white)),
                          padding: const pw.EdgeInsets.all(3),
                          width: 30.0,
                        ),
                        pw.Container(
                          child: pw.Text('Date',style: boldTextStyle.copyWith(color: PdfColors.white),textAlign: pw.TextAlign.center),
                          padding: const pw.EdgeInsets.all(3),
                          width: 45.0,
                        ),
                        pw.Expanded(
                          child: pw.Padding(
                            child: pw.Text('Supplier Name',style: boldTextStyle.copyWith(color: PdfColors.white),textAlign: pw.TextAlign.center),
                            padding: const pw.EdgeInsets.all(3),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Padding(
                            child: pw.Text('Product',style: boldTextStyle.copyWith(color: PdfColors.white),textAlign: pw.TextAlign.center),
                            padding: const pw.EdgeInsets.all(3),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Padding(
                            child: pw.Text('Quantity(Kg)',style: boldTextStyle.copyWith(color: PdfColors.white),textAlign: pw.TextAlign.center),
                            padding: const pw.EdgeInsets.all(3),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Padding(
                            child: pw.Text('Unit price/Kg',style: boldTextStyle.copyWith(color: PdfColors.white),textAlign: pw.TextAlign.center),
                            padding: const pw.EdgeInsets.all(3),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Padding(
                            child: pw.Text('Total price',style: boldTextStyle.copyWith(color: PdfColors.white),textAlign: pw.TextAlign.center),
                            padding: const pw.EdgeInsets.all(3),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Padding(
                            child: pw.Text('Total paid',style: boldTextStyle.copyWith(color: PdfColors.white),textAlign: pw.TextAlign.center),
                            padding: const pw.EdgeInsets.all(3),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Padding(
                            child: pw.Text('Due',style: boldTextStyle.copyWith(color: PdfColors.white),textAlign: pw.TextAlign.center),
                            padding: const pw.EdgeInsets.all(3),
                          ),
                        ),
                      ]
                  ),
                ),

                ///Table Body
                pw.ListView.separated(
                  itemCount: dataList.length,
                  itemBuilder: (context, index){
                    return pw.Row(
                        children: [
                          pw.Container(
                              child: pw.Text('${index+1}',style: normalTextStyle,textAlign: pw.TextAlign.center),
                              padding: const pw.EdgeInsets.all(3),
                              width: 30.0,
                              alignment: pw.Alignment.center,
                          ),
                          pw.Container(
                              child: pw.Text(DateFormat('dd/MM/yy').format(dataList[index].createdAt!),style: normalTextStyle,textAlign: pw.TextAlign.center),
                              padding: const pw.EdgeInsets.all(3),
                              width: 45.0,
                              alignment: pw.Alignment.center,
                          ),
                          pw.Expanded(
                            child: pw.Container(
                                child: pw.Text(dataList[index].product!.partyName!,style: normalTextStyle,textAlign: pw.TextAlign.center),
                                padding: const pw.EdgeInsets.all(3),
                                alignment: pw.Alignment.center,
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Container(
                                child: pw.Text(dataList[index].product!.chalanNo!,style: normalTextStyle,textAlign: pw.TextAlign.center),
                                padding: const pw.EdgeInsets.all(3),
                                alignment: pw.Alignment.center,
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Container(
                                child: pw.Text(dataList[index].quantity!,style: normalTextStyle,textAlign: pw.TextAlign.center),
                                padding: const pw.EdgeInsets.all(3),
                                alignment: pw.Alignment.center,
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Container(
                                child: pw.Text(dataList[index].unitPrice!,style: normalTextStyle,textAlign: pw.TextAlign.center),
                                padding: const pw.EdgeInsets.all(3),
                                alignment: pw.Alignment.center,
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Container(
                                child: pw.Text(dataList[index].totalPurchasPrice!,style: normalTextStyle,textAlign: pw.TextAlign.center),
                                padding: const pw.EdgeInsets.all(3),
                                alignment: pw.Alignment.center,
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Container(
                                child: pw.Text(dataList[index].paymentAmount!,style: normalTextStyle,textAlign: pw.TextAlign.center),
                                padding: const pw.EdgeInsets.all(3),
                                alignment: pw.Alignment.center,
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Container(
                                child: pw.Text(dataList[index].due!,style: normalTextStyle,textAlign: pw.TextAlign.center),
                                padding: const pw.EdgeInsets.all(3),
                                alignment: pw.Alignment.center,
                            ),
                          ),
                        ]
                    );
                  },
                  separatorBuilder: (context, index)=>pw.Divider(color: PdfColors.grey,height: 0.0,thickness: 0.5),
                ),
                pw.Divider(color: PdfColors.grey,height: 0.0),

                ///Table Footer
                pw.Row(
                    children: [
                      pw.Container(
                          child: pw.Text('Total',style: boldTextStyle.copyWith(color: PdfColors.purple),textAlign: pw.TextAlign.left),
                          padding: const pw.EdgeInsets.all(3),
                          width: 75.0,
                          alignment: pw.Alignment.centerLeft,
                      ),
                      pw.Expanded(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(3),
                            alignment: pw.Alignment.center,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(3),
                            alignment: pw.Alignment.center,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Container(
                            child: pw.Text('${double.parse((quantity).toStringAsFixed(2))} Kg',style: boldTextStyle.copyWith(color: PdfColors.purple)),
                            padding: const pw.EdgeInsets.all(3),
                            alignment: pw.Alignment.center,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(3),
                            alignment: pw.Alignment.center,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Container(
                            padding: const pw.EdgeInsets.all(3),
                            alignment: pw.Alignment.center,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Container(
                            child: pw.Text('${double.parse((totalPaid).toStringAsFixed(2))} TK',style: boldTextStyle.copyWith(color: PdfColors.purple)),
                            padding: const pw.EdgeInsets.all(3),
                            alignment: pw.Alignment.center,
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Container(
                            child: pw.Text('${double.parse((totalDue).toStringAsFixed(2))} TK',style: boldTextStyle.copyWith(color: PdfColors.purple)),
                            padding: const pw.EdgeInsets.all(3),
                            alignment: pw.Alignment.center,
                        ),
                      ),
                    ]
                ),
              ];
            }
        )
    );

    try{
      final directory = await DownloadsPathProvider.downloadsDirectory;
      final String fileName = 'purchase-report-${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${directory!.path}/$fileName');
      await file.writeAsBytes(await pdf.save(),flush: true);

      PublicController.pc.loading(false);PublicController.pc.update();
      showToast('PDF saved to Download folder');
      ///View generated PDF
      Get.to(()=>ViewPdfPage(filePath: file.path,fileName: fileName));
    }catch(e){
      PublicController.pc.loading(false);PublicController.pc.update();
      showToast(e.toString());
      if(kDebugMode){print(e.toString());}
    }
  }
}