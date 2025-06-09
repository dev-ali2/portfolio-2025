import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_2025/app/testimonial/presentation/controllers/testimonial_controller.dart';
import 'package:portfolio_2025/core/common/controllers/data_controller.dart';
import 'package:portfolio_2025/core/common/keys/widget_keys.dart';
import 'package:portfolio_2025/core/common/models/testimonial_model.dart';
import 'package:portfolio_2025/core/common/widgets/pages_header.dart';
import 'package:portfolio_2025/helpers/colors_helper.dart';
import 'package:portfolio_2025/helpers/fonts_helper.dart';
import 'package:portfolio_2025/helpers/mq_helper.dart';

class TTestimonialPage extends StatelessWidget {
  TTestimonialPage({super.key});

  final dataController = Get.find<DataController>();
  final testimonialController = Get.put(TestimonialController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MqHelper>(
      id: 'canvas options',
      builder: (controller) {
        int itemsPerPage = MqHelper.width >= 1290
            ? 3
            : MqHelper.width >= 900
                ? 2
                : 1;
        final maxPages =
            ((dataController.siteData?.testimonial.testimonials.length ?? 0) /
                    itemsPerPage)
                .ceil();

        if (dataController.siteData!.testimonial.isEnabled == false ||
            dataController.siteData!.testimonial.testimonials.isEmpty ||
            maxPages == 0) {
          return const SizedBox.shrink();
        }
        return Container(
          key: testimonialsPageKey,
          width: MqHelper.width,
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
          child: Column(
            spacing: 40,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PagesHeader(title: 'Endorsements'),

              SizedBox(
                height: 280,
                child: Row(
                  children: [
                    // Left Arrow
                    Obx(() => IconButton(
                          style: IconButton.styleFrom(
                              overlayColor: Colors.transparent),
                          onPressed:
                              testimonialController.currentCarouselIndex.value >
                                      0
                                  ? testimonialController.previousCarouselPage
                                  : null,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: testimonialController
                                        .currentCarouselIndex.value >
                                    0
                                ? ColorsHelper.defaultPrimaryColor
                                : Colors.grey,
                            size: 30,
                          ),
                        )),

                    // Carousel Content
                    Expanded(
                      child: PageView.builder(
                        controller: testimonialController.pageController,
                        onPageChanged: testimonialController.onPageChanged,
                        itemCount: maxPages,
                        itemBuilder: (context, pageIndex) {
                          final startIndex = pageIndex * itemsPerPage;
                          final endIndex = (startIndex + itemsPerPage).clamp(
                              0,
                              dataController.siteData?.testimonial.testimonials
                                      .length ??
                                  0);
                          final pageEndorsements = dataController
                              .siteData?.testimonial.testimonials
                              .sublist(startIndex, endIndex);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: pageEndorsements!
                                .map((endorsement) =>
                                    _buildEndorsementCard(endorsement))
                                .toList(),
                          );
                        },
                      ),
                    ),

                    // Right Arrow
                    Obx(() => IconButton(
                          style: IconButton.styleFrom(
                              overlayColor: Colors.transparent),
                          onPressed:
                              testimonialController.currentCarouselIndex.value <
                                      maxPages - 1
                                  ? () => testimonialController
                                      .nextCarouselPage(maxPages)
                                  : null,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: testimonialController
                                        .currentCarouselIndex.value <
                                    maxPages - 1
                                ? ColorsHelper.defaultPrimaryColor
                                : Colors.grey,
                            size: 30,
                          ),
                        )),
                  ],
                ),
              ),

              // Page indicators
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      maxPages,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: testimonialController
                                      .currentCarouselIndex.value ==
                                  index
                              ? ColorsHelper.defaultPrimaryColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEndorsementCard(TestimonialData testimonial) {
    return Container(
      width: 350,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 11, 62, 109),
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(10),
        color: ColorsHelper.secondaryCanvasColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (testimonial.imageUrl != null)
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(testimonial.imageUrl ?? ''),
              onBackgroundImageError: (exception, stackTrace) {
                // Handle image loading error
              },
            ),
          const SizedBox(height: 5),
          SelectableText(
            testimonial.name,
            style: FontsHelper.poppinsFont.copyWith(
              color: ColorsHelper.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              height: 0.7,
              wordSpacing: 1.2,
            ),
          ),
          if (testimonial.position != null)
            SelectableText(
              testimonial.position ?? '',
              style: FontsHelper.fontUbuntu.copyWith(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          const SizedBox(height: 5),
          SelectableText(
            '"${testimonial.testimonial}"',
            minLines: 4,
            maxLines: 4,
            style: FontsHelper.fontUbuntu.copyWith(
              color: ColorsHelper.white,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
