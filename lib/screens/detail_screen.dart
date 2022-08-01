import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/data/repositories/todos_dao.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/domain/details_cubit/detail_cubit.dart';
import 'package:uuid/uuid.dart';
import '../common/di/app_config.dart';
import '../common/res/images.dart';
import '../common/res/theme/theme.dart';
import '../common/res/theme/todo_text_theme.dart';
import '../generated/l10n.dart';
import '../navigation/controller.dart';
import '../widgets/text_field_custom.dart';

class DetailScreen extends StatefulWidget {
  static Widget newInstance() {
    return BlocProvider(
      create: (context) {
        return DetailCubit(
          getIt.get<TodoRepository>(),
        );
      },
      child: const DetailScreen._(),
    );
  }

  const DetailScreen._();


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _switchValue = false;
  String _dropdownValue = 'Нет';
  DateTime? deadline;
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _deviceId;
  final uuid = Uuid();
  // This function will be called when the floating button is pressed
  void _getInfo() async {
    String? result = await PlatformDeviceId.getDeviceId;

    setState(() {
      _deviceId = result;
    });
  }

  DetailCubit get _detailCubit => BlocProvider.of<DetailCubit>(context);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsTheme>();
    final textStyles = Theme.of(context).extension<TodoTextTheme>();

    return Scaffold(
      backgroundColor: colors!.backPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.backPrimaryColor,
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
            listener: (context, state){
              if(state is DetailSuccess){
                context.read<NavigationController>().pop();
              }
            },

            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  _detailCubit.addTodo(
                    task: TodoTableData(
                      localId: uuid.v4(),
                      title: _controller.text,
                      importance: _dropdownValue,
                      done: false,
                      deadline: deadline,
                      createdAt: DateTime.now(),
                      changedAt: DateTime.now(),
                      lastUpdatedBy: '1',
                    ),
                  );
                },
                child: Text(
                  S.of(context).save,
                  style:
                  textStyles!.button!.copyWith(color: colors.blueColor),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 104,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colors.whiteColor,
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      offset: Offset.zero,
                      blurRadius: 2,
                    )
                  ],
                ),
                child: TextFieldCustom(
                  controller: _controller,
                  hintText: S.of(context).needToDo,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 28,
              ),
              child: Text(
                'Важность',
                style: textStyles?.body!.copyWith(
                  color: colors.primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 6, bottom: 16),
              child: DropdownButton(
                iconEnabledColor: Colors.transparent,
                underline: Container(),
                onChanged: (String? value) {
                  setState(
                    () {
                      _dropdownValue = value!;
                    },
                  );
                },
                hint: _dropdownValue == 'Нет'
                    ? Text(
                        'Нет',
                        style: textStyles?.button!.copyWith(
                          color: colors.tertiaryColor,
                        ),
                      )
                    : Text(
                        _dropdownValue,
                        style: textStyles?.body!.copyWith(
                          color: colors.primaryColor,
                        ),
                      ),
                items: [
                  DropdownMenuItem(
                    value: 'Нет',
                    child: Text(
                      'Нет',
                      style: textStyles?.body!.copyWith(
                        color: colors.primaryColor,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Низкий',
                    child: Text(
                      'Низкий',
                      style: textStyles?.body!.copyWith(
                        color: colors.primaryColor,
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: '!! Высокий',
                    child: Text(
                      '!! Высокий',
                      style: textStyles?.body!.copyWith(
                        color: colors.redColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16, top: 16.5, bottom: 26.5),
              child: Divider(
                color: colors.separatorColor,
                height: 0.5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        S.of(context).needToBeDoneBefore,
                        style: textStyles?.body!.copyWith(
                          color: colors.primaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 16),
                      child: Text(deadline != null
                          ? DateFormat('d MMMM yyyy', 'ru_RU')
                              .format(deadline!)
                              .toString()
                          : ''),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Switch(
                    value: _switchValue,
                    onChanged: (value) async {
                      deadline = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        locale: const Locale('ru'),
                        firstDate: DateTime(2015),
                        lastDate: DateTime(2050),
                        confirmText: 'ГОТОВО',
                        helpText: DateTime.now().year.toString(),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: ColorScheme.light(
                                primary: colors.blueColor!,
                                onSurface: colors.primaryColor!,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      setState(
                        () {
                          _switchValue = value;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.5, bottom: 22),
              child: Divider(
                color: colors.separatorColor,
                height: 0.5,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Images.icTrash,
                      color: colors.disableColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      S.of(context).delete,
                      style:  textStyles?.body!.copyWith(
                        color: colors.disableColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
