import 'package:sequence_processor/sequence_processor.dart';

void main() {
  final sequences = {
    '123': [1, 2, 3],
    '456': [4, 5, 6],
    '7': [7],
  };

  final processor = SequenceProcessor<int, String>();
  processor.addSequences(sequences);
  _process(processor, [1, 2]);
  _process(processor, [1, 2, 3]);
  _process(processor, [1, 2, 3, 4, 5]);
  _process(processor, [1, 2, 3, 4, 5, 6, 7, 8]);
  _process(processor, [1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3]);
}

void _process(SequenceProcessor<int, String> processor, List<int> data) {
  final result = processor.process(data);
  final found = result.where((e) => e.data is String).toList();
  print('[${data.join(', ')}]');
  if (found.isEmpty) {
    print('Sequences not found');
  } else {
    print('Found ${found.length} sequence(s):');
    for (final element in found) {
      print('${element.index}: ${element.data}');
    }
  }
}
