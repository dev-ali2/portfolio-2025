class TestimonialModel {
  bool isEnabled;
  String headerTitle;
  List<TestimonialData> testimonials;

  TestimonialModel({
    required this.isEnabled,
    required this.headerTitle,
    required this.testimonials,
  });

  TestimonialModel.fromJson(Map<String, dynamic> json)
    : isEnabled = json['isEnabled'] ?? false,
      headerTitle = json['headerTitle'] ?? '',
      testimonials = (json['testimonials'] as List<dynamic>)
          .map((item) => TestimonialData.fromJson(item as Map<String, dynamic>))
          .toList();

  Map<String, dynamic> toJson() {
    return {
      'isEnabled': isEnabled,
      'headerTitle': headerTitle,
      'testimonials': testimonials.map((item) => item.toJson()).toList(),
    };
  }
}

class TestimonialData {
  String name;
  String? position;
  String? imageUrl;
  String testimonial;

  TestimonialData({
    required this.name,
    this.position,
    this.imageUrl,
    required this.testimonial,
  });

  TestimonialData.fromJson(Map<String, dynamic> json)
    : name = json['name'] ?? '',
      position = json['position'],
      imageUrl = json['imageUrl'],
      testimonial = json['testimonial'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'imageUrl': imageUrl,
      'testimonial': testimonial,
    };
  }
}
