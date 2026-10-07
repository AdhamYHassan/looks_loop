import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';
import 'package:looks_loop/core/theming/styles.dart';
import 'package:looks_loop/features/orders/domain/entities/order_address_entity.dart';

class OrderAddressSection extends StatelessWidget {
  final OrderAddressEntity address;

  const OrderAddressSection({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.getCard(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.getBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'orders.delivery_address'.tr(),
            style: TextStyles.font11SemiBold(context).copyWith(
              letterSpacing: 1.2,
              color: ColorManager.getTextMuted(context),
            ),
          ),
          Gap(12.h),
          if (address.fullName.isNotEmpty) ...[
            Text(
              address.fullName,
              style: TextStyles.font14SemiBold(context),
            ),
            Gap(4.h),
          ],
          if (address.fullAddress.isNotEmpty) ...[
            Text(
              address.fullAddress,
              style: TextStyles.font13Regular(context).copyWith(
                color: ColorManager.getTextMuted(context),
              ),
            ),
          ] else ...[
            Text(
              '${address.street}, ${address.building}, ${address.area}, ${address.city}',
              style: TextStyles.font13Regular(context).copyWith(
                color: ColorManager.getTextMuted(context),
              ),
            ),
          ],
          if (address.phone.isNotEmpty) ...[
            Gap(4.h),
            Text(
              address.phone,
              style: TextStyles.font13Regular(context).copyWith(
                color: ColorManager.getTextMuted(context),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
