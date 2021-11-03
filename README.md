# docs

macOS reference documentation.

## macOS Update and Combo

### Mojave

**Update**

- [Download macOS Mojave 10.14.1 Update](https://support.apple.com/kb/DL1981)
  - [macOSUpd10.14.1.dmg](https://updates.cdn-apple.com/2019/cert/041-92743-20191011-2f320831-c69c-46c1-aff3-b882d5cccdad/macOSUpd10.14.1.dmg)
- [Download macOS Mojave 10.14.2 Update](https://support.apple.com/kb/DL1986)
  - [macOSUpd10.14.2.dmg](https://updates.cdn-apple.com/2019/cert/041-91756-20191011-bb717b5f-bc20-4a24-8923-096f743c5681/macOSUpd10.14.2.dmg)
- [Download macOS Mojave 10.14.3 Update](https://support.apple.com/kb/DL1991)
  - [macOSUpd10.14.3.dmg](https://updates.cdn-apple.com/2019/cert/041-88792-20191011-7bcb488d-8b8f-4e49-a59f-b525f210ec85/macOSUpd10.14.3.dmg)
- [Download macOS Mojave 10.14.4 Update](https://support.apple.com/kb/DL1994)
  - [macOSUpd10.14.4.dmg](https://updates.cdn-apple.com/2019/cert/061-41829-20191025-93e68605-ed90-412d-8f7b-da174c871a3c/macOSUpd10.14.4.dmg)
- [Download macOS Mojave 10.14.5 Update](https://support.apple.com/kb/DL2001)
  - [macOSUpd10.14.5.dmg](https://updates.cdn-apple.com/2019/cert/061-41821-20191025-a94dca04-679c-4c95-8965-1737c5c22d9c/macOSUpd10.14.5.dmg)
- [Download macOS Mojave 10.14.5 Supplemental Update for MacBook Pro](https://support.apple.com/kb/DL2005)
  - [macOSUpd10.14.5Supplemental.dmg](https://updates.cdn-apple.com/2019/cert/061-41817-20191025-b4a83d86-e31a-415a-800d-35c365195f6e/macOSUpd10.14.5Supplemental.dmg)
- [Download macOS Mojave 10.14.6 Update](https://support.apple.com/kb/DL2011)
  - [macOSUpd10.14.6.dmg](https://updates.cdn-apple.com/2019/cert/061-41423-20191024-3b2d1639-dbcf-449d-b0cb-0f922f1bda8b/macOSUpd10.14.6.dmg)

**Combo**

- [Download macOS Mojave 10.14.2 Combo Update](https://support.apple.com/kb/DL1987)
- [Download macOS Mojave 10.14.3 Combo Update](https://support.apple.com/kb/DL1992)
- [Download macOS Mojave 10.14.4 Combo Update](https://support.apple.com/kb/DL1996)
- [Download macOS Mojave 10.14.5 Combo Update](https://support.apple.com/kb/DL2000)
- [Download macOS Mojave 10.14.6 Combo Update](https://support.apple.com/kb/DL2010)

### Catalina

**Update**

- [Download macOS Catalina 10.15.1 Update](https://support.apple.com/kb/DL2022)
- [Download macOS Catalina 10.15.2 Update](https://support.apple.com/kb/DL2025)
- [Download macOS Catalina 10.15.3 Update](https://support.apple.com/kb/DL2029)
- [Download macOS Catalina 10.15.4 Update](https://support.apple.com/kb/DL2036)
- [Download macOS Catalina 10.15.4 Supplemental Update](https://support.apple.com/kb/DL2038)
- [Download macOS Catalina 10.15.5 Update](https://support.apple.com/kb/DL2039)
- [Download macOS Catalina 10.15.5 Supplemental Update](https://support.apple.com/kb/DL2043)
- [macOS Catalina 10.15.5 Supplemental Update for MacBook Pro (16-inch, AMD Radeon Pro 5600M)](https://support.apple.com/kb/DL2044)
- [macOS Catalina 10.15.6 Update](https://support.apple.com/kb/DL2047)
- [Download macOS Catalina 10.15.6 Supplemental Update](https://support.apple.com/kb/DL2049)

**Combo**

- [Download macOS Catalina 10.15.2 Combo Update](https://support.apple.com/kb/DL2028)
- [Download macOS Catalina 10.15.3 Combo Update](https://support.apple.com/kb/DL2030)
- [Download macOS Catalina 10.15.4 Combo Update](https://support.apple.com/kb/DL2037)
- [Download macOS Catalina 10.15.5 Combo Update](https://support.apple.com/kb/DL2040)
- [macOS Catalina 10.15.6 Combo Update](https://support.apple.com/kb/DL2048)

### Downloads

https://support.apple.com/downloads

### Search download pages

["Download+macOS"+site:support.apple.com/downloads - Google](https://www.google.com/search?q=%22Download+macOS%22+site%3Asupport.apple.com/downloads)

## Developer Documentations

### JP

- https://web.archive.org/web/20180618155327/https://developer.apple.com/jp/documentation/
- [Instrumentsユーザガイド](https://web.archive.org/web/20170616034453/https://developer.apple.com/jp/documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/TheInstrumentsWorkflow.html#//apple_ref/doc/uid/TP40004652-CH5-SW1)

## TCC.db services

[macOS TCC.db Internals by keith | Rainforest Engineering](https://rainforest.engineering/2021-02-09-macos-tcc/)

It is possible to inspect the localizable strings for the tcc framework to determine what (some) of the valid services are.
Using the command `plutil -p /System/Library/PrivateFrameworks/TCC.framework/Resources/en.lproj/Localizable.strings` gives us the following list of services along with what the user will be prompted with when access is requested.

- kTCCServiceAddressBook - client would like to access your contacts.
- kTCCServiceAppleEvents - client wants access to control indirect_object. Allowing control will provide access to documents and data in indirect_object, and to perform actions within that app.
- kTCCServiceBluetoothAlways - client would like to use Bluetooth.
- kTCCServiceCalendar - client would like to access your calendar.
- kTCCServiceCamera - client would like to access the camera.
- kTCCServiceContactsFull - client would like to access all of your contacts information.
- kTCCServiceContactsLimited - client would like to access your contacts basic information.
- kTCCServiceFileProviderDomain - client wants to access files managed by indirect_object.
- kTCCServiceFileProviderPresence - Do you want to allow client to see when you are using files managed by it? It will see which applications are used to access files and whether you are actively using them. It will not see when files that are not managed by it are accessed.
- kTCCServiceLocation - client would like to use your current location.
- kTCCServiceMediaLibrary - client would like to access Apple Music, your music and video activity, and your media library.
- kTCCServiceMicrophone - client would like to access the microphone.
- kTCCServiceMotion - client Would Like to Access Your Motion & Fitness Activity.
- kTCCServicePhotos - client Would Like to Access Your Photos
- kTCCServicePhotosAdd - client Would Like to Add to your Photos
- kTCCServicePrototype3Rights - client Would Like Authorization to Test Service Proto3Right.
- kTCCServicePrototype4Rights - client Would Like Authorization to Test Service Proto4Right.
- kTCCServiceReminders - client would like to access your reminders.
- kTCCServiceScreenCapture - client would like to capture the contents of the system display.
- kTCCServiceSiri - Would You Like to Use client with Siri?
- kTCCServiceSpeechRecognition - client Would Like to Access Speech Recognition.
- kTCCServiceSystemPolicyDesktopFolder - client would like to access files in your Desktop folder.
- kTCCServiceSystemPolicyDeveloperFiles - client would like to access a file used in Software Development.
- kTCCServiceSystemPolicyDocumentsFolder - client would like to access files in your Documents folder.
- kTCCServiceSystemPolicyDownloadsFolder - client would like to access files in your Downloads folder.
- kTCCServiceSystemPolicyNetworkVolumes - client would like to access files on a network volume.
- kTCCServiceSystemPolicyRemovableVolumes - client would like to access files on a removable volume.
- kTCCServiceSystemPolicySysAdminFiles - client would like to administer your computer. Administration can include modifying passwords, networking, and system settings.
- kTCCServiceWillow - client would like to access your Home data.

Some other values(from running strings on tccd binary, observation, and other places online):

- kTCCServiceSystemPolicyAllFiles - Full Disk Access
- kTCCServiceAccessibility - Allows app to control your computer
- kTCCServicePostEvent - Allows to send keystrokes
- kTCCServiceListenEvent - Input Monitoring; to monitor input from your keyboard
- kTCCServiceDeveloperTool - Allows app to run software locally that do not meet the system’s security policy

These seem to be carry-overs from iOS, and may not apply on macOS:

- kTCCServiceLiverpool - Related to location services
- kTCCServiceUbiquity - Related to iCloud
- kTCCServiceShareKit - Related to the share feature(presumably from iOS)(ShareKit)

There’s also some for specific social networks; again I suspect this is a carry-over from iOS.

- kTCCServiceLinkedIn - LinkedIn
- kTCCServiceTwitter - Twitter
- kTCCServiceFacebook - Facebook
- kTCCServiceSinaWeibo - Sina Weibo
- kTCCServiceTencentWeibo - Tencent Weibo
