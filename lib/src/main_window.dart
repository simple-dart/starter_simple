import 'dart:html';

import 'package:simple_dart_label/simple_dart_label.dart';
import 'package:simple_dart_link/simple_dart_link.dart';
import 'package:simple_dart_modal_controller/simple_dart_modal_controller.dart';
import 'package:simple_dart_theme_controller/simple_dart_theme_controller.dart';
import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';
import 'package:simple_dart_view_controller/simple_dart_view_controller.dart';

import 'nav_bar.dart';
import 'path_bar.dart';
import 'theme_dropdown.dart';
import 'view.dart';

class MainWindow extends PanelComponent {
  Panel display = Panel()
    ..varName = 'display'
    ..vertical = true
    ..fillContent = true
    ..fullSize()
    ..element.style.overflow = 'auto';

  Panel horizontalPanel = Panel()
    ..fullSize()
    ..fillContent = true;
  Link homeLink = Link()
    ..addCssClass('MainWindowHomeLink')
    ..width = '200px'
    ..hAlign = Align.center
    ..vAlign = Align.center;
  NavBar navBar = NavBar()..width = '200px';
  PathBar pathBar = PathBar()..height = '40px';
  ThemeDropDown themeDropDown = ThemeDropDown();

  MainWindow() : super('MainWindow') {
    fullSize();
    fillContent = true;
    vertical = true;
    pathBar.leftPanel.visible = true;
    pathBar.leftPanel.add(homeLink);
    add(pathBar);
    add(horizontalPanel);
    horizontalPanel.addAll([navBar, display]);
  }

  void insertToPage({String nodeSelector = 'body'}) {
    querySelector(nodeSelector)!.children.add(element);
  }

  void start() {
    viewController.views.forEach((key, view) {
      navBar.addView(view as View);
    });
    viewController.onViewChange.listen((currentView) {
      if (currentView is View) {
        display
          ..clear()
          ..add(currentView);
        navBar.refresh(currentView);
        pathBar.refresh(currentView);
      }
    });

    themeController.onThemeChange.listen((themeChangeEvent) {
      navBar.reRender();
      pathBar.reRender();
      for (final view in viewController.views.values) {
        if (view is View) {
          view.reRender();
        }
      }
    });
    themeController.onMonoSpaceFontChange.listen((monoSpaceFontChangeEvent) {
      navBar.reRender();
      pathBar.reRender();
      for (final view in viewController.views.values) {
        if (view is View) {
          view.reRender();
        }
      }
    });

    homeLink
      ..caption = viewController.homeView.caption
      ..href = '#${viewController.homeView.id}';
    insertToPage();
  }
}

void showFatalError(Object errObj) {
  final errText = convertError(errObj);
  modalController.onClick.listen((event) {
    window.location.assign('/');
  });
  final errorPanel = Panel()
    ..addCssClass('DropdownDropPanel')
    ..padding = '10px'
    ..width = '35%'
    ..hAlign = Align.center
    ..add(Label()..caption = errText);
  modalController.showModal(errorPanel, top: '25%');
  throw Exception(errObj);
}

String showError(Object errObj) {
  final errText = convertError(errObj);
  final errorPanel = Panel()
    ..addCssClass('DropdownDropPanel')
    ..padding = '10px'
    ..width = '35%'
    ..hAlign = Align.center
    ..add(Label()..caption = errText);
  modalController.showModal(errorPanel, top: '25%');
  return errText;
}

String convertError(Object e) {
  if (e is String) {
    return e;
  } else if (e is ProgressEvent) {
    final t = e.target;
    if (t is HttpRequest) {
      return t.response;
    }
    return t.toString();
  } else {
    return e.toString();
  }
}
