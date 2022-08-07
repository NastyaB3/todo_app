import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/res/theme/theme.dart';
import 'package:todo_app/common/res/theme/todo_text_theme.dart';
import 'package:todo_app/domain/details_cubit/detail_cubit.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/navigation/controller.dart';

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
          context.read<NavigationController>().pop();
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
              context.read<NavigationController>().pop();
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
              // onPressed: () async {
              //   FocusScope.of(context).requestFocus(FocusNode());
              //   if (widget.todoTableData == null) {
              //     _detailCubit.add(
              //       task: TodoTableData(
              //         id: uuid.v4(),
              //         title: _controller.text,
              //         importance: _dropdownValue,
              //         done: false,
              //         deadline: deadline,
              //         createdAt: DateTime.now(),
              //         changedAt: DateTime.now(),
              //         lastUpdatedBy: await PlatformDeviceId.getDeviceId ?? '',
              //       ),
              //     );
              //   } else {
              //     _detailCubit.edit(
              //       task: widget.todoTableData!.copyWith(
              //         title: _controller.text,
              //         importance: _dropdownValue,
              //         done: false,
              //         deadline: deadline,
              //         changedAt: DateTime.now(),
              //         lastUpdatedBy: await PlatformDeviceId.getDeviceId ?? '',
              //       ),
              //     );
              //   }
              // },
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
