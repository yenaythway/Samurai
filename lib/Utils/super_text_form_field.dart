import 'package:flutter/material.dart';

class SuperTextFormField extends StatelessWidget {
  const SuperTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

getTextFormFieldWithSave(BuildContext context,
    {bool? isEnabled,
    String? text,
    String? hintText,
    TextInputType? inputType,
    Icon? icon,
    TextEditingController? controller,
    Function(String?)? onSave,
    String? Function(String?)? validator}) {
  return TextFormField(
    controller: controller,
    enabled: isEnabled,
    decoration: InputDecoration(
      labelText: text,
      hintText: hintText,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 20),
      ),
      filled: true,
      suffixIcon: const Icon(Icons.link),
    ),
    keyboardType: inputType,
    validator: validator,
    onSaved: onSave,
  );
}
