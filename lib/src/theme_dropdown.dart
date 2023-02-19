import 'package:simple_dart_checkbox/simple_dart_checkbox.dart';
import 'package:simple_dart_dropdown/simple_dart_dropdown.dart';
import 'package:simple_dart_label/simple_dart_label.dart';
import 'package:simple_dart_select_field/simple_dart_select_field.dart';
import 'package:simple_dart_theme_controller/simple_dart_theme_controller.dart';

class ThemeDropDown extends Dropdown {
  final displayLabel = Label()
    ..caption = 'Select Theme'
    ..fullWidth()
    ..fillContent = true
    ..wrap = true;
  final headerLabel = Label()..caption = 'Theme:';
  final Checkbox monoSpaceFontCheckbox = Checkbox()..caption = 'Monospace';
  SelectField<String> selectField = SelectField<String>()..fillContent = true;

  ThemeDropDown() : super() {
    onTop = true;
    shading = 0.5;
    add(displayLabel);
    dropPanel
      ..spacing = '5px'
      ..padding = '5px'
      ..addAll([headerLabel, selectField, monoSpaceFontCheckbox]);
    selectField.onValueChange.listen((value) {
      themeController.theme = value.newValue.first;
      refreshDisplay();
    });
    monoSpaceFontCheckbox.onValueChange.listen((value) {
      themeController.monoSpaceFont = value.newValue;
      refreshDisplay();
    });
  }

  void refreshDisplay() {
    displayLabel.caption = '${themeController.theme} Theme ${(themeController.monoSpaceFont) ? 'Monospace' : ''}';
  }

  @override
  void beforeShowDropPanel() {
    dropPanel.width = '${element.offsetWidth}px';
    selectField
      ..initOptions(themeController.themeList)
      ..size = themeController.themeList.length
      ..value = [themeController.theme];
    monoSpaceFontCheckbox.value = themeController.monoSpaceFont;
  }
}
