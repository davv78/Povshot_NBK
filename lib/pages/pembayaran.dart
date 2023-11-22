import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../network/api/url_api.dart';
import 'payment_detail.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<dynamic> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(BASEURL.apiPayment));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)["data"];
        setState(() {
          dataList = data;
        });
      } else {
        throw Exception('Gagal mengambil data pembayaran.');
      }
    } catch (error) {
      print(error);
    }
  }

  void navigateToDetailPage(dynamic data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentDetail(data: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                var data = dataList[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          'ID Pesanan: ${data['id_pesanan']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text('Atas Nama: ${data['atas_nama']}'),
                            SizedBox(height: 2),
                            Text('Bank: ${data['bank']}'),
                            SizedBox(height: 2),
                            Text('Tanggal Pembayaran: ${data['tanggal_pembayaran']}'),
                            SizedBox(height: 4),
                            Text('Bukti Pembayaran: ${data['bukti_pembayaran']}'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 16, bottom: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              navigateToDetailPage(data);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.black,
                              ),
                            ),
                            child: Text(
                              'Detail',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
