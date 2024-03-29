import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:todo_app/common/di/app_config.dart';
import 'package:todo_app/common/res/theme/theme.dart';
import 'package:todo_app/common/res/theme/todo_text_theme.dart';
import 'package:todo_app/data/models/todo_table.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/database/database.dart';
import 'package:todo_app/domain/details_cubit/detail_cubit.dart';
import 'package:todo_app/domain/todo_actions/todo_actions_cubit.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/navigation/controller.dart';
import 'package:todo_app/screens/detail_screen/detail_header.dart';
import 'package:todo_app/screens/detail_screen/dropdown_button_detail.dart';
import 'package:todo_app/widgets/text_field_custom.dart';
import 'package:uuid/uuid.dart';

class DetailScreen extends StatefulWidget {
  final TodoTableData? todoTableData;

  static Widget newInstance({
    TodoTableData? todoTableData,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return DetailCubit(
              getIt.get<TodoRepository>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return TodoActionsCubit(
              getIt.get<TodoRepository>(),
            );
          },
        ),
      ],
      child: DetailScreen._(
        todoTableData: todoTableData,
      ),
    );
  }

  const DetailScreen._({this.todoTableData});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _switchValue = false;
  Importance _dropdownValue = Importance.basic;
  DateTime? deadline;
  final _controller = TextEditingController();
  final uuid = const Uuid();
  final focusNode = FocusNode();
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> _initConfig() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 10),
      ),
    );

    await _remoteConfig.fetchAndActivate();
  }

  TodoActionsCubit get _todoActionCubit =>
      BlocProvider.of<TodoActionsCubit>(context);

  DetailCubit get _detailCubit => BlocProvider.of<DetailCubit>(context);

  @override
  void initState() {
    super.initState();
    if (widget.todoTableData != null) {
      _controller.text = widget.todoTableData!.title;
      deadline = widget.todoTableData!.deadline;
      _dropdownValue = widget.todoTableData!.importance;
    }
    _initConfig();
  }

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: DetailHeader(
          onPressed: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            if (widget.todoTableData == null) {
              _detailCubit.add(
                task: TodoTableData(
                  id: uuid.v4(),
                  title: _controller.text,
                  importance: _dropdownValue,
                  done: false,
                  deadline: deadline,
                  createdAt: DateTime.now(),
                  changedAt: DateTime.now(),
                  lastUpdatedBy: await PlatformDeviceId.getDeviceId ?? '',
                ),
              );
            } else {
              _detailCubit.edit(
                task: widget.todoTableData!.copyWith(
                  title: _controller.text,
                  importance: _dropdownValue,
                  done: false,
                  deadline: deadline,
                  changedAt: DateTime.now(),
                  lastUpdatedBy: await PlatformDeviceId.getDeviceId ?? '',
                ),
              );
            }
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
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
                    focusNode: focusNode,
                    controller: _controller,
                    hintText: S.of(context).needToDo,
                    keyboardType: TextInputType.multiline,
                    maxLines: 40,
                    minLines: 4,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 28,
                ),
                child: Text(
                  S.of(context).importance,
                  style: textStyles?.body!.copyWith(
                    color: colors.primaryColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: DropdownButtonDetail(
                  onChanged: (Importance? value) {
                    setState(
                      () {
                        _dropdownValue = value!;
                      },
                    );
                  },
                  dropdownValue: _dropdownValue,
                  remoteConfig: _remoteConfig,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 14),
                        child: Text(
                          S.of(context).needToBeDoneBefore,
                          style: textStyles?.body!.copyWith(
                            color: colors.primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          deadline != null
                              ? DateFormat('d MMMM yyyy', 'ru_RU')
                                  .format(deadline!)
                                  .toString()
                              : '',
                          style: textStyles!.button!.copyWith(
                              color: colors.blueColor,
                              fontWeight: FontWeight.w400),
                        ),
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
                          confirmText: S.of(context).ready,
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
                onTap: () async {
                  if (widget.todoTableData != null) {
                    _todoActionCubit.delete(
                      widget.todoTableData!.copyWith(
                        title: _controller.text,
                        importance: _dropdownValue,
                        done: false,
                        deadline: deadline,
                        changedAt: DateTime.now(),
                        lastUpdatedBy: await PlatformDeviceId.getDeviceId ?? '',
                      ),
                    );
                    context.read<NavigationController>().pop();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 25),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: widget.todoTableData == null
                            ? colors.disableColor
                            : colors.redColor,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        S.of(context).delete,
                        style: textStyles.body!.copyWith(
                          color: widget.todoTableData == null
                              ? colors.disableColor
                              : colors.redColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
