import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../../main.dart';

class PDFPage extends StatefulWidget  {
  final ThemeData theme;
  final Pages page;

  const PDFPage(this.theme, this.page);

  @override
  _PDFPageState createState() => _PDFPageState();
}

class _PDFPageState extends State<PDFPage> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  _print() async {
    final pdf = await rootBundle.load('assets/pdf/'+_returnFileName()+'.pdf');
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.buffer.asUint8List());
  }

  _share() async {
    final pdf = await rootBundle.load('assets/pdf/'+_returnFileName()+'.pdf');
    await Printing.sharePdf(bytes: pdf.buffer.asUint8List(), filename: _returnName()+'.pdf');
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/pdf/'+_returnFileName()+'.pdf');

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Назад',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(_returnName(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          actions: [
            IconButton(
              icon: Icon(Icons.print),
              tooltip: "Печать",
              onPressed: () {
                _print();
              },
            ),
            IconButton(
              icon: Icon(Icons.share),
              tooltip: "Поделиться",
              onPressed: () {
                _share();
              },
            ),
          ],
          centerTitle: true,
        ),
        body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
                document: document,
                zoomSteps: 1,
                lazyLoad: false,
                scrollDirection: Axis.vertical,
                showPicker: false,
                navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          tooltip: "На первую страницу",
                          onPressed: page == 1 ? null : () {
                            jumpToPage(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          tooltip: "Предыдущая",
                          onPressed: page == 1 ? null : () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          tooltip: "Следующая",
                          onPressed: page == totalPages ? null : () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          tooltip: "На последнюю страницу",
                          onPressed: page == totalPages ? null : () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    );
                  },
          ),
        ),
    );
  }

  String _returnName() {
    String text;
    switch (widget.page) {
      case Pages.SEASON1:
        text = "1 сезон";
        break;
      case Pages.SEASON2:
        text = "2 сезон";
        break;
      case Pages.SEASON3:
        text = "3 сезон";
        break;
      case Pages.SEASON4:
        text = "4 сезон";
        break;
      case Pages.SEASON5:
        text = "5 сезон";
        break;
      case Pages.SEASON6:
        text = "6 сезон";
        break;
    }
    return text;
  }

  String _returnFileName() {
    String text;
    switch (widget.page) {
      case Pages.SEASON1:
        text = "1s";
        break;
      case Pages.SEASON2:
        text = "2s";
        break;
      case Pages.SEASON3:
        text = "3s";
        break;
      case Pages.SEASON4:
        text = "4s";
        break;
      case Pages.SEASON5:
        text = "5s";
        break;
      case Pages.SEASON6:
        text = "6s";
        break;
    }
    return text;
  }
}