class ContactSectionModel {
  bool isEnabled;
  String callToActionLine;
  String? githubLink;
  String? linkedinLink;
  String? emailLink;
  String? twitterLink;
  String? instagramLink;
  String? facebookLink;
  String? whatsappLink;
  String? downloadResumeLink;
  String footerLine;

  ContactSectionModel({
    required this.isEnabled,
    required this.callToActionLine,
    this.githubLink,
    this.linkedinLink,
    this.emailLink,
    this.twitterLink,
    this.instagramLink,
    this.facebookLink,
    this.whatsappLink,
    this.downloadResumeLink,
    required this.footerLine,
  });

  factory ContactSectionModel.fromJson(Map<String, dynamic> json) {
    return ContactSectionModel(
      isEnabled: json['isEnabled'] ?? true,
      callToActionLine: json['callToActionLine'],
      githubLink: json['githubLink'],
      linkedinLink: json['linkedinLink'],
      emailLink: json['emailLink'],
      twitterLink: json['twitterLink'],
      instagramLink: json['instagramLink'],
      facebookLink: json['facebookLink'],
      whatsappLink: json['whatsappLink'],
      downloadResumeLink: json['downloadResumeLink'],
      footerLine: json['footerLine'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isEnabled': isEnabled,
      'callToActionLine': callToActionLine,
      'githubLink': githubLink,
      'linkedinLink': linkedinLink,
      'emailLink': emailLink,
      'twitterLink': twitterLink,
      'instagramLink': instagramLink,
      'facebookLink': facebookLink,
      'whatsappLink': whatsappLink,
      'downloadResumeLink': downloadResumeLink,
      'footerLine': footerLine,
    };
  }
}
