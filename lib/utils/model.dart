class ImagesData {
  int? status;
  int? statusCoded;
  List<ImgData>? data;

  ImagesData({this.status, this.statusCoded, this.data});

  ImagesData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCoded = json['status_coded'];
    if (json['data'].isNotEmpty) {
      data = <ImgData>[];
      try{
        json['data'].forEach((k,v) {
          data!.add(ImgData.fromJson(v));
        });
      }catch(e){
        json['data'].forEach((v) {
          data!.add(ImgData.fromJson(v));
        });
        print(e);
      }

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['status_coded'] = statusCoded;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImgData {
  int? id;
  String? title;
  int? price;
  int? rating;
  String? address;
  String? image;
  int? likes;
  String? type;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  ImgData(
      {this.id,
      this.title,
      this.price,
      this.rating,
      this.address,
      this.image,
      this.likes,
      this.type,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  ImgData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    rating = json['rating'];
    address = json['address'];
    image = json['image'];
    likes = json['likes'];
    type = json['type'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['rating'] = rating;
    data['address'] = address;
    data['image'] = image;
    data['likes'] = likes;
    data['type'] = type;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
