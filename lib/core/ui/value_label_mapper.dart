class ValueLabelMapper {
  static String map(String value, {bool isArabic = true}) {
    switch (value) {
      /// Payment status
      case 'approved':
        return isArabic ? 'تمت الموافقة' : 'Approved';

      case 'submitted_by_client':
        return isArabic ? 'بانتظار المراجعة' : 'Pending Review';

      case 'rejected':
        return isArabic ? 'مرفوض' : 'Rejected';

      /// Payout / transfer
      case 'paid_to_clinician':
        return isArabic ? 'تم التحويل للأخصائي' : 'Paid to Clinician';

      case 'paid_to_center':
        return isArabic ? 'تم التحويل للمركز' : 'Paid to Center';

      case 'blocked':
        return isArabic ? 'موقوف' : 'Blocked';

      case 'pending':
        return isArabic ? 'قيد الانتظار' : 'Pending';

      default:
        return value;
    }
  }
}
