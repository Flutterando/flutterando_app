class Email {
  final String addressee;
  final String recipientName;
  final String title;
  final String? emailBody;
  final String? templateId;
  final Map<String, dynamic>? templateData;

  Email.text({
    required this.addressee,
    required this.recipientName,
    required this.title,
    required this.emailBody,
  })  : templateId = null,
        templateData = null;

  Email.template({
    required this.addressee,
    required this.recipientName,
    required this.title,
    required this.templateId,
    this.templateData,
  }) : emailBody = null;

  Map<String, dynamic> _personalizationsMap() {
    Map<String, dynamic> returnMap = {
      "to": [
        {"email": addressee, "name": recipientName},
      ],
      "subject": title,
    };

    if (templateData != null) {
      returnMap['dynamic_template_data'] = templateData;
    }

    return returnMap;
  }

  Map<String, dynamic> toMap(
      {required String fromEmail, required String fromName}) {
    Map<String, dynamic> returnMap = {
      "from": {"email": fromEmail, "name": fromName},
      "personalizations": [_personalizationsMap()],
    };
    if (emailBody != null) {
      returnMap['content'] = [
        {"type": "text/plain", "value": emailBody},
      ];
    }
    if (templateId != null) {
      returnMap['template_id'] = templateId;
    }

    return returnMap;
  }
}
