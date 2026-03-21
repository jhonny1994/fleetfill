import 'package:fleetfill/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DisputeEvidenceRecord parses optional metadata', () {
    final record = DisputeEvidenceRecord.fromJson({
      'id': 'evidence-1',
      'dispute_id': 'dispute-1',
      'storage_path': 'dispute-1/1/file.pdf',
      'note': 'Damaged box corner',
      'content_type': 'application/pdf',
      'byte_size': 1024,
      'uploaded_by': 'shipper-1',
      'created_at': '2026-03-21T10:00:00Z',
    });

    expect(record.id, 'evidence-1');
    expect(record.disputeId, 'dispute-1');
    expect(record.isPdf, isTrue);
    expect(record.note, 'Damaged box corner');
  });
}
