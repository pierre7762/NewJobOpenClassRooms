//
//  ActionsToBeTakenOnFavoriteJobViewModel.swift
//  NewJob
//
//  Created by Pierre on 25/04/2022.
//

import Foundation

class ActionsToBeTakenOnFavoriteJobViewModel: ObservableObject {    
    @Published var favoriteJob: SelectedJob?
    @Published var dataReady: Bool = false
    @Published var createCandidacyToggle = false
    @Published var createDateCandidacy: Date = Date()
    @Published var createDateInterview: Date = Date()
    @Published var means: String = "Non précisé"
    @Published var comment: String = ""
    @Published var interviewComment = ""
    @Published var showingDestinataireSheet = false
    @Published var showingDeleteSheet = false
    @Published var showingRelaunchSheet = false
    @Published var showingInterviewSheet = false
    @Published var contactName = ""
    @Published var contactCompagny = ""
    @Published var contactMail = ""
    @Published var contactPhoneNumber = ""
    @Published var contactFunctionInCompany = ""
    @Published var contactArray: [Contact] = []
    @Published var relaunchesArray: [Relaunch] = []
    @Published var interviewArray: [Interview] = []
    @Published var favoriteJobIsInit = false
    @Published var textCandidacyState: String = "En cours"
    
    var pm: PersistenceManager!
    
    func initFavoriteJob(jobId: String) {
        guard let job = try? pm.getSelectedJobWithId(id: jobId) else { return }
        favoriteJob = job
        guard let candidacy = job.candidacy else {
            createCandidacyToggle = false
            return
        }
        createDateCandidacy = candidacy.candidacyDate!
        means = candidacy.candidacyMeans!
        comment = candidacy.comment!
        textCandidacyState = candidacy.state!
        favoriteJobIsInit = true
        createCandidacyToggle = true
    }
    
    func toDoAction(isCreated: Bool) {
        guard let job = favoriteJob else { return }
        switch isCreated {
        case true:
            if(favoriteJob?.candidacy == nil) {
                pm.createCandidacy(candidacyMeans: means, candidacyDate: createDateCandidacy, comment: comment, favoriteJobId: job.id!)
            }
            favoriteJobIsInit = true
            
        case false:
            pm.removeCandidacy(favoriteJobId: job.id!)
        }
        let jobUpdated = try? pm.getSelectedJobWithId(id: (favoriteJob?.id)!)
        favoriteJob = jobUpdated
    }
    
    func updateCandidacy() {
        if favoriteJobIsInit {
            guard let id = favoriteJob?.id else { return }
            let amendedApplication = checkIfCandidacyFormIsDifferentOfFavoriteJobCandidacy()
            if amendedApplication {
                pm.updateSelectedJobCandidacy(
                    jobId: id,
                    candidacyDate: createDateCandidacy,
                    candidacyMeans: means,
                    comment: comment,
                    state: textCandidacyState
                )
                
                favoriteJob = try? pm.getSelectedJobWithId(id: id)
            }
        }
    }
    
    func checkIfCandidacyFormIsDifferentOfFavoriteJobCandidacy() -> Bool {
        guard let candidacy = favoriteJob?.candidacy else { return true}
        
        if candidacy.candidacyDate != createDateCandidacy {
            return true
        }
        if candidacy.candidacyMeans != means {
            return true
        }
        if candidacy.comment != comment {
            return true
        }
        if candidacy.state != textCandidacyState {
            return true
        }
        
        return false
    }
    
    func candidacyIsCreated(){
        if favoriteJob!.candidacy != nil {
            createCandidacyToggle = true
        } else {
            createCandidacyToggle = false
        }
    }
    
    func fetchSelectedJob() {
        favoriteJob = try? pm.getSelectedJobWithId(id: (favoriteJob?.id)!)
    }
    
    func fetchRelaunches() {
        if ((favoriteJob?.candidacy) != nil) {
            relaunchesArray = pm.fetchAllRelaunchesfromCandidacyId(candidacyId: (favoriteJob?.candidacy?.id)!, ascendingDate: false)
        }
    }
    
    func converteDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func removeInterview(interviewId: UUID) {
        pm.removeInterview(interviewId: interviewId)
        interviewArray = pm.fetchAllInterviewFromCandidacyId(candidacyId: (favoriteJob?.candidacy?.id)!, ascendingDate: true)
    }
    
    func removeSelectedJob(jobId: String){
        pm.removeSelectedJob(selectedJobId: jobId)
    }
}

enum TypeOfView{
    case candidacy
    case interview
}
