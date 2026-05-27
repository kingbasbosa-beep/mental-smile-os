class ValueLabelMapper {
  static String map(String value, {bool isArabic = true}) {
    switch (value) {
      /// Payment status
      case 'active':
        return isArabic ? 'نشط' : 'Active';

      case 'inactive':
        return isArabic ? 'غير نشط' : 'Inactive';

      case 'approved':
        return isArabic ? 'تمت الموافقة' : 'Approved';

      case 'submitted_by_client':
      case 'pending_review':
      case 'under_review':
        return isArabic ? 'قيد المراجعة' : 'Under review';

      case 'rejected':
      case 'rejected_admin':
        return isArabic ? 'مرفوض' : 'Rejected';

      case 'awaiting_payment':
      case 'payment_pending':
        return isArabic ? 'بانتظار الدفع' : 'Awaiting payment';

      case 'payment_review':
        return isArabic
            ? 'إثبات الدفع قيد المراجعة'
            : 'Payment proof under review';

      /// Payout / transfer
      case 'paid_to_clinician':
        return isArabic ? 'تم التحويل للأخصائي' : 'Paid to clinician';

      case 'paid_to_center':
        return isArabic ? 'تم التحويل للمركز' : 'Paid to center';

      case 'blocked':
        return isArabic ? 'موقوف' : 'Blocked';

      case 'pending':
      case 'pending_admin':
        return isArabic ? 'قيد الانتظار' : 'Pending';

      case 'closed':
        return isArabic ? 'مغلق' : 'Closed';

      case 'completed':
      case 'completed_success':
        return isArabic ? 'مكتمل' : 'Completed';

      default:
        return value;
    }
  }
}
