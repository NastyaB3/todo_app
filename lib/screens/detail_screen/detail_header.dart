import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/common/res/theme/theme.dart';
import 'package:todo_app/common/res/theme/todo_text_theme.dart';
import 'package:todo_app/domain/details_cubit/detail_cubit.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/main_core.dart';

class DetailHeader extends StatelessWidget {
  final VoidCallback onPressed;

  const DetailHeader({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsTheme>();
    final textStyles = Theme.of(context).extension<TodoTextTheme>();
    return AppBar(
      elevation: 0,
      backgroundColor: colors!.backPrimaryColor,
      leading: InkWell(
        onTap: () {
         router.popRoute();
        },
        child: Icon(
          Icons.close,
          color: colors.primaryColor,
        ),
      ),
      actions: [
        BlocConsumer<DetailCubit, DetailState>(
          listener: (context, state) {
            if (state is DetailSuccess) {
             router.popRoute();
            }
          },
          builder: (context, state) {
            if (state is DetailLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 16,
                  ),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return TextButton(
              onPressed: onPressed,
              child: Text(
                S.of(context).save,
                style: textStyles!.button!.copyWith(color: colors.blueColor),
              ),
            );
          },
        ),
      ],
    );
  }
}
