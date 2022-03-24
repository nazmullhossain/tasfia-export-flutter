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
import 'package:tashfia_export/pages/view_pdf_page.dart';
import 'package:tashfia_export/variables/variable.dart';

class DepositExpenseReportPDF{

  static Future<void> generateDepositExpensePDFReport()async{
    PublicController.pc.loading(true);PublicController.pc.update();
    final pdf = pw.Document();
    var data = await rootBundle.load("assets/fonts/OpenSans-Medium.ttf");
    var myFont = pw.Font.ttf(data);

    ///Bengali font
    var bengaliData = await rootBundle.load("assets/fonts/kalpurush.ttf");
    var bengaliFont = pw.Font.ttf(bengaliData);

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

    ///Bengali font style
    // var boldTextStyle = pw.TextStyle(
    //   font: bengaliFont,
    //   fontSize: 8.0,
    //   fontWeight: pw.FontWeight.bold,
    //   color: PdfColors.black,
    // );
    // var normalTextStyle = pw.TextStyle(
    //     font: bengaliFont,
    //     fontSize: 8.0,
    //     fontWeight: pw.FontWeight.normal,
    //     color: PdfColors.black
    // );

    Future<File> getImageFileFromAssets(String path) async {
      final byteData = await rootBundle.load('assets/$path');
      final File file = File('${(await getTemporaryDirectory()).path}/$path');
      await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      return file;
    }
    File imageFile = await getImageFileFromAssets('header_logo.png');
    final image = pw.MemoryImage(imageFile.readAsBytesSync());

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
                pw.Center(child: pw.Text('Date : ${DateFormat('dd-MMM-yy').format(DateTime.now())}',style: boldTextStyle.copyWith(fontSize: 12.0))),
                pw.SizedBox(height: 5.0),


                ///Main Body Section
                pw.Row(
                  mainAxisSize: pw.MainAxisSize.max,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children:[
                      ///Left Section****************************************
                      pw.Expanded(
                        child: pw.Container(
                            decoration: pw.BoxDecoration(
                                color: PdfColors.grey100,
                                borderRadius:const pw.BorderRadius.all(pw.Radius.circular(5)),
                                border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                            ),
                          child: pw.Column(
                            children: [
                              ///Title:::::::::::::::::::::::::::::::::::::::
                              pw.Padding(
                                padding: const pw.EdgeInsets.all(5),
                                child: pw.Text('Asset',style: boldTextStyle,textAlign: pw.TextAlign.center)
                              ),
                              pw.Divider(thickness: 0.5,height: 0.0),

                              ///Body:::::::::::::::::::::::::::::::::::::::
                              pw.Column(
                                  children:[
                                    pw.SizedBox(height: 5.0),
                                    ///Cash
                                    pw.Container(
                                        margin: const pw.EdgeInsets.all(5.0),
                                        decoration: pw.BoxDecoration(
                                            color: PdfColors.white,
                                            borderRadius:const pw.BorderRadius.all(pw.Radius.circular(2)),
                                            border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                                        ),
                                        child: pw.Row(
                                            children: [
                                              pw.Expanded(
                                                  child: pw.Text('Cash :',style: boldTextStyle,textAlign: pw.TextAlign.center)
                                              ),
                                              pw.Container(color: PdfColors.grey,height: 20,width: 0.5),
                                              pw.Expanded(
                                                  child: pw.Text('86621/=',style: normalTextStyle,textAlign: pw.TextAlign.center)
                                              )
                                            ]
                                        )
                                    ),
                                    ///Purchase Title====================================
                                    pw.Container(
                                        padding: const pw.EdgeInsets.all(5.0),
                                        margin: const pw.EdgeInsets.symmetric(horizontal: 5.0),
                                        width: double.maxFinite,
                                        decoration: pw.BoxDecoration(
                                            color: PdfColors.grey800,
                                            borderRadius:const pw.BorderRadius.all(pw.Radius.circular(2)),
                                            border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                                        ),
                                        child: pw.Text('Purchase:',style: boldTextStyle.copyWith(color: PdfColors.white))
                                    ),
                                    ///Purchase Table header
                                    pw.Container(
                                        margin: const pw.EdgeInsets.symmetric(horizontal: 5.0),
                                        width: double.maxFinite,
                                        decoration: pw.BoxDecoration(
                                            color: PdfColors.blueGrey50,
                                            borderRadius:const pw.BorderRadius.all(pw.Radius.circular(2)),
                                            border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                                        ),
                                        child: pw.Row(
                                          children: [
                                            pw.Container(
                                              child: pw.Text('#',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                              alignment: pw.Alignment.center,
                                              padding: const pw.EdgeInsets.all(5.0),
                                              width: 30.0,
                                            ),
                                            pw.Expanded(
                                              child: pw.Padding(
                                                padding: const pw.EdgeInsets.all(5.0),
                                                child: pw.Text('Party Name',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                              )
                                            ),
                                            pw.Expanded(
                                                child: pw.Padding(
                                                  padding: const pw.EdgeInsets.all(5.0),
                                                  child: pw.Text('Bill No',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                )
                                            ),
                                            pw.Expanded(
                                                child: pw.Padding(
                                                  padding: const pw.EdgeInsets.all(5.0),
                                                  child: pw.Text('Check No',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                )
                                            ),
                                            pw.Expanded(
                                                child: pw.Padding(
                                                  padding: const pw.EdgeInsets.all(5.0),
                                                  child: pw.Text('Total',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                )
                                            ),
                                          ]
                                        )
                                    ),
                                    ///Purchase table body
                                    pw.Padding(
                                      padding:const pw.EdgeInsets.symmetric(horizontal: 7.0),
                                      child: pw.ListView.separated(
                                          itemCount: 5,
                                          itemBuilder: (context, index)=>pw.Row(
                                              children: [
                                                pw.Container(
                                                  child: pw.Text('${index+1}',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                  alignment: pw.Alignment.center,
                                                  padding: const pw.EdgeInsets.all(2.0),
                                                  width: 30.0,
                                                ),
                                                pw.Expanded(
                                                    child: pw.Padding(
                                                      padding: const pw.EdgeInsets.all(2.0),
                                                      child: pw.Text('Party Name',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                    )
                                                ),
                                                pw.Expanded(
                                                    child: pw.Padding(
                                                      padding: const pw.EdgeInsets.all(2.0),
                                                      child: pw.Text('Bill No',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                    )
                                                ),
                                                pw.Expanded(
                                                    child: pw.Padding(
                                                      padding: const pw.EdgeInsets.all(2.0),
                                                      child: pw.Text('Check No',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                    )
                                                ),
                                                pw.Expanded(
                                                    child: pw.Padding(
                                                      padding: const pw.EdgeInsets.all(2.0),
                                                      child: pw.Text('Total',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                    )
                                                ),
                                              ]
                                          ),
                                          separatorBuilder:(context, index)=>pw.Divider(thickness: 0.2,height: 0.0))
                                    ),
                                    pw.Padding(
                                      padding:const pw.EdgeInsets.symmetric(horizontal: 7.0),
                                      child: pw.Divider(thickness: 0.2,height: 0.0)
                                    ),

                                    ///All Deposit Title====================================
                                    pw.Container(
                                        padding: const pw.EdgeInsets.all(5.0),
                                        margin: const pw.EdgeInsets.symmetric(horizontal: 5.0),
                                        width: double.maxFinite,
                                        decoration: pw.BoxDecoration(
                                            color: PdfColors.grey800,
                                            borderRadius:const pw.BorderRadius.all(pw.Radius.circular(2)),
                                            border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                                        ),
                                        child: pw.Text('All Deposite:',style: boldTextStyle.copyWith(color: PdfColors.white))
                                    ),
                                    ///All Deposit Table header
                                    pw.Container(
                                        margin: const pw.EdgeInsets.symmetric(horizontal: 5.0),
                                        width: double.maxFinite,
                                        decoration: pw.BoxDecoration(
                                            color: PdfColors.blueGrey50,
                                            borderRadius:const pw.BorderRadius.all(pw.Radius.circular(2)),
                                            border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                                        ),
                                        child: pw.Row(
                                            children: [
                                              pw.Container(
                                                child: pw.Text('#',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                alignment: pw.Alignment.center,
                                                padding: const pw.EdgeInsets.all(5.0),
                                                width: 30.0,
                                              ),
                                              pw.Expanded(
                                                  child: pw.Padding(
                                                    padding: const pw.EdgeInsets.all(5.0),
                                                    child: pw.Text('Party Name',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                  )
                                              ),
                                              pw.Expanded(
                                                  child: pw.Padding(
                                                    padding: const pw.EdgeInsets.all(5.0),
                                                    child: pw.Text('Category',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                  )
                                              ),
                                              pw.Expanded(
                                                  child: pw.Padding(
                                                    padding: const pw.EdgeInsets.all(5.0),
                                                    child: pw.Text('Comment',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                  )
                                              ),
                                              pw.Expanded(
                                                  child: pw.Padding(
                                                    padding: const pw.EdgeInsets.all(5.0),
                                                    child: pw.Text('Total',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                  )
                                              ),
                                            ]
                                        )
                                    ),
                                    ///All Deposit  table body
                                    pw.Padding(
                                        padding:const pw.EdgeInsets.symmetric(horizontal: 7.0),
                                        child: pw.ListView.separated(
                                            itemCount: 5,
                                            itemBuilder: (context, index)=>pw.Row(
                                                children: [
                                                  pw.Container(
                                                    child: pw.Text('${index+1}',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                    alignment: pw.Alignment.center,
                                                    padding: const pw.EdgeInsets.all(2.0),
                                                    width: 30.0,
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(2.0),
                                                        child: pw.Text('Party Name',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(2.0),
                                                        child: pw.Text('Category',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(2.0),
                                                        child: pw.Text('Comment',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(2.0),
                                                        child: pw.Text('Total',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                ]
                                            ),
                                            separatorBuilder:(context, index)=>pw.Divider(thickness: 0.2,height: 0.0))
                                    ),
                                    pw.Padding(
                                        padding:const pw.EdgeInsets.symmetric(horizontal: 7.0),
                                        child: pw.Divider(thickness: 0.2,height: 0.0)
                                    ),

                                    ///Advance Deposit Title====================================
                                    pw.Container(
                                        padding: const pw.EdgeInsets.all(5.0),
                                        margin: const pw.EdgeInsets.symmetric(horizontal: 5.0),
                                        width: double.maxFinite,
                                        decoration: pw.BoxDecoration(
                                            color: PdfColors.grey800,
                                            borderRadius:const pw.BorderRadius.all(pw.Radius.circular(2)),
                                            border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                                        ),
                                        child: pw.Text('Advance Deposite:',style: boldTextStyle.copyWith(color: PdfColors.white))
                                    ),
                                    ///Advance Deposit Table header
                                    pw.Container(
                                        margin: const pw.EdgeInsets.symmetric(horizontal: 5.0),
                                        width: double.maxFinite,
                                        decoration: pw.BoxDecoration(
                                            color: PdfColors.blueGrey50,
                                            borderRadius:const pw.BorderRadius.all(pw.Radius.circular(2)),
                                            border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                                        ),
                                        child: pw.Row(
                                            children: [
                                              pw.Container(
                                                child: pw.Text('#',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                alignment: pw.Alignment.center,
                                                padding: const pw.EdgeInsets.all(5.0),
                                                width: 30.0,
                                              ),
                                              pw.Expanded(
                                                  child: pw.Padding(
                                                    padding: const pw.EdgeInsets.all(5.0),
                                                    child: pw.Text('Party Name',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                  )
                                              ),
                                              pw.Expanded(
                                                  child: pw.Padding(
                                                    padding: const pw.EdgeInsets.all(5.0),
                                                    child: pw.Text('Product',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                  )
                                              ),
                                              pw.Expanded(
                                                  child: pw.Padding(
                                                    padding: const pw.EdgeInsets.all(5.0),
                                                    child: pw.Text('Comment',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                  )
                                              ),
                                              pw.Expanded(
                                                  child: pw.Padding(
                                                    padding: const pw.EdgeInsets.all(5.0),
                                                    child: pw.Text('Total',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                  )
                                              ),
                                            ]
                                        )
                                    ),
                                    ///Advance Deposit  table body
                                    pw.Padding(
                                        padding:const pw.EdgeInsets.symmetric(horizontal: 7.0),
                                        child: pw.ListView.separated(
                                            itemCount: 5,
                                            itemBuilder: (context, index)=>pw.Row(
                                                children: [
                                                  pw.Container(
                                                    child: pw.Text('${index+1}',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                    alignment: pw.Alignment.center,
                                                    padding: const pw.EdgeInsets.all(2.0),
                                                    width: 30.0,
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(2.0),
                                                        child: pw.Text('Party Name',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(2.0),
                                                        child: pw.Text('Product',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(2.0),
                                                        child: pw.Text('Comment',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(2.0),
                                                        child: pw.Text('Total',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                ]
                                            ),
                                            separatorBuilder:(context, index)=>pw.Divider(thickness: 0.2,height: 0.0))
                                    ),
                                    pw.Padding(
                                        padding:const pw.EdgeInsets.symmetric(horizontal: 7.0),
                                        child: pw.Divider(thickness: 0.2,height: 0.0)
                                    ),
                                    ///Table Footer
                                    pw.Row(
                                        children: [
                                          pw.Expanded(
                                              child: pw.Padding(
                                                padding: const pw.EdgeInsets.symmetric(vertical: 2.0,horizontal: 10),
                                                child: pw.Text('Total Deposit',style: boldTextStyle.copyWith(color: PdfColors.purple),textAlign: pw.TextAlign.left),
                                              )
                                          ),
                                          pw.Container(
                                            child: pw.Text('195121',style: boldTextStyle.copyWith(color: PdfColors.purple),textAlign: pw.TextAlign.right),
                                            alignment: pw.Alignment.centerRight,
                                            padding: const pw.EdgeInsets.symmetric(vertical: 2.0,horizontal: 10),
                                            width: 50.0,
                                          )
                                        ]
                                    )

                                  ]
                              )
                            ]
                          )
                        ),
                      ),



                      ///Divider
                      pw.SizedBox(width: 15.0),



                      ///Right Section****************************************
                      pw.Expanded(
                        child: pw.Container(
                            decoration: pw.BoxDecoration(
                                color: PdfColors.grey100,
                                borderRadius:const pw.BorderRadius.all(pw.Radius.circular(5)),
                                border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                            ),
                            child: pw.Column(
                                children: [
                                  ///Title:::::::::::::::::::::::::::::::::::::::
                                  pw.Padding(
                                      padding: const pw.EdgeInsets.all(5),
                                      child: pw.Text('খরচ',style: boldTextStyle,textAlign: pw.TextAlign.center)
                                  ),
                                  pw.Divider(thickness: 0.5,height: 0.0),

                                  ///Body:::::::::::::::::::::::::::::::::::::::
                                  pw.Column(
                                      children:[
                                        ///Sales Title====================================
                                        pw.SizedBox(height: 10.0),
                                        pw.Container(
                                            padding: const pw.EdgeInsets.all(5.0),
                                            margin: const pw.EdgeInsets.symmetric(horizontal: 5.0),
                                            width: double.maxFinite,
                                            decoration: pw.BoxDecoration(
                                                color: PdfColors.grey800,
                                                borderRadius:const pw.BorderRadius.all(pw.Radius.circular(2)),
                                                border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                                            ),
                                            child: pw.Text('Sales:',style: boldTextStyle.copyWith(color: PdfColors.white))
                                        ),
                                        ///Sales Table header
                                        pw.Container(
                                            margin: const pw.EdgeInsets.symmetric(horizontal: 5.0),
                                            width: double.maxFinite,
                                            decoration: pw.BoxDecoration(
                                                color: PdfColors.blueGrey50,
                                                borderRadius:const pw.BorderRadius.all(pw.Radius.circular(2)),
                                                border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                                            ),
                                            child: pw.Row(
                                                children: [
                                                  pw.Container(
                                                    child: pw.Text('#',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                    alignment: pw.Alignment.center,
                                                    padding: const pw.EdgeInsets.all(5.0),
                                                    width: 30.0,
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(5.0),
                                                        child: pw.Text('Party Name',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(5.0),
                                                        child: pw.Text('Bill No',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(5.0),
                                                        child: pw.Text('Check No',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(5.0),
                                                        child: pw.Text('Total',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                ]
                                            )
                                        ),
                                        ///Sales table body
                                        pw.Padding(
                                            padding:const pw.EdgeInsets.symmetric(horizontal: 7.0),
                                            child: pw.ListView.separated(
                                                itemCount: 5,
                                                itemBuilder: (context, index)=>pw.Row(
                                                    children: [
                                                      pw.Container(
                                                        child: pw.Text('${index+1}',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                        alignment: pw.Alignment.center,
                                                        padding: const pw.EdgeInsets.all(2.0),
                                                        width: 30.0,
                                                      ),
                                                      pw.Expanded(
                                                          child: pw.Padding(
                                                            padding: const pw.EdgeInsets.all(2.0),
                                                            child: pw.Text('Party Name',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                          )
                                                      ),
                                                      pw.Expanded(
                                                          child: pw.Padding(
                                                            padding: const pw.EdgeInsets.all(2.0),
                                                            child: pw.Text('Bill No',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                          )
                                                      ),
                                                      pw.Expanded(
                                                          child: pw.Padding(
                                                            padding: const pw.EdgeInsets.all(2.0),
                                                            child: pw.Text('Check No',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                          )
                                                      ),
                                                      pw.Expanded(
                                                          child: pw.Padding(
                                                            padding: const pw.EdgeInsets.all(2.0),
                                                            child: pw.Text('Total',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                          )
                                                      ),
                                                    ]
                                                ),
                                                separatorBuilder:(context, index)=>pw.Divider(thickness: 0.2,height: 0.0))
                                        ),
                                        pw.Padding(
                                            padding:const pw.EdgeInsets.symmetric(horizontal: 7.0),
                                            child: pw.Divider(thickness: 0.2,height: 0.0)
                                        ),

                                        ///All Expense Title====================================
                                        pw.Container(
                                            padding: const pw.EdgeInsets.all(5.0),
                                            margin: const pw.EdgeInsets.symmetric(horizontal: 5.0),
                                            width: double.maxFinite,
                                            decoration: pw.BoxDecoration(
                                                color: PdfColors.grey800,
                                                borderRadius:const pw.BorderRadius.all(pw.Radius.circular(2)),
                                                border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                                            ),
                                            child: pw.Text('All Expense:',style: boldTextStyle.copyWith(color: PdfColors.white))
                                        ),
                                        ///All Expense Table header
                                        pw.Container(
                                            margin: const pw.EdgeInsets.symmetric(horizontal: 5.0),
                                            width: double.maxFinite,
                                            decoration: pw.BoxDecoration(
                                                color: PdfColors.blueGrey50,
                                                borderRadius:const pw.BorderRadius.all(pw.Radius.circular(2)),
                                                border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                                            ),
                                            child: pw.Row(
                                                children: [
                                                  pw.Container(
                                                    child: pw.Text('#',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                    alignment: pw.Alignment.center,
                                                    padding: const pw.EdgeInsets.all(5.0),
                                                    width: 30.0,
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(5.0),
                                                        child: pw.Text('Party Name',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(5.0),
                                                        child: pw.Text('Category',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(5.0),
                                                        child: pw.Text('Comment',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                  pw.Expanded(
                                                      child: pw.Padding(
                                                        padding: const pw.EdgeInsets.all(5.0),
                                                        child: pw.Text('Total',style: boldTextStyle,textAlign: pw.TextAlign.center),
                                                      )
                                                  ),
                                                ]
                                            )
                                        ),
                                        ///All Expense  table body
                                        pw.Padding(
                                            padding:const pw.EdgeInsets.symmetric(horizontal: 7.0),
                                            child: pw.ListView.separated(
                                                itemCount: 5,
                                                itemBuilder: (context, index)=>pw.Row(
                                                    children: [
                                                      pw.Container(
                                                        child: pw.Text('${index+1}',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                        alignment: pw.Alignment.center,
                                                        padding: const pw.EdgeInsets.all(2.0),
                                                        width: 30.0,
                                                      ),
                                                      pw.Expanded(
                                                          child: pw.Padding(
                                                            padding: const pw.EdgeInsets.all(2.0),
                                                            child: pw.Text('Party Name',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                          )
                                                      ),
                                                      pw.Expanded(
                                                          child: pw.Padding(
                                                            padding: const pw.EdgeInsets.all(2.0),
                                                            child: pw.Text('Product',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                          )
                                                      ),
                                                      pw.Expanded(
                                                          child: pw.Padding(
                                                            padding: const pw.EdgeInsets.all(2.0),
                                                            child: pw.Text('Comment',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                          )
                                                      ),
                                                      pw.Expanded(
                                                          child: pw.Padding(
                                                            padding: const pw.EdgeInsets.all(2.0),
                                                            child: pw.Text('Total',style: normalTextStyle,textAlign: pw.TextAlign.center),
                                                          )
                                                      ),
                                                    ]
                                                ),
                                                separatorBuilder:(context, index)=>pw.Divider(thickness: 0.2,height: 0.0))
                                        ),
                                        pw.Padding(
                                            padding:const pw.EdgeInsets.symmetric(horizontal: 7.0),
                                            child: pw.Divider(thickness: 0.2,height: 0.0)
                                        ),
                                        ///Table Footer
                                        pw.Row(
                                            children: [
                                              pw.Expanded(
                                                  child: pw.Padding(
                                                    padding: const pw.EdgeInsets.symmetric(vertical: 2.0,horizontal: 10),
                                                    child: pw.Text('Total Expense',style: boldTextStyle.copyWith(color: PdfColors.purple),textAlign: pw.TextAlign.left),
                                                  )
                                              ),
                                              pw.Container(
                                                child: pw.Text('195121',style: boldTextStyle.copyWith(color: PdfColors.purple),textAlign: pw.TextAlign.right),
                                                alignment: pw.Alignment.centerRight,
                                                padding: const pw.EdgeInsets.symmetric(vertical: 2.0,horizontal: 10),
                                                width: 50.0,
                                              )
                                            ]
                                        )

                                      ]
                                  )
                                ]
                            )
                        ),
                      ),
                    ]
                ),
                pw.SizedBox(height: 20.0),



                ///Footer Section
                pw.Center(
                  child: pw.Container(
                    width: 300.0,
                    padding: const pw.EdgeInsets.symmetric(horizontal: 5.0,vertical: 20),
                    decoration: pw.BoxDecoration(
                        color: PdfColors.grey100,
                        borderRadius:const pw.BorderRadius.all(pw.Radius.circular(5)),
                        border: pw.Border.all(color: PdfColors.grey,width: 0.5)
                    ),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text('মোট জমা: 195121/=',style: boldTextStyle,textAlign: pw.TextAlign.center),
                        pw.Text('মোট খরচ: 61530/=',style: boldTextStyle,textAlign: pw.TextAlign.center),
                        pw.Divider(thickness: 0.2),
                        pw.Text('Cash: 133591/=',style: boldTextStyle,textAlign: pw.TextAlign.center),
                      ]
                    )
                  )
                )
              ];
            }
        )
    );

    try{
      final directory = await DownloadsPathProvider.downloadsDirectory;
      final String fileName = 'Deposit-Expense-${DateTime.now().millisecondsSinceEpoch}.pdf';
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