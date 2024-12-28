import 'package:sequence_processor/sequence_processor.dart';
import 'package:test/test.dart';

void main() {
  _test();
}

void _test() {
  test('Sequence', () {
    final sequences = {
      '123': [1, 2, 3],
      '456': [4, 5, 6],
      '7': [7],
    };

    final processor = SequenceProcessor<int, String>();
    processor.addSequences(sequences);

    {
      const r1 = [1];
      final r2 = processor.process(r1);
      final r3 = <SequenceElement<int, String>>[
        SequenceElement(element: 1, index: 0)
      ];
      expect('$r2', '$r3', reason: 'Data: $r1');
    }
    {
      const r1 = [1, 2];
      final r2 = processor.process(r1);
      final r3 = <SequenceElement<int, String>>[
        SequenceElement(element: 1, index: 0),
        SequenceElement(element: 2, index: 1),
      ];
      expect('$r2', '$r3', reason: 'Data: $r1');
    }
    {
      const r1 = [1, 2, 3];
      final r2 = processor.process(r1);
      final r3 = <SequenceElement<int, String>>[
        SequenceElement(data: '123', index: 0, sequence: [1, 2, 3]),
      ];
      expect('$r2', '$r3', reason: 'Data: $r1');
    }
    {
      const r1 = [1, 2, 3, 4];
      final r2 = processor.process(r1);
      final r3 = <SequenceElement<int, String>>[
        SequenceElement(data: '123', index: 0, sequence: [1, 2, 3]),
        SequenceElement(element: 4, index: 3),
      ];
      expect('$r2', '$r3', reason: 'Data: $r1');
    }
    {
      const r1 = [1, 2, 3, 4, 5];
      final r2 = processor.process(r1);
      final r3 = <SequenceElement<int, String>>[
        SequenceElement(data: '123', index: 0, sequence: [1, 2, 3]),
        SequenceElement(element: 4, index: 3),
        SequenceElement(element: 5, index: 4),
      ];
      expect('$r2', '$r3', reason: 'Data: $r1');
    }
    {
      const r1 = [1, 2, 3, 4, 5, 6];
      final r2 = processor.process(r1);
      final r3 = <SequenceElement<int, String>>[
        SequenceElement(data: '123', index: 0, sequence: [1, 2, 3]),
        SequenceElement(data: '456', index: 3, sequence: [4, 5, 6]),
      ];
      expect('$r2', '$r3', reason: 'Data: $r1');
    }
    {
      const r1 = [1, 2, 3, 4, 5, 6, 7];
      final r2 = processor.process(r1);
      final r3 = <SequenceElement<int, String>>[
        SequenceElement(data: '123', index: 0, sequence: [1, 2, 3]),
        SequenceElement(data: '456', index: 3, sequence: [4, 5, 6]),
        SequenceElement(data: '7', index: 6, sequence: [7]),
      ];
      expect('$r2', '$r3', reason: 'Data: $r1');
    }
    {
      const r1 = [1, 2, 3, 4, 5, 6, 7, 8];
      final r2 = processor.process(r1);
      final r3 = <SequenceElement<int, String>>[
        SequenceElement(data: '123', index: 0, sequence: [1, 2, 3]),
        SequenceElement(data: '456', index: 3, sequence: [4, 5, 6]),
        SequenceElement(data: '7', index: 6, sequence: [7]),
        SequenceElement(element: 8, index: 7),
      ];
      expect('$r2', '$r3', reason: 'Data: $r1');
    }
  });
}
