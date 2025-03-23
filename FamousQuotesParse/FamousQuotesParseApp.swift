//
//  FamousQuotesParseApp.swift
//  FamousQuotesParse
//
//  Created by Cormell, David - DPC on 18/03/2025.
//

import SwiftUI
import ParseSwift

@main
struct FamousQuotesParseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: FamousQuotesViewModel())
        }
    }
    
    init() {
        // Replace placeholders with your Back4App credentials
        ParseSwift.initialize(
            applicationId: "gqerelQ5Y52jxwzCaHBmLQiGa2HAUkq4H4BkVuVR",
            clientKey: "s2Fs8DkAW7IE5AcJMD0zPMzr2ziUArrvMGg9SqCS",
            serverURL: URL(filePath: "https://parseapi.back4app.com/")!
        )
    }
}
