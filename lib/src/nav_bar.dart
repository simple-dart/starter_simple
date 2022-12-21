import 'package:simple_dart_link/simple_dart_link.dart';
import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

import 'view.dart';

class NavBar extends PanelComponent {
  Panel linkListPanel = Panel()
    ..fillContent = true
    ..vertical = true
    ..spacing = '5px'
    ..padding = '5px';
  Panel bottomPanel = Panel()
    ..addCssClass('NavBarBottomPanel')
    ..padding = '0 0 15px 0'
    ..vertical = true;

  NavBar() : super('NavBar') {
    fullHeight();
    vertical = true;
    add(linkListPanel);
    add(bottomPanel);
  }

  void addView(View newView) {
    final navBarComponent = newView.getNavBarComponent();
    if (navBarComponent != null) {
      linkListPanel.add(navBarComponent);
    }
  }

  void refresh(View currentView) {
    for (final navBarComponent in linkListPanel.children) {
      if (navBarComponent is Link) {
        navBarComponent.active = currentView.caption == navBarComponent.caption;
      }
    }
  }
}
