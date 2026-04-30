class TermsMockData {
  static final List<Map<String, dynamic>> terms = [
    {
      'id': 'service',
      'label': '서비스 이용약관 (필수)',
      'required': true,
      'hasDetail': true,
    },
    {
      'id': 'privacy',
      'label': '개인정보 수집 및 이용 (필수)',
      'required': true,
      'hasDetail': true,
    },
    {
      'id': 'location',
      'label': '위치기반 이용약관 (필수)',
      'required': true,
      'hasDetail': true,
    },
    {
      'id': 'marketing',
      'label': '광고성 푸시 알림 (선택)',
      'required': false,
      'hasDetail': false,
    },
  ];

  static final Map<String, Map<String, dynamic>> termsDetails = {
    'service': {
      'title': '서비스 이용약관',
      'sections': [
        {
          'title': '제 1조',
          'content':
              '1조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요.2조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요.1조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요2조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요',
        },
        {
          'title': '제 2조',
          'content':
              '2조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요.2조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요.1조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요2조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요',
        },
        {
          'title': '제 3조',
          'content':
              '3조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요.3조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요.1조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요2조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요',
        },
        {
          'title': '제 4조',
          'content':
              '4조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요.4조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요.1조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요2조의 내용 어쩌고 저쩌고 내용이 있어요. 어쩌고, 저쩌고 내용도 있고요',
        },
      ],
    },
    'privacy': {
      'title': '개인정보 수집 및 이용',
      'sections': [
        {'title': '제 1조', 'content': '개인정보 수집 및 이용에 관한 내용입니다...'},
      ],
    },
    'location': {
      'title': '위치기반 이용약관',
      'sections': [
        {'title': '제 1조', 'content': '위치기반 서비스 이용에 관한 내용입니다...'},
      ],
    },
  };
}
