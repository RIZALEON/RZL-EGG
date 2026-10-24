# DRAGON SKULL iOS feed → Drive · STAGED (not signed, not published)
Finding: the iOS app (RFORGE/RDRAGONSKULL/ios/dd/Build/Products/Release-iphoneos/DRAGON SKULL.app, 1.0.4 build 9)
hard-codes Info.plist DSSelfUpdateManifestURL =
  https://raw.githubusercontent.com/rizalward/RZL-EGG/main/dragon-skull/ios-web/appcast.json  (404; rizalward gone, rizaleon has no copy)
Drive search (sekyungafam@gmail.com + account-2, names RZL-EGG / appcast / .ipa / ios-web / dragon-skull): NO appcast.json or
dragon-skull/ios-web feed exists on Drive. Found only: DRAGON-SKULL_1.0.2.apk (Android), dragon-skull_1.0.0_amd64.deb (acct 2),
ipa-stage/Payload folders (acct 2, 10BH5BxeOyxHjowiR30lVCUyyl1P6vxig / 19Fg0WDyyepypV7ST_AtOXKvTOy9t4NU_), rzl-egg-convert folders (acct 2),
SIGN-AND-PUSH-RZL-EGG.command (that is the rzldoc 0.1.5 ЯBOWZR egg pusher, not the DRAGON SKULL feed).

Plan (each step needs Rizal's GO):
1. Rizal points me at the Drive file he means (or OKs uploading the signed appcast.json to a Drive folder shared "anyone with link").
2. Feed URL becomes https://drive.usercontent.google.com/download?id=<FILE_ID>&export=download&confirm=t
   (Drive file IDs change if re-uploaded → better: update the file in place so the ID stays stable).
3. Info.plist-patch.txt: change DSSelfUpdateManifestURL → rebuild + re-sign the iOS app (one-time rebuild; breaks no-rebuild rule; Face ID GO).
   There is no no-rebuild option: the old URL is pinned to the rizalward account, which no longer exists, so only a rebuild can change it.
4. appcast.template.json is unsigned; sign with RDRAGON/SIGNING-METHOD/sign.sh only after GO.
Nothing here is installed, signed or pushed. ЯBEE · ЯID-0004-ZYZ0 · 2026-10-24 03:17 MT

## 2026-10-24 12:58 MT update (Rizal GO t31u: publish feed to 4 mirrors)
Feed live (UNSIGNED, current build 1.0.4/9, no items):
1. https://raw.githubusercontent.com/RIZALEON/RZL-EGG/main/dragon-skull/ios-web/appcast.json (verified 200)
2. https://rizaleon.github.io/RZL-EGG/dragon-skull/ios-web/appcast.json (verified 200)
3. Drive acct1 file 1aZOICtP6B6LXW-bLaryINNC-nC_C6bJK (private: connector cannot set anyone-with-link)
4. Drive acct2 file 1Jurza6g3aDwsikjHnLq7XE4K6R3C4Cz2 (private, same)
5. Neo ~/ЯLAB/RFORGE/RCONTRALROOM/FEED/dragon-skull/ios-web/appcast.json
Info.plist-patch.txt now has the ordered DSSelfUpdateManifestURLs list. Not rebuilt, signed or installed. ЯBEE · ЯID-0004-ZYZ0 · 2026-10-24 12:58 MT
