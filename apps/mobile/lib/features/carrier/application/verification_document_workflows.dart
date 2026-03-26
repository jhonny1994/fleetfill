import 'package:file_picker/file_picker.dart';
import 'package:fleetfill/core/core.dart';
import 'package:fleetfill/features/carrier/carrier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final verificationDocumentWorkflowControllerProvider =
    Provider<VerificationDocumentWorkflowController>(
      VerificationDocumentWorkflowController.new,
    );

class VerificationDocumentUploadResult {
  const VerificationDocumentUploadResult({
    required this.document,
    required this.replacedExistingDocument,
  });

  final VerificationDocumentRecord document;
  final bool replacedExistingDocument;
}

class VerificationDocumentWorkflowController {
  const VerificationDocumentWorkflowController(this.ref);

  final Ref ref;

  Future<VerificationDocumentUploadResult?> pickAndUploadDocument({
    required VerificationEntityType entityType,
    required String entityId,
    required VerificationDocumentType documentType,
    required VerificationDocumentRecord? currentDocument,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      withData: kIsWeb,
      type: FileType.custom,
      allowedExtensions: const ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result == null) {
      return null;
    }

    final file = result.files.single;
    if (!kIsWeb && (file.path == null || file.path!.trim().isEmpty)) {
      return null;
    }
    if (kIsWeb && file.bytes == null) {
      return null;
    }

    final extension = (file.extension ?? '').toLowerCase();
    final contentType = switch (extension) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      _ => 'application/pdf',
    };

    final draft = VerificationUploadDraft(
      path: file.path ?? file.name,
      filename: file.name,
      extension: extension,
      contentType: contentType,
      byteSize: file.size,
      bytes: file.bytes,
    );

    final repository = ref.read(vehicleRepositoryProvider);
    await repository.uploadVerificationDocument(
      entityType: entityType,
      entityId: entityId,
      documentType: documentType,
      draft: draft,
    );
    final updatedDocuments = await repository
        .fetchVerificationDocumentsForEntity(
          entityType: entityType,
          entityId: entityId,
        );
    final latestForType = latestVerificationDocumentsByType(
      updatedDocuments.where((item) => item.documentType == documentType),
    );
    final newestDocument = latestForType.isEmpty ? null : latestForType.first;
    if (newestDocument == null) {
      return null;
    }

    ref
      ..invalidate(
        verificationDocumentsForEntityProvider(
          (entityType: entityType, entityId: entityId),
        ),
      )
      ..invalidate(myVerificationDocumentsProvider);

    return VerificationDocumentUploadResult(
      document: newestDocument,
      replacedExistingDocument: currentDocument != null,
    );
  }
}
