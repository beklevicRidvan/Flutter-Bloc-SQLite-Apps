class Not {
  int? notID; // Not kimliği
  int kategoriID; // Notun ait olduğu kategori kimliği
  String notBaslik; // Not başlığı
  String? kategoriBaslik;
  String? notIcerik; // Not içeriği
  String notTarih; // Not tarihi
  int notOncelik; // Not önceliği

  Not(this.kategoriID, this.notBaslik, this.notIcerik, this.notTarih, this.notOncelik);


  Not.withID(this.notID, this.kategoriID, this.notBaslik,
      this.notIcerik, this.notTarih, this.notOncelik);

  Map<String, dynamic> toMap() {
    return {
      "notID": notID,
      "kategoriID": kategoriID,
      "notBaslik": notBaslik,
      "notIcerik": notIcerik,
      "notTarih": notTarih,
      "notOncelik": notOncelik,
    };
  }

  Not.fromMap(Map<String, dynamic> map)
      : notID = map["notID"],
        kategoriID = map["kategoriID"],
        notBaslik = map["notBaslik"],
        notIcerik = map["notIcerik"],
        notTarih = map["notTarih"],
        notOncelik = map["notOncelik"],
        kategoriBaslik = map["kategoriBaslik"];

  @override
  String toString() {
    return 'Not{id: $notID, kategoriID: $kategoriID, baslik: $notBaslik, icerik: $notIcerik, tarih: $notTarih, oncelik: $notOncelik}';
  }



}
