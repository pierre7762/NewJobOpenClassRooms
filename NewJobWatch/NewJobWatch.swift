//
//  NewJobWatch.swift
//  NewJobWatch
//
//  Created by Pierre on 02/02/2023.
//

import AppIntents

struct NewJobWatch: AppIntent {
    static var title: LocalizedStringResource = "NewJobWatch"
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
