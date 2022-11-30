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
    
    var pm = PersistenceManager(coreDataStack: CoreDataStack(modelName: "NewJob"))
    
    func initFavoriteJob(jobId: String) {
        guard let job = try? pm.getSelectedJobWithId(id: jobId) else { return }
        favoriteJob = job
        guard let candidacy = job.candidacy else {
            createDateCandidacy = job.candidacy?.candidacyDate ?? Date()
            means = job.candidacy?.candidacyMeans ?? ""
            createCandidacyToggle = false
            return
        }
        createCandidacyToggle = true

        means = candidacy.candidacyMeans!
        comment = candidacy.comment!
        createDateCandidacy = job.candidacy!.candidacyDate!
        textCandidacyState = (job.candidacy?.result)!
        favoriteJobIsInit = true
        fetchRelaunches()
    }
    
    func createRemoveCandidady(isCreated: Bool) {
        guard let job = favoriteJob else { return }
        switch isCreated {
        case true:
            if(favoriteJob?.candidacy == nil) {
                pm.createCandidacy(candidacyMeans: means, candidacyDate: createDateCandidacy, comment: "test", favoriteJobId: job.id!)
            }
            
        case false:
            pm.removeCandidacy(favoriteJobId: job.id!)
        }
        let jobUpdated = try? pm.getSelectedJobWithId(id: (favoriteJob?.id)!)
        favoriteJob = jobUpdated
    }
        
    func updateCandidacy() {
        if favoriteJobIsInit {
            guard let id = favoriteJob?.id else { return }
            guard let candidacy = favoriteJob?.candidacy else { return }
            
            let amendedApplication = checkIfCandidacyFormIsDifferentOfFavoriteJobCandidacy()

            if amendedApplication {
                candidacy.candidacyDate = createDateCandidacy
                candidacy.candidacyMeans = means
                candidacy.comment = comment
                candidacy.result = textCandidacyState
                
                pm.updateSelectedJobCandidacy(
                    jobId: id,
                    candidacyDate: createDateCandidacy,
                    candidacyMeans: means,
                    comment: comment,
                    result: textCandidacyState
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
        if candidacy.result != textCandidacyState {
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
    
    func createInterview() {
        pm.createInterview(candidacyID: (favoriteJob?.candidacy?.id)!, date: createDateInterview, comment: interviewComment)
        interviewArray = pm.fetchAllInterviewFromCandidacyId(candidacyId: (favoriteJob?.candidacy?.id)!, ascendingDate: true)
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
