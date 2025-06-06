import 'package:portfolio_2025/core/common/models/about_model.dart';
import 'package:portfolio_2025/core/common/models/blog_model.dart';
import 'package:portfolio_2025/core/common/models/contact_section_model.dart';
import 'package:portfolio_2025/core/common/models/featured_work_model.dart';
import 'package:portfolio_2025/core/common/models/landing_page_model.dart';
import 'package:portfolio_2025/core/common/models/tech_stack_model.dart';
import 'package:portfolio_2025/core/common/models/work_experience_model.dart';

class DataModel {
  bool isSiteEnabled;

  bool followMousePosition;

  LandingPageModel landingPageModel;
  AboutModel about;
  TechStackModel tech;
  FeaturedWorkModel featuredWork;
  WorkExperienceModel workExperience;
  BlogModel blog;
  ContactSectionModel contactSection;

  DataModel({
    required this.isSiteEnabled,
    required this.followMousePosition,
    required this.landingPageModel,
    required this.about,
    required this.tech,
    required this.featuredWork,
    required this.workExperience,
    required this.blog,
    required this.contactSection,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      isSiteEnabled: json['isSiteEnabled'] ?? true,
      followMousePosition: json['followMousePosition'] ?? true,
      landingPageModel: LandingPageModel.fromJson(json['landingPageModel']),
      about: AboutModel.fromJson(json['about']),
      tech: TechStackModel.fromJson(json['tech']),
      featuredWork: FeaturedWorkModel.fromJson(json['featuredWork']),
      workExperience: WorkExperienceModel.fromJson(json['workExperience']),
      blog: BlogModel.fromJson(json['blog']),
      contactSection: ContactSectionModel.fromJson(json['contactSection']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSiteEnabled': isSiteEnabled,
      'followMousePosition': followMousePosition,
      'landingPageModel': landingPageModel.toJson(),
      'about': about.toJson(),
      'tech': tech.toJson(),
      'featuredWork': featuredWork.toJson(),
      'workExperience': workExperience.toJson(),
      'blog': blog.toJson(),
      'contactSection': contactSection.toJson(),
    };
  }
}
