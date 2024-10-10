//
//  JobDetailView.swift
//  Gibba
//
//  Created by John Filippone on 10/8/24.
//

import SwiftUI

struct JobDetailView: View {
    var job: Job

    var body: some View {
        VStack {
            Text("Job Title: \(job.job_title)")
                .font(.title)
            Text("Job Number: \(job.job_number)")
                .font(.subheadline)
        }
        .navigationTitle("Job Details")
        .padding()
    }
}

// Preview
struct JobDetailView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailView(job: Job(job_number: "12345", job_title: "Sample Job"))
    }
}
