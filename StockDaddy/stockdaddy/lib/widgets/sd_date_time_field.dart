import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// reusable DateTime field widget mainly used in edit page.
class SDDateTimeInput extends StatefulWidget {
  /// constructor for initialization.
  const SDDateTimeInput({
    Key? key,
    required this.label,
    this.hintText,
    this.isEnabled = true,
    required this.onPress,
    this.selectedDate,
  }) : super(key: key);

  /// field label.
  final String label;

  final String? hintText;

  ///field input enabled or not.
  final bool isEnabled;

  final DateTime? selectedDate;

  final void Function(DateTime) onPress;

  @override
  State<SDDateTimeInput> createState() => _SDDateTimeInputState();
}

class _SDDateTimeInputState extends State<SDDateTimeInput> {
  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2015),
            lastDate: DateTime(2050)) ??
        DateTime.now();

    // var date = DateFormat('yyyy-MM-dd, HH:mm:ss').format(pickedDate);
    // var dateTime = DateTime.parse(date);
    // context.read<E>().update(mapKey ?? '', pickedDate);
    selectedDate = pickedDate;
    setState(() {});
    widget.onPress(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: TextStyle(color: Colors.white, fontSize: 14.sp)),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () => widget.isEnabled ? _selectDate(context) : null,
          child: Container(
            height: 63,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  selectedDate != null
                      ? Text(
                          selectedDate.toString().substring(0, 10),
                          style: const TextStyle(color: Colors.white),
                        )
                      : Text(
                          widget.hintText ?? '',
                          style: const TextStyle(color: Colors.white54),
                        ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
