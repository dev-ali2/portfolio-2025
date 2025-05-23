import 'package:get/get.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class DateTimeHelper extends GetxController {
  Timer? _timer;
  var currentDateTime = DateTime.now().obs;
  var dayName = ''.obs;
  var monthName = ''.obs;
  var year = ''.obs;
  var timeAmPm = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _updateDateTime();
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateDateTime();
    });
  }

  void _updateDateTime() {
    currentDateTime.value = DateTime.now();
    dayName.value = DateFormat('EEEE').format(currentDateTime.value);
    monthName.value = DateFormat('MMMM').format(currentDateTime.value);
    year.value = DateFormat('yyyy').format(currentDateTime.value);
    timeAmPm.value = DateFormat('hh:mm:ss a').format(currentDateTime.value);

    update(['timer']);
  }
}
