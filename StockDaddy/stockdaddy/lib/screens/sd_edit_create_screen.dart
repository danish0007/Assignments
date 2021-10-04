import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:stockdaddy/controllers/sd_task_cubit.dart';
import 'package:stockdaddy/models/model.dart';
import 'package:stockdaddy/screens/sd_home_screen.dart';
import 'package:stockdaddy/widgets/widget.dart';

class SDEditCreateScreen extends StatelessWidget {
  static String id = 'edit_create_screen';
  const SDEditCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ListView(
              children: [
                Text(
                  'Create New Diary',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),

                /// Title Text Field.
                SDEditTextField(
                  label: 'Title',
                  onChange: (input) {
                    context
                        .read<SDTaskCubit>()
                        .update(SDTaskModel.kTitle, input);
                  },
                  hintText: 'Enter Title',
                ),

                const SizedBox(
                  height: 16,
                ),

                /// Desc Text Field.
                SDEditTextField(
                  label: 'Description',
                  onChange: (input) {
                    context
                        .read<SDTaskCubit>()
                        .update(SDTaskModel.kDescription, input);
                  },
                  minLines: 5,
                  hintText: 'Enter Description',
                ),

                const SizedBox(
                  height: 16,
                ),

                /// Calender DateTime Field.
                SDDateTimeInput(
                  label: 'Date',
                  selectedDate: context
                      .watch<SDTaskCubit>()
                      .state
                      .fieldInputMap[SDTaskModel.kDateTime],
                  onPress: (dateTime) {
                    context
                        .read<SDTaskCubit>()
                        .update(SDTaskModel.kDateTime, dateTime);
                  },
                  hintText: 'Select Date',
                ),

                const SizedBox(
                  height: 16,
                ),

                /// Chip Text field
                const SDChipTextField(
                  label: 'Add Tags',
                  hintText: 'Enter Tags',
                ),

                const SizedBox(
                  height: 24,
                ),

                /// Button For Saving
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      context.read<SDTaskCubit>().save();
                      Navigator.pushReplacementNamed(context, SDHomeScreen.id);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
