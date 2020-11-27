library sliver_row;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SliverRow extends StatelessWidget {
  final List<SliverRowChildDelegate> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const SliverRow({
    Key key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    @required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: this.mainAxisAlignment,
        crossAxisAlignment: this.crossAxisAlignment,
        children: [
          for (var child in children)
            child.rowBuilder(
              context,
              ShrinkWrappingViewport(
                slivers: child.slivers,
                offset: ViewportOffset.zero(),
              ),
            ),
        ],
      ),
    );
  }
}

class SliverRowChildDelegate {
  final List<Widget> slivers;
  final RenderRow rowBuilder;

  SliverRowChildDelegate(this.slivers, {this.rowBuilder = _defaultRowBuilder});

  static Widget _defaultRowBuilder(BuildContext context, Widget row) {
    return row;
  }
}

typedef RenderRow = Widget Function(BuildContext context, Widget row);
