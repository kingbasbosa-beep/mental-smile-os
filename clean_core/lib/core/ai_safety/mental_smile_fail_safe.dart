import 'conversation_control_mode.dart';
import 'mental_smile_response_contract.dart';
import 'mental_smile_response_mode.dart';
import 'mental_smile_risk_result.dart';

class MentalSmileFailSafe {
  const MentalSmileFailSafe._();

  static const String fallbackNoticeAr =
      'لا يمكن للذكاء الاصطناعي التعامل مع هذا بأمان الآن. يرجى طلب مساعدة بشرية مؤهلة.';

  static const String fallbackNoticeEn =
      'AI cannot handle this safely right now. Please seek qualified human help.';

  static MentalSmileRiskResult riskResult() {
    return MentalSmileRiskResult.failClosed();
  }

  static MentalSmileResponseContract responseContract({
    required bool isArabic,
  }) {
    return MentalSmileResponseContract(
      responseMode: MentalSmileResponseMode.failSafe,
      controlMode: ConversationControlMode.lockedForReview,
      outputValidated: false,
      requiresHumanReview: true,
      safetyNotice: isArabic ? fallbackNoticeAr : fallbackNoticeEn,
    );
  }
}
