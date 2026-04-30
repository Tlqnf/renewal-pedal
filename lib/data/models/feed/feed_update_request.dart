class FeedUpdateRequest {
  final String title;
  final String? content;

  const FeedUpdateRequest({required this.title, this.content});

  Map<String, dynamic> toFormFields() => {
    'title': title,
    if (content != null) 'content': content,
  };
}
