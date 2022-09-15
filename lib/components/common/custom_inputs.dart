import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jolobox_staff_app/theme/theme_constants.dart';

class CustomInputStyle {
  const CustomInputStyle();

  static BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(JoloboxTheme.sizes.borderRadius)),
      boxShadow: [
        const BoxShadow(
          color: Color(0x0F000000),
        ),
        BoxShadow(
          color: JoloboxTheme.colors.textInputBackground,
          spreadRadius: JoloboxTheme.sizes.themeScale(-2.0),
          blurRadius: JoloboxTheme.sizes.themeScale(2.0),
        ),
      ],
    );
  }

  static InputDecoration getInputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.only(
        left: JoloboxTheme.sizes.smallPadding,
        right: JoloboxTheme.sizes.smallPadding,
        top: JoloboxTheme.sizes.smallPadding / 2,
        bottom: JoloboxTheme.sizes.smallPadding / 2,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(JoloboxTheme.sizes.borderRadius),
          borderSide: BorderSide.none
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(JoloboxTheme.sizes.borderRadius),
          borderSide: BorderSide.none
      ),
    );
  }
}

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({Key? key, required this.label, this.formKey, this.onChanged}) : super(key: key);

  final String label;
  final Key? formKey;
  final Function(Key? formKey)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          )
        ),
        Container(
          margin: EdgeInsets.only(top: JoloboxTheme.sizes.smallPadding / 3),
          decoration: CustomInputStyle.getBoxDecoration(),
          child: TextFormField(
            style: TextStyle(
              fontSize: JoloboxTheme.sizes.origTextSize,
            ),
            decoration: CustomInputStyle.getInputDecoration(),
            onChanged: (str) {
              onChanged!(formKey);
            }
          ),
        ),
      ],
    );
  }
}

class CustomPasswordInput extends StatelessWidget {
  const CustomPasswordInput({Key? key, required this.label, this.formKey, this.onChanged}) : super(key: key);

  final String label;
  final Key? formKey;
  final Function(Key? formKey)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold
            )
        ),
        Container(
          margin: EdgeInsets.only(top: JoloboxTheme.sizes.smallPadding / 3),
          decoration: CustomInputStyle.getBoxDecoration(),
          child: TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            style: TextStyle(
              fontSize: JoloboxTheme.sizes.origTextSize,
            ),
            decoration: CustomInputStyle.getInputDecoration(),
            onChanged: (str) {
              onChanged!(formKey);
            }
          ),
        ),
      ],
    );
  }
}


class CustomDateTimeInput extends StatelessWidget {
  CustomDateTimeInput({Key? key, required this.label, this.formKey, this.onChanged}) : super(key: key);

  final String label;
  final Key? formKey;
  final Function(Key? formKey)? onChanged;

  final txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.bold
            )
        ),
        Container(
          margin: EdgeInsets.only(top: JoloboxTheme.sizes.smallPadding / 3),
          decoration: CustomInputStyle.getBoxDecoration(),
          child: TextFormField(
            controller: txt,
            readOnly: true,
            style: TextStyle(
              fontSize: JoloboxTheme.sizes.origTextSize,
            ),
            decoration: CustomInputStyle.getInputDecoration(),
            onTap: () async {
              DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
                lastDate: DateTime.now()
              );

              if (dateTime != null) {
                String day = dateTime.day >= 10 ? dateTime.day.toString() : '0${dateTime.day.toString()}';
                String month = dateTime.month >= 10 ? dateTime.month.toString() : '0${dateTime.month.toString()}';
                txt.text = '$day.$month.${dateTime.year.toString()}';
              }
              onChanged!(formKey);
            }
          ),
        ),
      ],
    );
  }
}


class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({Key? key, required this.title, required this.groupValue, required this.value, required this.onChanged}) : super(key: key);

  final String title;
  final int groupValue;
  final int value;
  final Function(int?)? onChanged;

  @override
  State<CustomRadioButton> createState() => CustomRadioButtonState();
}

class CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged!(widget.value);
      },
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      child: Row(
        children: [
          Radio<int>(
            activeColor: Theme.of(context).colorScheme.primary,

            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: widget.onChanged,

            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
          ),
          Text(widget.title)
        ],
      )
    );
  }
}

class CustomRadioGroup extends StatefulWidget {
  const CustomRadioGroup({Key? key, required this.label, this.formKey, this.onChanged, required this.list, this.crossAxisCount = 2}) : super(key: key);

  final String label;
  final Key? formKey;
  final Function(Key? formKey)? onChanged;
  final List<Map<dynamic, dynamic>> list;
  final int crossAxisCount;

  @override
  State<CustomRadioGroup> createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  int _groupValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            widget.label,
            style: const TextStyle(
                fontWeight: FontWeight.bold
            )
        ),
        SizedBox(height: JoloboxTheme.sizes.smallPadding / 3),
        Row(
          children: [
            ...widget.list.map((data) => Expanded(
              flex: 1,
              child: CustomRadioButton(
                title: data['title'],
                groupValue: _groupValue,
                value: data['value'],
                onChanged: (val) {
                  setState(() {
                    _groupValue = val!;
                  });
                  widget.onChanged!(widget.formKey);
                }
              ),
            ))
          ],
        ),
      ],
    );
  }
}


class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    Key? key,
    required this.title,
    this.isDefaultChecked = false,
    this.setDefaultEveryRebuild = false,
    required this.onChanged
  }) : super(key: key);

  final String title;
  final bool isDefaultChecked;
  final bool setDefaultEveryRebuild;
  final Function(bool?)? onChanged;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  static const int _msAnimationDuration = 200;
  bool _isChecked = false;

  void _performChecked(bool? isChecked) {
    setState(() {
      _isChecked = isChecked!;
      widget.onChanged!(_isChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.setDefaultEveryRebuild) {
      _isChecked = widget.isDefaultChecked;
    }

    return InkWell(
      onTap: () {
        _performChecked(!_isChecked);
      },
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      child: Row(
        children: [
          AnimatedContainer(
            width: 18.0,
            height: 18.0,
            decoration: BoxDecoration(
              color: _isChecked ? Theme.of(context).colorScheme.primary : Theme.of(context).unselectedWidgetColor,
              borderRadius: BorderRadius.circular(2.0),
            ),
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(7.0),
            duration:  const Duration(milliseconds: _msAnimationDuration),

            child: AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.0),
                color: Theme.of(context).colorScheme.background,
              ),
              padding: EdgeInsets.all(_isChecked ? 2.5 : 10),
              duration: const Duration(milliseconds: _msAnimationDuration),

              child: AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.0),
                  color: _isChecked ? Theme.of(context).colorScheme.primary : Theme.of(context).unselectedWidgetColor,
                ),
                duration: const Duration(milliseconds: _msAnimationDuration),
              ),
            ),
          ),
          Text(widget.title)
        ],
      )
    );
  }
}


class ExpandButton extends StatefulWidget {
  const ExpandButton({
    Key? key,
    required this.onPressed,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  final Function(bool opened) onPressed;
  final Duration duration;

  @override
  State<ExpandButton> createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<ExpandButton> with SingleTickerProviderStateMixin {
  bool _opened = false;
  late AnimationController _animationController;
  late Animation _animation;

  void _doAnimation() {
    if (_opened) {
      _animationController.reverse();
    }
    else {
      _animationController.forward();
    }
    _opened = !_opened;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      radius: JoloboxTheme.sizes.themeScale(24.0),
      onTap: () {
        _doAnimation();
        widget.onPressed(_opened);
      },
      child: Container(
        padding: EdgeInsets.all(JoloboxTheme.sizes.smallPadding / 2),
        child: AnimatedBuilder(
          animation: _animationController.view,
          builder: (context, child) {
            return Transform.rotate(
              angle: pi * _animation.value,
              child: child,
            );
          },
          child: const Icon(
            Icons.expand_more_rounded,
          )
        ),
      ),
    );
  }
}

