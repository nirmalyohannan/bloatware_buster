enum AppListFilter {
  all,
  system,
  thirdParty,
  disabled,
  enabled,
}

String filterToString(AppListFilter filter) {
  switch (filter) {
    case AppListFilter.all:
      return "All";
    case AppListFilter.system:
      return "System";
    case AppListFilter.thirdParty:
      return "User Installed";
    case AppListFilter.disabled:
      return "Disabled";
    case AppListFilter.enabled:
      return "Enabled";
    default:
      return "All";
  }
}

String filterToFlag(AppListFilter filter) {
  switch (filter) {
    case AppListFilter.all:
      return "";
    case AppListFilter.system:
      return "-s";
    case AppListFilter.thirdParty:
      return "-3";
    case AppListFilter.disabled:
      return "-d";
    case AppListFilter.enabled:
      return "-e";
    default:
      return "";
  }
}



// The recommended ADB command to find a list of apps on your device is:

// adb shell pm list packages
// This command will display a list of all installed packages (apps) on your device, including their package names.

// Here are some additional options you can use with the command:

// -f: This option shows the path to the APK file associated with each package.
// -d: This option filters the results to only show disabled packages.
// -e: This option filters the results to only show enabled packages.
// -s: This option filters the results to only show system apps (pre-installed apps).
// -3: This option filters the results to only show third-party apps (apps you installed yourself).
// -u: This option includes uninstalled packages in the results.
  // -i: see the installer for the packages
  // -l: ignored (used for compatibility with older releases)
  // -U: also show the package UID
  // -u: also include uninstalled packages
  // --uid UID: filter to only show packages with the given UID
  // --user USER_ID: only list packages belonging to the given user
// For example, to see a list of only disabled system apps, you would use the following command:

// adb shell pm list packages -d -s