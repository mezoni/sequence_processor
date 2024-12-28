sequence_processor
=======

Processing data to find sequences in the data.

Version 0.1.0

Example:

```dart
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

```

Output:

```
[1, 2]
Sequences not found
[1, 2, 3]
Found 1 sequence(s):
0: 123
[1, 2, 3, 4, 5]
Found 1 sequence(s):
0: 123
[1, 2, 3, 4, 5, 6, 7, 8]
Found 3 sequence(s):
0: 123
3: 456
6: 7
[1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3]
Found 4 sequence(s):
0: 123
3: 456
6: 7
8: 123
```
