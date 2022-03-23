import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:tashfia_export/variables/variable.dart';
import '../util/decoration.dart';
import '../variables/color_variable.dart';

class ViewPdfPage extends StatefulWidget {
  const ViewPdfPage({Key? key,required this.filePath,required this.fileName}) : super(key: key);
  final String filePath;
  final String fileName;

  @override
  State<ViewPdfPage> createState() => _ViewPdfPageState();
}

class _ViewPdfPageState extends State<ViewPdfPage> {
  bool isReady=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName, style:StDecoration.boldTextStyle),
        backgroundColor: AllColor.appBgColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: IconThemeData(color: Colors.grey.shade800),
      ),
      body: PDFView(
        filePath: widget.filePath,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onRender: (_pages) {
          setState(()=> isReady = true);
        },
        onError: (error) {
          showToast(error.toString());
        },
        onPageError: (page, error) {
          showToast(error.toString());
        },
      ),
    );
  }
}
