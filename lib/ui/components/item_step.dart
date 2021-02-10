import 'package:flutter/material.dart';
import 'package:foodb/ui/components/notifiable_text_box.dart';
import 'package:foodb/ui/vm/vm_step.dart';

class ItemStep extends StatelessWidget {
  final VMStep vm;
  final void Function(VMStep) onDelete;
  ItemStep(this.vm, {this.onDelete});
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: NotifiableTextBox(
                  listenable: vm.description,
                  hintText: "Step",
                  lines: 3,
                  onChanged: vm.setDescription,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Color(0xFFFF6666),
                ),
                onPressed: () => onDelete(vm),
              )
            ],
          ),
          Divider(
            color: Colors.grey.shade400,
            thickness: 1,
            height: 32,
            indent: 8,
            endIndent: 8,
          ),
        ],
      );
}
