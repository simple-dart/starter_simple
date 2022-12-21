import 'package:simple_dart_link/simple_dart_link.dart';
import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';
import 'package:simple_dart_view_controller/simple_dart_view_controller.dart';

class View extends PanelComponent implements AbstractView {
  @override
  String caption = '';

  @override
  String id = '';
  @override
  AbstractView? parent;
  @override
  Map<String, String> params = {};

  bool showInNavBar = true;

  Map<String, String>? state;

  View() : super('ViewPanel') {
    fullSize();
    fillContent = true;
  }

  @override
  Future<void> init(Map<String, String> params, Map<String, String>? state) async {
    this.params = params;
    this.state = state;
  }

  void addStateComponents(List<StateComponent> stateComponents) {
    for (final stateComponent in stateComponents) {
      stateComponent.onValueChange.listen((event) {
        state ??= {};
        state![stateComponent.varName] = stateComponent.state;
        if (state != null) {
          viewController.saveState(state!);
        }
      });
    }
  }

  Component? getNavBarComponent() {
    if (!showInNavBar) {
      return null;
    }
    final navBarButton = Link()
      ..addCssClass('NavBarButton')
      ..href = id
      ..caption = caption
      ..href = viewController.generateFullPath(this);
    return navBarButton;
  }

  Component getPathPanelComponent() => Link()
    ..addCssClass('PathBarButton')
    ..fullHeight()
    ..href = viewController.generateFullPath(this)
    ..caption = caption;
}
