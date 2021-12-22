part of draggable_grid_view;

class DragTargetGrid extends StatefulWidget {
  final int index;
  final VoidCallback voidCallback;
  final Widget? feedback;
  final Widget? childWhenDragging;
  final PlaceHolderWidget? placeHolder;
  final DragCompletion dragCompletion;

  const DragTargetGrid({
    Key? key,
    required this.index,
    required this.voidCallback,
    this.feedback,
    this.childWhenDragging,
    this.placeHolder,
    required this.dragCompletion,
  }) : super(key: key);

  @override
  _DragTargetGridState createState() => _DragTargetGridState();
}

class _DragTargetGridState extends State<DragTargetGrid> {
  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAccept: (data) => setState(() {
        onDragComplete(widget.index);
      }),
      onLeave: (details) {
        // print('onLeave: $details');
      },
      onWillAccept: (details) {
        return true;
      },
      onMove: (details) {
        setState(() {
          setDragStartedData(details, widget.index);
          checkIndexesAreDifferent(details, widget.index);
          widget.voidCallback();
        });
      },
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        /// [isOnlyLongPress] is true then set the 'LongPressDraggableGridView' class or else set 'PressDraggableGridView' class.
        return (_isOnlyLongPress)
            ? LongPressDraggableGridView(
                index: widget.index,
                feedback: widget.feedback,
                childWhenDragging: widget.childWhenDragging,
              )
            : PressDraggableGridView(
                index: widget.index,
                feedback: widget.feedback,
                childWhenDragging: widget.childWhenDragging,
                onDragCancelled: () {
                  onDragComplete(_lastIndex);
                },
              );
      },
    );
  }

  void setDragStartedData(DragTargetDetails details, int index) {
    if (_dragStarted) {
      _dragStarted = false;
      _draggedIndexRemoved = false;
      _draggedIndex = details.data;
      _draggedGridItem = DraggableGridItem(child: EmptyItem(), isDraggable: true);
      _lastIndex = _draggedIndex;
    }
  }

  void checkIndexesAreDifferent(DragTargetDetails details, int index) {
    /// Here, check [_draggedIndex] is != -1.
    /// And also check index is not equal to _lastIndex. Means if both will true then skip it. else do some operations.
    ///
    if (_draggedIndex != -1 && index != _lastIndex) {
      _list.removeWhere((element) {
        return (widget.placeHolder != null)
            ? element.child is PlaceHolderWidget
            : element.child is EmptyItem;
      });

      /// store _lastIndex as index.
      /// Means draggedIndex is 6 and dragged child is at index 4 then set _lastIndex to 4.
      _lastIndex = index;

      /// Here, we are checking _draggedIndex is greater than _lastIndex.
      /// For ex:
      /// If _draggedIndex is 6 and _lastIndex = 4 then _draggedChild will be 5.
      if (_draggedIndex > _lastIndex) {
        _draggedGridItem = _orgList[_draggedIndex - 1];
      } else {
        _draggedGridItem = _orgList[(_draggedIndex + 1 >= _list.length)
            ? _draggedIndex
            : _draggedIndex + 1];
      }
      if (_draggedIndex == _lastIndex) {
        _draggedGridItem = DraggableGridItem(child: widget.placeHolder ?? EmptyItem(), isDraggable: true);
      }
      if (!_draggedIndexRemoved) {
        _draggedIndexRemoved = true;
        _list.removeAt(_draggedIndex);
      }
      _list.insert(
        _lastIndex,
          DraggableGridItem(child: widget.placeHolder ?? EmptyItem(), isDraggable: true),
      );
    }
  }

  void onDragComplete(int index) {
    if(_draggedIndex==-1) return;
    _list.removeAt(index);
    _list.insert(
      index,
      _orgList[_draggedIndex],
    );
    _orgList = [..._list];
    _dragStarted = false;
    _draggedIndex = -1;
    _draggedGridItem = null;
    widget.voidCallback();
    widget.dragCompletion.onDragAccept(_orgList);
  }
}