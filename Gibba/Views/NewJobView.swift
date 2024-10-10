//
//  NewJobView.swift
//  Gibba
//
//  Created by John Filippone on 10/8/24.
//

import SwiftUI

struct NewJobView: View {
    @EnvironmentObject var userSettings: UserSettings
    @State private var jobNumber: String = ""
    @State private var job: Job?
    @State private var errorMessage: String?
    @State private var successMessage: String?

    var body: some View {
        Form {
            TextField("Job Number", text: $jobNumber)
                .keyboardType(.numberPad)
            
            Button("Submit") {
                submitJob()
            }
            
            if let job = job {
                Text("Job Title: \(job.job_title)")
                Text("Job Number: \(job.job_number)")
                
                VStack(alignment: .leading) {
                    Text("Name")
                    TextField("Your Name", text: $userSettings.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                Button("Accept Job") {
                    acceptJob()
                }
                Button("Decline Job") {
                    declineJob()
                }
            }

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            if let successMessage = successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
            }
        }
        .navigationTitle("New Job")
    }

    func submitJob() {
        guard !jobNumber.isEmpty else {
            errorMessage = "Please enter a job number."
            return
        }

        let urlString = "https://gibba.com/wp-json/v1/jobs?job_number=\(jobNumber)"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received."
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                if let job = try? decoder.decode(Job.self, from: data) {
                    DispatchQueue.main.async {
                        self.job = job
                        self.errorMessage = nil
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Job not found. Please enter a valid job number."
                        self.job = nil
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Error decoding data: \(error.localizedDescription)"
                }
            }
        }

        task.resume()
    }

    func acceptJob() {
        guard !userSettings.name.isEmpty else {
            return
        }

        if let job = job {
            // Save job details locally
            var savedJobs = UserDefaults.standard.array(forKey: "savedJobs") as? [[String: String]] ?? []
            savedJobs.append(["job_number": job.job_number, "job_title": job.job_title])
            UserDefaults.standard.set(savedJobs, forKey: "savedJobs")
            successMessage = "Job accepted successfully!"
            resetState()
        }
    }

    func declineJob() {
        resetState()
    }
    
    private func resetState() {
        job = nil
        jobNumber = ""
        successMessage = nil
        errorMessage = nil
    }
}

// Preview
struct NewJobView_Previews: PreviewProvider {
    static var previews: some View {
        NewJobView()
            .environmentObject(UserSettings())
    }
}
