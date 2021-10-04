import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:stockdaddy/controllers/controller.dart';
import 'package:stockdaddy/models/sd_task_model.dart';

final textFieldBorder = OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.white),
  borderRadius: BorderRadius.circular(8),
);

class SDChipTextField extends StatefulWidget {
  const SDChipTextField({
    Key? key,
    this.icon,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.minLines = 1,
    required this.label,
    // required this.onChange,
  }) : super(key: key);

  final String label;
  final bool isObscure;
  final String? hintText;
  final TextInputType keyboardType;
  final IconData? icon;
  final int minLines;

  @override
  State<SDChipTextField> createState() => _SDChipTextFieldState();
}

class _SDChipTextFieldState extends State<SDChipTextField> {
  late List<String> tags = [];

  late String tag;

  @override
  Widget build(BuildContext context) {
    // List tags =
    //     context.read<SDTaskCubit>().state.fieldInputMap[SDTaskModel.kTags];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: TextStyle(color: Colors.white, fontSize: 14.sp)),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          minLines: widget.minLines,
          maxLines: 10,
          keyboardType: widget.keyboardType,
          onChanged: (input) {
            tag = input;
          },
          cursorColor: Colors.white,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                context.read<SDTaskCubit>().addTags(tag);
                tags.add(tag);
                setState(() {});
              },
            ),
            border: textFieldBorder,
            enabledBorder: textFieldBorder,
            disabledBorder: textFieldBorder,
            focusedBorder: textFieldBorder,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.white54),
            prefixIcon: widget.icon == null
                ? null
                : Icon(widget.icon, color: Colors.white),
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 50,
          child: BlocBuilder<SDTaskCubit, SDTaskCubitState>(
            buildWhen: (prev, current) =>
                prev.fieldInputMap[SDTaskModel.kTags] !=
                prev.fieldInputMap[SDTaskModel.kTags],
            builder: (context, state) {
              return ListView.builder(
                itemCount: tags.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: RawChip(
                      label: Text(
                        tags[index],
                        style: const TextStyle(color: Colors.blue),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              );
            },
          ),
        ),
      ],
    );
  }
}
