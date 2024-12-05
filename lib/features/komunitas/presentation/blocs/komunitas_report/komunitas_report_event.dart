part of 'komunitas_report_bloc.dart';

abstract class KomunitasReportEvent extends Equatable {
  const KomunitasReportEvent();

  @override
  List<Object> get props => [];
}

class KomunitasReportPost extends KomunitasReportEvent {
  final String uid;
  final String postId;
  const KomunitasReportPost({
    required this.uid,
    required this.postId,
  });

  @override
  List<Object> get props => [uid, postId];
}

class KomunitasReportComment extends KomunitasReportEvent {
  final String uid;
  final String commentId;
  const KomunitasReportComment({
    required this.uid,
    required this.commentId,
  });

  @override
  List<Object> get props => [uid, commentId];
}
