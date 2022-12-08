//
//  RelaunchDetailsViewModel.swift
//  NewJob
//
//  Created by Pierre on 04/11/2022.
//

import Foundation

class RelaunchDetailsViewModel: ObservableObject {
    @Published var relaunch: Relaunch?
    var pm: PersistenceManager!
    
    func converteDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func removeRelaunch(relaunchID: UUID, pmDirect: PersistenceManager) {
        pmDirect.removeRelaunch(relaunchId: relaunchID)
    }

}
