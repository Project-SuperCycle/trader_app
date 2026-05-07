import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:trader_app/core/utils/app_styles.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final String? initialValue;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final double? width;
  final double? maxHeight;
  final EdgeInsetsGeometry? padding;
  final bool isSearchable;
  final bool showBorder;

  const CustomDropdown({
    super.key,
    required this.options,
    required this.onChanged,
    this.initialValue,
    this.hintText = 'اختر',
    this.width,
    this.maxHeight = 200,
    this.padding,
    this.isSearchable = false,
    this.showBorder = true,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  // ✅ الحل: لما الـ options أو الـ initialValue يتغيروا من الخارج
  @override
  void didUpdateWidget(covariant CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    // لو الـ options اتغيرت والقيمة الحالية مش موجودة فيهم → reset
    final valueStillValid = widget.options.contains(selectedValue);

    if (!valueStillValid) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => selectedValue = null);
        }
      });
    }

    // لو الـ initialValue اتغير من الخارج → حدّث
    if (widget.initialValue != oldWidget.initialValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => selectedValue = widget.initialValue);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ تأكد إن الـ value موجودة في الـ options وقت الـ build
    final safeValue = widget.options.contains(selectedValue)
        ? selectedValue
        : null;

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                widget.hintText,
                style: AppStyles.styleMedium14(
                  context,
                ).copyWith(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.options
            .map(
              (String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: AppStyles.styleRegular14(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        value: safeValue,
        // ✅ بدل selectedValue مباشرة
        onChanged: (value) {
          setState(() => selectedValue = value);
          widget.onChanged(value);
        },
        buttonStyleData: ButtonStyleData(
          height: 40,
          padding: widget.padding ?? const EdgeInsets.only(left: 12, right: 12),
          decoration: widget.showBorder
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black26),
                  color: Colors.white,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white),
                  color: Colors.white,
                ),
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          iconSize: 25,
          iconEnabledColor: Colors.grey.withValues(alpha: 0.75),
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          useSafeArea: true,
          padding: widget.padding ?? const EdgeInsets.only(left: 10, right: 10),
          maxHeight: widget.maxHeight!,
          width: widget.width ?? MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(50),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
          offset: Offset(MediaQuery.of(context).size.width * 0.1, 50),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        dropdownSearchData: widget.isSearchable
            ? DropdownSearchData(
                searchController: _searchController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search...',
                      hintStyle: AppStyles.styleRegular12(context),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().toLowerCase().contains(
                    searchValue.toLowerCase(),
                  );
                },
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
