import 'package:flutter/material.dart';
import 'package:sim_management_task/core/services/open_dialer.dart';
import 'package:sim_management_task/core/utils/app_color.dart';
import 'package:sim_management_task/features/sim_management/data/models/sim_model.dart';

class PhoneNumberComponent extends StatefulWidget {
  const PhoneNumberComponent({super.key, required this.sim});

  final SimModel sim;

  @override
  State<PhoneNumberComponent> createState() => _PhoneNumberComponentState();
}

class _PhoneNumberComponentState extends State<PhoneNumberComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.sim.phoneNumber,
          style: const TextStyle(
            color: AppColors.grey500,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        IconButton(
          onPressed: () {
            String code = widget.sim.provider == "vodafone"
                ? "*878#"
                : widget.sim.provider == "orange"
                ? "#119#"
                : widget.sim.provider == "etisalat"
                ? "*947#"
                : widget.sim.provider == "we"
                ? "*688#"
                : "";
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "to show the number you have to open the dialer and call the code $code by sim ${widget.sim.id + 1}",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        OpenDialer().openDialer(code);
                        Navigator.pop(context);
                      },
                      child: Text("Call"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.remove_red_eye),
        ),
      ],
    );
  }
}
