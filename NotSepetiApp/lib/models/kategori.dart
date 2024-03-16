class Kategori {
  int? kategoriID; // Kategori kimliği
  String kategoriBaslik; // Kategori başlığı

  Kategori(this.kategoriBaslik);


  Map<String, dynamic> toMap() {
    return {
      "kategoriID": kategoriID,
      "kategoriBaslik": kategoriBaslik,
    };
  }

  Kategori.fromMap(Map<String, dynamic> map)
      : kategoriID = map["kategoriID"],
        kategoriBaslik = map["kategoriBaslik"];


  Kategori.withID(this.kategoriID, this.kategoriBaslik);

  @override
  String toString() {
    return 'Kategori{id: $kategoriID, baslik: $kategoriBaslik}';
  }
}
