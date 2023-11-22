
class productModel {

  final String idPesanan;
  final String atasNama;
  final String bank;
  final String tanggalPembayaran;
  final String buktiPembayaran;

  productModel({
    required this.idPesanan, 
    required this.atasNama, 
    required this.bank,
    required this.tanggalPembayaran, 
    required this.buktiPembayaran});

  
  

  factory productModel.fromJson(Map<String, dynamic> data){
    return productModel(
      idPesanan: data['id_pesanan'],
      atasNama: data['atas_nama'],
      bank: data['bank'],
      tanggalPembayaran: data['tanggal_pembayaran'],
      buktiPembayaran: data['bukti_pembayaran']

    );
}
}