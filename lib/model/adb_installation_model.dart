class AdbInstallationModel {
  bool isAdbInstalling = false;
  String? installationMessage;
  String? errorMessage;

  bool get hasError => errorMessage != null;
}
