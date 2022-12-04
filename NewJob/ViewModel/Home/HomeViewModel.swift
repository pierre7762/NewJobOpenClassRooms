//
//  HomeViewModel.swift
//  NewJob
//
//  Created by Pierre on 23/06/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
//    var pm = PersistenceManager(coreDataStack: CoreDataStack(modelName: "NewJob"))
    var pm = PersistenceManager()
    @Published var jobs: [SelectedJob] = []
    @Published var jobsWithCandidacyMake: [SelectedJob] = []
    @Published var jobsWithCandidacyMakeCount = 0
    @Published var jobsCount = 0
    
    @Published var contacts: [Contact] = []
    @Published var contactsCount = 0
    
    func updateData() {
        getJobs()
        getJobsCount()
        getContacts()
    }
    
    func getJobs() {
        jobs = pm.fetchSelectedJobs()
        jobsWithCandidacyMake = pm.fetchSelectedJobWhoHaveCandidacyMake(jobs: jobs)
        jobsWithCandidacyMakeCount = jobsWithCandidacyMake.count
    }
    
    func getJobsCount() {
        jobsCount = jobs.count
    }
    
    func getContacts() {
        contacts = pm.fetchContact()
        contactsCount = contacts.count
        jobsCount = contacts.count
    }
}
