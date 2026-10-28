import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:looks_loop/core/helpers/url_launcher_helper.dart';
import 'package:looks_loop/core/widgets/app_snack_bar.dart';
import 'package:looks_loop/features/more/presentation/bloc/contact_us_cubit.dart';
import 'package:looks_loop/features/more/presentation/bloc/contact_us_state.dart';

class ContactUsListener extends StatelessWidget {
  final Widget child;

  const ContactUsListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactUsCubit, ContactUsState>(
      listener: (context, state) async {
        if (state is ContactUsSuccess) {
          final mobile = state.contactUs.mobile;
          if (mobile.trim().isNotEmpty) {
            final launched = await UrlLauncherHelper.openWhatsApp(mobile);
            if (!launched && context.mounted) {
              AppSnackBar.showError(
                context,
                message: 'Could not open WhatsApp',
              );
            }
          } else {
            AppSnackBar.showError(
              context,
              message: 'No WhatsApp contact available',
            );
          }
        } else if (state is ContactUsError) {
          AppSnackBar.showError(context, message: state.message);
        }
      },
      child: child,
    );
  }
}

