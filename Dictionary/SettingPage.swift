//
//  SettingPage.swift
//  Dictionary
//
//  Created by Oliver on 2023-05-23.
//

import SwiftUI

struct SettingPage: View {
    @AppStorage("apiKey") private var apiKey = ""
    
    var body: some View {
        Form {
            Section(header: Text("API Key")) {
                TextField("API Key", text: $apiKey)
            }
//            Section(header: Text("Notifications")) {
//                Picker("Notify Me About", selection: $notifyMeAbout) {
//                    Text("Direct Messages").tag(NotifyMeAboutType.directMessages)
//                    Text("Mentions").tag(NotifyMeAboutType.mentions)
//                    Text("Anything").tag(NotifyMeAboutType.anything)
//                }
//                Toggle("Play notification sounds", isOn: $playNotificationSounds)
//                Toggle("Send read receipts", isOn: $sendReadReceipts)
//            }
//            Section(header: Text("User Profiles")) {
//                Picker("Profile Image Size", selection: $profileImageSize) {
//                    Text("Large").tag(ProfileImageSize.large)
//                    Text("Medium").tag(ProfileImageSize.medium)
//                    Text("Small").tag(ProfileImageSize.small)
//                }
//                Button("Clear Image Cache") {}
//            }
        }.navigationBarTitle("Settings")
    }
}

struct SettingPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingPage()
        }
    }
}
