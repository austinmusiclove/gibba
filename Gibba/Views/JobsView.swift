//
//  JobsView.swift
//  Gibba
//
//  Created by John Filippone on 10/8/24.
//

import SwiftUI

struct JobsView: View {
    @State private var jobs: [Job] = []

    var body: some View {
        List(jobs) { job in
            NavigationLink(destination: JobDetailView(job: job)) {
                Text("Job \(job.job_number): \(job.job_title)")
            }
        }
        .navigationTitle("Jobs")
        .onAppear {
            loadJobs()
        }
    }

    func loadJobs() {
        if let savedJobs = UserDefaults.standard.array(forKey: "savedJobs") as? [[String: String]] {
            jobs = savedJobs.compactMap { dict in
                guard let jobNumber = dict["job_number"], let jobTitle = dict["job_title"] else { return nil }
                return Job(job_number: jobNumber, job_title: jobTitle)
            }
        }
    }
}

// Preview
struct JobsView_Previews: PreviewProvider {
    static var previews: some View {
        JobsView()
    }
}
