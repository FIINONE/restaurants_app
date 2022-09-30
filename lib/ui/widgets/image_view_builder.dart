import 'package:flutter/material.dart';
import 'package:test_restaurants_app/common/themes/app_colors.dart';
import 'package:test_restaurants_app/common/themes/app_text_styles.dart';
import 'package:test_restaurants_app/common/utils/validator.dart';
import 'package:test_restaurants_app/data/models/image_model.dart';

class ImageViewBuilder extends StatelessWidget {
  const ImageViewBuilder({
    Key? key,
    required this.width,
    required this.height,
    required this.restaurantImages,
  }) : super(key: key);

  final double width;
  final double height;
  final List<ImageModel> restaurantImages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: PageView.builder(
        itemCount: restaurantImages.length,
        itemBuilder: (context, index) {
          final image = restaurantImages[index];

          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            clipBehavior: Clip.hardEdge,
            child: ValidatorUtil.instance.isLink(image.url)
                ? Image.network(
                    image.url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey_3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'Фото',
                          style: AppTextStyles.regular.copyWith(color: AppColors.grey_2),
                        ),
                      ),
                    ),
                  )
                : Image.asset(
                    image.url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey_3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'Фото',
                          style: AppTextStyles.regular.copyWith(color: AppColors.grey_2),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
