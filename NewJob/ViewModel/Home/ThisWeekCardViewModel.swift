//
//  ThisWeekCardViewModel.swift
//  NewJob
//
//  Created by Pierre on 24/11/2022.
//

import Foundation

class ThisWeekCardViewModel: ObservableObject {
    @Published var allCandidacyCount: Int = 0
    @Published var allInterviewsCount: Int = 0
    @Published var candidaciesToBeRelanchThisWeekCount: Int = 0
    @Published var relaunchToBeRelanchThisWeekCount: Int = 0
    @Published var interviewsToBeRelaunchThisWeekCount: Int = 0
//    var pm = PersistenceManager(coreDataStack: CoreDataStack(modelName: "NewJob"))
//    var pm = PersistenceManager()
    var pm: PersistenceManager!
    
    func updateData() {
        fetchAllCandidacyCount()
        fetchAllInterviewsCount()
        getCandidacyToBeRelaunch()
    }
    
    private func fetchAllCandidacyCount() {
        let candidacies = pm.fetchAllCandidacies()
        allCandidacyCount = candidacies.count
    }
    
    private func fetchAllInterviewsCount() {
        let interviews = pm.fetchAllInterviews()
        allInterviewsCount = interviews.count
    }
    
    func getCandidacyToBeRelaunch() {
//        var candidaciesToBeRelanch: [SelectedJobWithnumberOfDaysFromCandidacy] = []
//        var relaunchToBeRelanch: [SelectedJobWithnumberOfDaysFromCandidacy] = []
        let jobs = pm.fetchSelectedJobs()
        var jobsWithCandidacyToBeRelaunch: [SelectedJobWithnumberOfDaysFromCandidacy] = []
        var rToBeRelanch: [SelectedJobWithnumberOfDaysFromCandidacy] = []
        var iToBeRelaunch: [SelectedJobWithnumberOfDaysFromCandidacy] = []
        
        
        let numberOfDayFrom = 7
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        let currentWeekDay = calendar.component(.weekday, from: Date.now)
        let numberOfDatesAdded = howMAnyDaysToHaveFridayInThisWeek(currentWeekDay: currentWeekDay)
        var dateComponent = DateComponents()
        dateComponent.day = numberOfDatesAdded
        let fridayDateInThisWeek = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        jobs.forEach { job in
            if job.candidacy != nil {
                guard let candidacyDate = job.candidacy?.candidacyDate else { return }
                let calendar = Calendar(identifier: .gregorian)
                let now = calendar.startOfDay(for: Date.now)
                
                if (job.candidacy?.relaunch?.allObjects.count)! < 1 {
                    let date = calendar.startOfDay(for: candidacyDate)
                    let components = calendar.dateComponents([.day], from: date, to: fridayDateInThisWeek!)
                    
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
        candidaciesToBeRelanchThisWeekCount = jobsWithCandidacyToBeRelaunch.count
        relaunchToBeRelanchThisWeekCount = rToBeRelanch.count
        interviewsToBeRelaunchThisWeekCount = iToBeRelaunch.count
    }
    
    private func howMAnyDaysToHaveFridayInThisWeek(currentWeekDay: Int) -> Int {
        switch currentWeekDay {
        case 1:
            return +5
        case 2:
            return +4
        case 3:
            return +3
        case 4:
            return +2
        case 5:
            return +1
        case 6:
            return 0
        case 7:
            return -1
        default:
            return 0
        }
    }
}
