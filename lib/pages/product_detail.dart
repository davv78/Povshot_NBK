import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:povshotnbk/theme.dart';

import '../network/api/url_api.dart';

class ProductDetail extends StatefulWidget {
  final dynamic data;

  ProductDetail({Key? key, required this.data}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isProcessing = false;

  final String apiImageWM = BASEURL.apiImageWM;
  final String apiImageORI = BASEURL.apiImageORI;

  Future<void> deleteData() async {
    setState(() {
      isProcessing = true;
    });

    try {
      int id = int.parse(widget.data['id']);
      var url = Uri.parse(BASEURL.apiDeleteProduct);
      var response = await http.post(url, body: {'id': id.toString()});

      if (response.statusCode == 200) {
        print('Data berhasil dihapus');
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Sukses'),
            content: Text('Data berhasil dihapus'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Menutup dialog
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Gagal menghapus data. Error: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin menghapus gambar ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog konfirmasi
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: deleteData,
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String imageWM = apiImageWM + widget.data['image_watermark'];
    String imageORI = apiImageORI + widget.data['image_original'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Gambar'),
        backgroundColor: blackColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Judul  : ${widget.data['title']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Deskripsi: ${widget.data['description']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Harga : ${widget.data['price']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Gambar Product:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: Container(
                            width: 600,
                            height: 600,
                            child: Image.network(
                              imageWM,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      imageWM,
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: Container(
                            width: 600,
                            height: 600,
                            child: Image.network(
                              imageORI,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      imageORI,
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            isProcessing
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _showConfirmationDialog,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.red,
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
