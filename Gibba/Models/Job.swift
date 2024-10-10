//
//  Job.swift
//  Gibba
//
//  Created by John Filippone on 10/9/24.
//

import Foundation

struct Job: Identifiable, Codable {
    let id = UUID()
    let job_number: String
    let job_title: String
    
    enum CodingKeys: String, CodingKey {
        case job_number
        case job_title
    }
}
