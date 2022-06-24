//
//  HomeViewModel.swift
//  NewJob
//
//  Created by Pierre on 23/06/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    var memoryManager = PersistenceManager()
    @Published var jobs: [SelectedJob] = []
    @Published var jobsWithCandidacyMake: [SelectedJob] = []
    @Published var jobsWithCandidacyMakeCount = 0
    @Published var jobsCount = 0
    
    func updateData() {
        getJobs()
        getJobsCount()
    }
    
    private func getJobs() {
        jobs = memoryManager.fetchSelectedJobs()
        jobsWithCandidacyMake = memoryManager.fetchSelectedJobWhoHaveCandidacyMake(jobs: jobs)
        jobsWithCandidacyMakeCount = jobsWithCandidacyMake.count
    }
    
    private func getJobsCount() {
        jobsCount = jobs.count
    }
}
