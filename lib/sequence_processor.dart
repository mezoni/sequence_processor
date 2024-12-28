class SequenceElement<E, T> {
  T? data;

  E? element;

  int index;

  List<E>? sequence;

  SequenceElement({
    this.data,
    this.element,
    required this.index,
    this.sequence,
  });

  @override
  String toString() {
    final list = <String>[];
    list.add('data: $data');
    list.add('element: $element');
    list.add('index: $index');
    if (sequence == null) {
      list.add('sequence: null');
    } else {
      list.add('sequence: [${sequence!.join(',')}]');
    }

    return list.join(', ');
  }
}

class SequenceProcessor<E, T> {
  final Map<E, _SequenceNode<E, T>> _root = {};

  void addSequence(List<E> sequence, T? data) {
    var nodes = _root;
    _SequenceNode<E, T>? node;
    for (var i = 0; i < sequence.length; i++) {
      final element = sequence[i];
      final isTerminal = i == sequence.length - 1;
      node = nodes[element];
      if (node == null) {
        node = _SequenceNode(sequence);
        nodes[element] = node;
      } else {
        if (isTerminal && node.isTerminal) {
          throw StateError('''
Duplicate sequences: ${sequence.join(', ')}
found: ${node.data}
current: $data''');
        }
      }

      if (isTerminal) {
        node.isTerminal = true;
        node.data = data;
      } else {
        nodes = node.children;
      }
    }
  }

  void addSequences(Map<T, List<E>> sequences) {
    for (final entry in sequences.entries) {
      addSequence(entry.value, entry.key);
    }
  }

  List<SequenceElement<E, T>> process(List<E> data) {
    final result = <SequenceElement<E, T>>[];
    for (var i = 0; i < data.length; i++) {
      final ch = data[i];
      var node = _root[ch];
      if (node == null) {
        result.add(SequenceElement(element: ch, index: i));
        continue;
      }

      var children = node.children;
      var j = i + 1;
      for (; j < data.length; j++) {
        final element = data[j];
        final next = children[element];
        if (next == null) {
          break;
        }

        node = next;
        children = next.children;
      }

      node = node!;
      if (!node.isTerminal) {
        result.add(SequenceElement(element: ch, index: i));
      } else {
        result.add(SequenceElement(
            data: node.data, index: i, sequence: node.sequence));
        i = j - 1;
      }
    }

    return result;
  }
}

class _SequenceNode<E, T> {
  Map<E, _SequenceNode<E, T>> children = {};

  T? data;

  bool isTerminal = false;

  List<E> sequence;

  _SequenceNode(this.sequence, [this.data]);
}
