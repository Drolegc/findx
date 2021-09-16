import 'package:findx/findx_change_notifier.dart';
import 'package:findx/findx_controller.dart';
import 'package:findx/findx_store.dart';
import 'package:flutter/widgets.dart';

typedef FindXControllerBuilder<T extends FindXController> = Widget Function(
    T controller);

class FindXBuilder<T extends FindXController> extends StatefulWidget {
  final FindXControllerBuilder<T> builder;
  final T? put;
  final String? id, idController;
  final bool allowCommunicationWithOthers;

  const FindXBuilder(
      {required this.builder,
      this.put,
      this.id,
      this.idController,
      this.allowCommunicationWithOthers = false});

  @override
  _FindXBuilderState<T> createState() => _FindXBuilderState<T>();
}

class _FindXBuilderState<T extends FindXController>
    extends State<FindXBuilder<T>> {
  T? _controller;
  T get controller => _controller!;

  FindXStore? _findXStore;
  late VoidParameterCallback _listener;

  @override
  void initState() {
    super.initState();

    _listener = (ids) {
      if (ids == null) return setState(() {});

      if (ids.contains(widget.id)) setState(() {});
    };
  }

  @override
  void didChangeDependencies() {
    _findXStore = FindXStore.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      if (widget.put != null) {
        _controller = widget.put;
        FindXStore.of(context)!.store.put<T>(_controller!,
            id: _controller!.id,
            allowComunicationWithOthers: widget.allowCommunicationWithOthers);
      } else {
        _controller =
            FindXStore.of(context)!.store.find<T>(id: widget.idController);
      }

      if (!controller.hasListeners) controller.addListener(_listener);
    }

    return widget.builder(controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_listener);
    _findXStore!.store.remove<T>(id: controller.id);
  }
}
