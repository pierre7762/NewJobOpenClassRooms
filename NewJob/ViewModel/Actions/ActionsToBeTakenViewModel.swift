//
//  ActionsToBeTakenViewModel.swift
//  NewJob
//
//  Created by Pierre on 17/11/2022.
//

import Foundation

class ActionToBeTakenViewModel: ObservableObject {
    @Published var candidaciesToBeRelanch: [SelectedJobWithnumberOfDaysFromCandidacy] = []
    @Published var relaunchToBeRelanch: [SelectedJobWithnumberOfDaysFromCandidacy] = []
    @Published var interviewsToBeRelaunch: [SelectedJobWithnumberOfDaysFromCandidacy] = []
    
//    var pm = PersistenceManager(coreDataStack: CoreDataStack(modelName: "NewJob"))
    var pm = PersistenceManager()
    
    func getCandidacyToBeRelaunch(numberOfDayFrom: Int) {
        candidaciesToBeRelanch = []
        relaunchToBeRelanch = []
        interviewsToBeRelaunch = []
        let jobs = pm.fetchSelectedJobs()
        var jobsWithCandidacyToBeRelaunch: [SelectedJobWithnumberOfDaysFromCandidacy] = []
        var rToBeRelanch: [SelectedJobWithnumberOfDaysFromCandidacy] = []
        var iToBeRelaunch: [SelectedJobWithnumberOfDaysFromCandidacy] = []

        jobs.forEach { job in
            if job.candidacy != nil {
                guard let candidacyDate = job.candidacy?.candidacyDate else { return }
                let calendar = Calendar(identifier: .gregorian)
                let now = calendar.startOfDay(for: Date.now)

                if (job.candidacy?.relaunch?.allObjects.count)! < 1 {
                    let date = calendar.startOfDay(for: candidacyDate)
                    let components = calendar.dateComponents([.day], from: date, to: now)

                    guard let days = components.day else { return }
                    if components.day! > numberOfDayFrom {
                        let job = SelectedJobWithnumberOfDaysFromCandidacy(selectedJob: job, numberOfDaysFromCandidacy: days)
                        jobsWithCandidacyToBeRelaunch.append(job)
                    }
                } else if (job.candidacy?.relaunch?.allObjects.count)! > 0 &&  (job.candidacy?.interview?.allObjects.count)! < 1 {
                    let relaunchesResult = pm.fetchAllRelaunchesfromCandidacyId(candidacyId: (job.candidacy?.id)!, ascendingDate: false)
                    let date = calendar.startOfDay(for: (relaunchesResult[0] as AnyObject).date!)
                    let components = calendar.dateComponents([.day], from: date, to: now)

                    guard let days = components.day else { return }
                    if components.day! > numberOfDayFrom {
                        let job = SelectedJobWithnumberOfDaysFromCandidacy(selectedJob: job, numberOfDaysFromCandidacy: days)
                        rToBeRelanch.append(job)
                    }
                } else if (job.candidacy?.interview?.allObjects.count)! > 0 {
                    let interviewsResult = pm.fetchAllInterviewFromCandidacyId(candidacyId: (job.candidacy?.id)!, ascendingDate: false)
                    let date = calendar.startOfDay(for: (interviewsResult[0] as AnyObject).date!)
                    let components = calendar.dateComponents([.day], from: date, to: now)

                    guard let days = components.day else { return }
                    if components.day! > numberOfDayFrom {
                        let job = SelectedJobWithnumberOfDaysFromCandidacy(selectedJob: job, numberOfDaysFromCandidacy: days)
                        iToBeRelaunch.append(job)
                    }
                }

            }
        }
        candidaciesToBeRelanch = jobsWithCandidacyToBeRelaunch
        relaunchToBeRelanch = rToBeRelanch
        interviewsToBeRelaunch = iToBeRelaunch
    }
    

    
    
}
