import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../viewmodels/task_viewmodel.dart';
import '../../models/task.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/section_title.dart';
import '../widgets/time_picker_box.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (d != null) setState(() => _selectedDate = d);
  }

  Future<void> _pickStartTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (t != null) setState(() => _startTime = t);
  }

  Future<void> _pickEndTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (t != null) setState(() => _endTime = t);
  }

  void _createTask() {
    if (_titleCtrl.text.trim().isEmpty || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill Title and Date')),
      );
      return;
    }

    final task = TaskModel(
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      date: _selectedDate!,
      startTime: _startTime,
      endTime: _endTime,
    );

    Provider.of<TaskViewModel>(context, listen: false).addTask(task);
    Navigator.pop(context);
  }

  String _timeText(TimeOfDay? t) => t == null ? '--:--' : t.format(context);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _header(),
              const SizedBox(height: 30),
              _timePickers(),
              const SizedBox(height: 40),
              const SectionTitle(txtDescription),
              const SizedBox(height: 8),
              _descriptionBox(),
              const SizedBox(height: 50),
              _button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(kTopRadius),
          bottomRight: Radius.circular(kTopRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: kWhite, size: kIconSize),
          ),
          const SizedBox(height: 12),
          const Text(
            txtAddNewEvent,
            style: TextStyle(color: kWhite, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),

          CustomInput(controller: _titleCtrl, hint: txtTitle),

          const SizedBox(height: 10),

          GestureDetector(
            onTap: _pickDate,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(kInputRadius),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: kGrey),
                  const SizedBox(width: 8),
                  Text(
                    _selectedDate == null
                        ? txtSelectDate
                        : "${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}",
                    style: const TextStyle(color: kBlack),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timePickers() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          TimePickerBox(
            label: txtStartTime,
            value: _timeText(_startTime),
            onTap: _pickStartTime,
          ),
          const SizedBox(width: 12),
          TimePickerBox(
            label: txtEndTime,
            value: _timeText(_endTime),
            onTap: _pickEndTime,
          ),
        ],
      ),
    );
  }

  Widget _descriptionBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(kInputRadius),
        ),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 100,
                maxHeight: 300,
              ),
              child: TextField(
                controller: _descCtrl,
                maxLines: null,
                style: const TextStyle(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Detail about event',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
             
            )
          ],
        ),
      ),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _createTask,
        child: const Text(txtCreateTask,  style: TextStyle(fontSize: 16, color: Colors.white),
      )
      )
      );
    
  }
}
