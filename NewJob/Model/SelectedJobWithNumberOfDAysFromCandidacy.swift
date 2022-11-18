//
//  SelectedJobWithIndex.swift
//  NewJob
//
//  Created by Pierre on 18/11/2022.
//

import Foundation

struct SelectedJobWithnumberOfDaysFromCandidacy: Identifiable {
    var id = UUID()
    var selectedJob: SelectedJob
    var numberOfDaysFromCandidacy: Int
}
