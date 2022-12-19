//
//  InterviewDeatilsViewModel.swift
//  NewJob
//
//  Created by Pierre on 09/12/2022.
//

import Foundation

class InterviewDetailsViewModel: ObservableObject {
    @Published var interview: Interview?
    var pm: PersistenceManager!
    
    func loadInterviewDetails(interviewId: UUID) {
        let interviewUpdated = pm.fetchInterviewWithId(interviewId: interviewId)
        interview = interviewUpdated
    }
    
    func converteDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
