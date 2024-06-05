part of '_component.dart';

class StatefulValueBuilder<T> extends StatefulWidget {
  const StatefulValueBuilder({
    super.key, 
    required this.builder,
    this.initialValue,
  });

  final Widget Function(BuildContext context, T? value, void Function(T val) setStateValue) builder;
  final T? initialValue;

  @override
  State<StatefulValueBuilder<T>> createState() => _StatefulValueBuilderState<T>();
}

class _StatefulValueBuilderState<T> extends State<StatefulValueBuilder<T>> {

  T? value;

  @override
  void initState() { 
    super.initState();
    value = widget.initialValue;
  }

  @override
  void dispose() {
    value = null;
    super.dispose();
  }

  void setValue(T newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, value, setValue);
}