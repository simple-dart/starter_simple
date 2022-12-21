import 'package:simple_dart_label/simple_dart_label.dart';
import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';
import 'package:simple_dart_view_controller/simple_dart_view_controller.dart';

import 'view.dart';

typedef CreatePathSeparatorComponent = Component Function();

class PathBar extends PanelComponent {
  CreatePathSeparatorComponent createPathSeparatorComponent = () => Label()
    ..caption = '>'
    ..width = '15px'
    ..hAlign = Align.center;

  Panel pathPanel = Panel()
    ..spacing = '5px'
    ..padding = '10px'
    ..fullWidth()
    ..vAlign = Align.stretch
    ..fillContent = true;
  Panel leftPanel = Panel()
    ..visible = false
    ..fullHeight()
    ..vAlign = Align.stretch;
  Panel rightPanel = Panel()
    ..visible = false
    ..fullHeight()
    ..vAlign = Align.stretch;

  PathBar() : super('PathBar') {
    fullWidth();
    addAll([leftPanel, pathPanel, rightPanel]);
  }

  void refresh(View currentView) {
    pathPanel.clear();
    var lastParentView = currentView.parent;
    final viewsList = <View>[currentView];
    while (lastParentView != null) {
      viewsList.add(lastParentView as View);
      lastParentView = lastParentView.parent;
    }
    for (final view in viewsList.reversed) {
      if (view == viewController.homeView) {
        continue;
      }
      if (pathPanel.children.isNotEmpty) {
        pathPanel.add(createPathSeparatorComponent());
      }
      pathPanel.add(view.getPathPanelComponent());
    }
  }
}
