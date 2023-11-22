import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:povshotnbk/theme.dart';


import '../network/api/url_api.dart';

class PaymentDetail extends StatefulWidget {
  final dynamic data;

  PaymentDetail({Key? key, required this.data}) : super(key: key);

  @override
  _PaymentDetailState createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  bool isProcessing = false;

  void updateOrderStatus() async {
    setState(() {
      isProcessing = true;
    });

    try {
      var response = await http.post(
        Uri.parse(BASEURL.apiConfirm), // Replace with your URL
      );

      if (response.statusCode == 200) {
        print('Status pesanan telah diperbarui.');
        // Add your logic or actions after updating the order status
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Status Pesanan'),
            content: Text('Pesanan telah dikonfirmasi.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print(
            'Terjadi kesalahan saat memperbarui status pesanan: ${response.body}');
      }
    } catch (error) {
      print('Terjadi kesalahan saat memperbarui status pesanan: $error');
    }

    setState(() {
      isProcessing = false;
    });
  }

  void cancelOrderStatus() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi Pembatalan Pesanan'),
        content: Text('Apakah Anda yakin ingin membatalkan pesanan ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Tidak'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close the dialog

              setState(() {
                isProcessing = true;
              });

              try {
                var response = await http.post(
                  Uri.parse(BASEURL.apiCancel), // Replace with your URL
                );

                if (response.statusCode == 200) {
                  print('Status pesanan telah diperbarui.');
                  // Add your logic or actions after updating the order status
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Status Pesanan'),
                      content: Text('Pesanan telah dibatalkan.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  print(
                      'Terjadi kesalahan saat memperbarui status pesanan: ${response.body}');
                }
              } catch (error) {
                print(
                    'Terjadi kesalahan saat memperbarui status pesanan: $error');
              }

              setState(() {
                isProcessing = false;
              });
            },
            child: Text('Ya'),
          ),
        ],
      ),
    );
  }

  final String apiBukti = BASEURL.apiBukti;

  @override
  Widget build(BuildContext context) {
    String imageUrl = apiBukti + widget.data['bukti_pembayaran'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        title: Text('Payment Detail'),
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
                    'ID Pesanan: ${widget.data['id_pesanan']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Atas Nama: ${widget.data['atas_nama']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Bank: ${widget.data['bank']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tanggal Pembayaran: ${widget.data['tanggal_pembayaran']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Gambar Pembayaran:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Add your logic to display the image preview
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    child: Container(
                      width: 600,
                      height: 600,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                height: 200,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        cancelOrderStatus();
                        // Add your logic to handle cancel button action
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text('Batalkan'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        updateOrderStatus();
                        // Add your logic to handle confirm button action
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: Text('Konfirmasi'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
