import '../../../backend/backend.dart';
import '../../../core/app_export.dart';
import '../../../domain/auth/auth_util.dart';
import '../../../widgets/emblem/emblem_widget.dart';

class EmblemGenerationController extends GetxController {
  List<GeneratedEmblems?>? emblems;
  EmblemType? emblemType;
  String displayName = '';

  setEmblems(List<GeneratedEmblems?>? emblems) {
    this.emblems = emblems;
    update();
  }

  Future getEmblems() async {
    UsersRecord? usersRecord =
        currentUserDocument ?? await initCurrentUserDocument();

    emblems = await usersRecord?.generatedEmblems?.toList() ?? [];
    emblemType = stringToEmblemType(await usersRecord?.emblemType);
    update();
  }

  @override
  void onReady() async {
    displayName = await currentUserDisplayName;
    // await showOverlay(asyncFunction: getEmblems);
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
