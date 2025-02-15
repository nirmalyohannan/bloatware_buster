const Map<String, String> packageNameMap = {
  //android os apps
  "com.android.browser": "Browser",
  "com.android.calendar": "Calendar",
  "com.android.camera": "Camera",
  "com.android.contacts": "Contacts",
  "com.android.deskclock": "Clock",
  "com.android.dialer": "Phone",
  "com.android.email": "Email",
  "com.android.gallery3d": "Gallery",
  "com.android.mms": "Messages",
  "com.android.music": "Music",
  "com.android.settings": "Settings",
  "com.android.vending": "Google Play Store",
  "com.android.chrome": "Google Chrome",
  "com.android.calculator2": "Calculator",
  "com.android.providers.downloads.ui": "Downloads",
  "com.android.stk": "SIM Toolkit",
  "com.android.soundrecorder": "Sound Recorder",
  "com.android.vpndialogs": "VPN Services",
  "com.android.wallpaper.livepicker": "Live Wallpaper Picker",
  "com.android.quicksearchbox": "Quick Search Box",
  "com.android.providers.media": "Media Storage",
  "com.android.providers.userdictionary": "User Dictionary",
  "com.android.packageinstaller": "Package Installer",
  "com.android.inputmethod.latin": "Gboard",
  "com.android.systemui": "System UI",
  "com.android.phone": "Phone Services",
  "com.android.nfc": "NFC Service",
  "com.android.backupconfirm": "Backup",
  "com.android.bluetooth": "Bluetooth",
  "com.android.captiveportallogin": "Captive Portal Login",
  "com.android.providers.contacts": "Contacts Storage",
  "com.android.providers.calendar": "Calendar Storage",
  //Google apps
  "com.google.android.gm": "Gmail",
  "com.google.android.apps.maps": "Google Maps",
  "com.google.android.youtube": "YouTube",
  "com.google.android.apps.photos": "Google Photos",
  "com.google.android.music": "Google Play Music",
  "com.google.android.videos": "Google Play Movies & TV",
  "com.google.android.apps.docs": "Google Drive",
  "com.google.android.apps.keep": "Google Keep",
  "com.google.android.calendar": "Google Calendar",
  "com.google.android.apps.tasks": "Google Tasks",
  "com.google.android.contacts": "Google Contacts",
  "com.google.android.apps.tachyon": "Google Meet",
  "com.google.android.apps.meetings": "Google Meet",
  "com.google.android.apps.magazines": "Google News",
  "com.google.android.apps.walletnfcrel": "Google Pay",
  "com.google.android.apps.books": "Google Play Books",
  "com.google.android.apps.podcasts": "Google Podcasts",
  "com.google.android.talk": "Google Chat",
  "com.google.android.apps.wellbeing": "Digital Wellbeing",
  "com.google.android.apps.messaging": "Google Messages",
  "com.google.android.apps.fitness": "Google Fit",
  "com.google.android.apps.photosgo": "Gallery Go",
  "com.google.android.projection.gearhead": "Android Auto",
  "com.google.android.projection.gearhead:smartdevice":
      "Android Auto for Phone Screens",
  "com.google.android.gms": "Google Play Services",
  "com.google.android.play.games": "Google Play Games",
  "com.google.android.gms.location.history": "Google Timeline",
  "com.google.android.gsf.login": "Google Account Manager",
  "com.google.android.partnersetup": "Google Partner Setup",
  "com.google.android.deskclock": "Clock",
  "com.google.android.calculator": "Calculator",
  "com.google.android.apps.inputmethod.latin": "Gboard",
  "com.google.android.apps.chromecast.app": "Google Home",
  "com.google.android.apps.youtube.music": "YouTube Music",
  "com.google.android.apps.nbu.files": "Files by Google",
  "com.google.android.apps.subscriptions.red": "Google One",
  "com.google.android.apps.googleassistant": "Google Assistant",
  "com.google.android.inputmethod.latin": "Gboard",
  "com.google.android.subscriptions.one": "Google One",
  "com.google.android.apps.assistant": "Google Assistant",
  //MIUI apps
  "com.miui.weather2": "MIUI Weather",
  "com.miui.calculator": "MIUI Calculator",
  "com.miui.notes": "MIUI Notes",
  "com.miui.miwallpaper": "MIUI Wallpaper",
  "com.miui.compass": "MIUI Compass",
  "com.miui.videoplayer": "MIUI Video Player",
  "com.miui.player": "MIUI Music",
  "com.miui.securitycenter": "MIUI Security",
  "com.miui.screenrecorder": "MIUI Screen Recorder",
  "com.miui.fm": "MIUI FM Radio",
  "com.miui.voiceassist": "MIUI Voice Assistant",
  "com.miui.camera": "MIUI Camera",
  "com.miui.gallery": "MIUI Gallery",
  "com.miui.fileexplorer": "MIUI File Manager",
  "com.miui.cloudservice": "MIUI Cloud",
  "com.miui.cloudbackup": "MIUI Backup",
  "com.miui.hybrid": "MIUI Browser",
  "com.miui.cleanmaster": "MIUI Cleaner",
  "com.miui.guardprovider": "MIUI Antivirus",
  "com.miui.packageinstaller": "MIUI Package Installer",
  "com.miui.powerkeeper": "MIUI Battery Saver",
  "com.miui.bugreport": "MIUI Bug Report",
  "com.miui.weather": "MIUI Weather",
  "com.miui.systemAdSolution": "MIUI Ad Services",
  "com.xiaomi.account": "Xiaomi Account",
  "com.xiaomi.shop": "Mi Store",
  "com.xiaomi.smarthome": "Mi Home",
  "com.xiaomi.passport": "Xiaomi Services & Feedback",
  "com.xiaomi.midrop": "Mi Drop",
  "com.xiaomi.router": "Mi Wi-Fi",
  "com.xiaomi.market": "GetApps",
  "com.xiaomi.mipicks": "Mi Picks",
  "com.miui.home": "MIUI Launcher",
  "com.miui.backup": "MIUI Backup",
  "com.miui.cloudservice.sysbase": "MIUI Cloud Service",
  "com.miui.daemon": "MIUI Daemon",
  "com.miui.gallery3d": "MIUI Gallery",
  "com.miui.home.launcher.assistant": "MIUI Launcher Assistant",
  "com.miui.hybrid.accessory": "MIUI Browser Accessory",
  "com.miui.providers.appindex": "MIUI App Index",
  "com.miui.providers.weather": "MIUI Weather Provider",
  "com.miui.providers.calendar": "MIUI Calendar Provider",
  "com.miui.providers.contacts": "MIUI Contacts Provider",
  "com.miui.providers.downloads.ui": "MIUI Downloads UI",
  "com.miui.providers.telephony": "MIUI Telephony Provider",
  "com.miui.providers.userdictionary": "MIUI User Dictionary Provider",
  "com.miui.securityadd": "MIUI Security Add-on",
  "com.miui.supernote": "MIUI Super Note",
  "com.miui.video": "MIUI Video",
  "com.miui.voicerecorder": "MIUI Voice Recorder",
  "com.miui.virtualsim": "MIUI Virtual SIM",
  "com.miui.weather.service": "MIUI Weather Service",
  "com.miui.yellowpage": "MIUI Yellow Page",
  "com.xiaomi.finddevice": "Find My Device",
  "com.xiaomi.gamecenter": "Mi Game Center",
  "com.xiaomi.jr": "Mi Credit",
  "com.xiaomi.loan": "Mi Loan",
  "com.xiaomi.mico": "Mi AI",
  "com.xiaomi.mimobile.noti": "Mi Notification",
  "com.xiaomi.scanner": "Mi Scanner",
  //Other apps
  "com.whatsapp": "WhatsApp",
  "com.facebook.katana": "Facebook",
  "com.instagram.android": "Instagram",
  "com.snapchat.android": "Snapchat",
  "com.twitter.android": "Twitter",
  "com.netflix.mediaclient": "Netflix",
  "com.spotify.music": "Spotify",
  "com.ubercab": "Uber",
  "com.airbnb.android": "Airbnb",
  "com.microsoft.office.word": "Microsoft Word",
  "com.microsoft.office.excel": "Microsoft Excel",
  "com.microsoft.office.powerpoint": "Microsoft PowerPoint",
  "com.skype.raider": "Skype",
  "com.dropbox.android": "Dropbox",
  "com.adobe.reader": "Adobe Acrobat Reader",
  "com.amazon.mShop.android.shopping": "Amazon Shopping",
  "com.ebay.mobile": "eBay",
  "com.paypal.android.p2pmobile": "PayPal",
  "com.waze": "Waze",
  "com.linkedin.android": "LinkedIn",
  "com.reddit.frontpage": "Reddit",
  "com.tiktok.android": "TikTok",
  "com.pinterest": "Pinterest",
  "com.teslacoilsw.launcher": "Nova Launcher",
  "com.clearchannel.iheartradio.controller": "iHeartRadio",
  //Vivo apps
  "com.bbk.updater": "System Update",
  "com.bbk.theme": "iQOO Theme",
  "com.vivo.email": "iQOO Email",
  "com.vivo.gallery": "iQOO Gallery",
  "com.vivo.browser": "iQOO Browser",
  "com.vivo.camera": "iQOO Camera",
  "com.iqoo.secure": "iQOO Security",
  "com.android.bbkmusic": "iQOO Music",
  "com.iqoo.video": "iQOO Video Player",
  "com.vivo.weather": "iQOO Weather",
  "com.vivo.calculator": "iQOO Calculator",
  "com.vivo.weather.provider": "iQOO Weather Provider",
  "com.vivo.compass": "iQOO Compass",
  "com.vivo.daemonService": "iQOO Daemon Service",
  "com.vivo.doubleinstance": "iQOO Dual Apps",
  "com.vivo.easyshare": "iQOO EasyShare",
  "com.vivo.filemanager": "iQOO File Manager",
  "com.vivo.findphone": "iQOO Find My Phone",
  "com.vivo.childrenmode": "iQOO Kids Mode",
  "com.vivo.livewallpaper": "iQOO Live Wallpaper",
  "com.vivo.note": "iQOO Notes",
  "com.vivo.PimContacts": "iQOO Contacts",
  "com.vivo.podcast": "iQOO Podcast",
  "com.vivo.remotecamera": "iQOO Remote Camera",
  "com.vivo.screenrecorder": "iQOO Screen Recorder",
  "com.vivo.smartmotion": "iQOO Smart Motion",
  "com.vivo.smartwakecustom": "iQOO Smart Wake",
  "com.vivo.soundrecorder": "iQOO Sound Recorder",
  "com.vivo.videoshare": "iQOO Video Share",
  "com.vivo.voiceassistant": "iQOO Voice Assistant",
  "com.vivo.wallpaper": "iQOO Wallpaper",
  "com.vivo.wifitransfer": "iQOO Wi-Fi Transfer",
  "com.vivo.wallet": "iQOO Wallet",
  "com.vivo.vhome": "iQOO V-Home",
  "com.iqoo.securecleaner": "iQOO Secure Cleaner",
  "com.vivo.health": "iQOO Health",
  "com.vivo.space": "iQOO App Clone",
  "com.vivo.appstore": "iQOO App Store",
  "com.iqoo.screencapture": "iQOO Screenshot",
  "com.iqoo.feedback": "iQOO Feedback",
  "com.iqoo.safe": "iQOO Safe",
  "com.iqoo.recovery": "iQOO Recovery",
  "com.vivo.upnpserver": "iQOO DLNA Server",
  "com.vivo.dream.camera": "iQOO Dream Camera",
  "com.vivo.iqoo.gameassistant": "iQOO Game Assistant",
  "com.vivo.assistant": "iQOO Jovi Assistant",
  "com.iqoo.launcher": "iQOO Launcher",
  "com.vivo.browser.overlay": "iQOO Browser Overlay",
  "com.vivo.widget": "iQOO Widgets",
  "com.vivo.videoeditor": "iQOO Video Editor",
  "com.vivo.fingerprint": "iQOO Fingerprint",
  "com.vivo.autoinstallapk": "iQOO Auto Installer",
  "com.vivo.ime": "iQOO Keyboard",
  "com.vivo.flashlight": "iQOO Flashlight",
  "com.vivo.weather.news": "iQOO Weather News",
  "com.vivo.offlinevoice": "iQOO Offline Voice",
  "com.vivo.smartvoice": "iQOO Smart Voice",
  "com.vivo.earthquake": "iQOO Earthquake Alert",
  "com.vivo.focusmode": "iQOO Focus Mode",
  "com.vivo.security.threatscan": "iQOO Threat Scan",
  "com.vivo.vipservice": "iQOO VIP Service",
  "com.vivo.privacy": "iQOO Privacy",
  "com.vivo.faceunlock": "iQOO Face Unlock",
  "com.vivo.ai": "iQOO AI Engine",
};
