import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../network/api/url_api.dart';
// import '../theme.dart';
import 'product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<dynamic> dataList = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        refreshData();
      }
    });
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(BASEURL.apiListGambar));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)["data"];
        setState(() {
          dataList = data;
        });
      } else {
        throw Exception('Gagal mengambil data Product');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> refreshData() async {
    await fetchData();
    _scrollToBottom();
  }

  void navigateToDetailPage(dynamic data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetail(data: data),
      ),
    );
  }

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: dataList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: scrollController,
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
                            'id : ${data['id'].toString()}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              Text('judul : ${data['title']}'),
                              SizedBox(height: 4),
                              Text('deskripsi : ${data['description']}'),
                              SizedBox(height: 2),
                              Text('gambar_watermark: ${data['image_watermark']}'),
                              SizedBox(height: 2),
                              Text('gambar asli: ${data['image_original']}'),
                              SizedBox(height: 4),
                              Text('harga : ${data['price']}'),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
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
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _scrollToBottom,
      //   child: Icon(Icons.refresh),
      //   backgroundColor: blackColor,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
