//
//  ContentView.swift
//  PomodorosToDo
//
//  Created by Tyler Morris on 11/29/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pomodoroApp = TaskViewModel()
    
    var body: some View {
        if (pomodoroApp.activePomodoro) {
            Text("Focus Time")
        } else {
            Text("Break Time")
        }
        Text(
            String(format: "%02d", pomodoroApp.timeRemaining / 60)
            + ":"
            + String(format: "%02d", pomodoroApp.timeRemaining % 60)
        )
        
        VStack {
            ForEach($pomodoroApp.tasks) {$task in
                HStack {
                    TextField(task.name, text: $task.name)
                    Button("+") {
                        task.remaining += 1
                    }
                    Text(String(task.remaining) + "🕔")
                    Text(String(task.completed) + "✅")
                    if (task.remaining > 0) {
                        Button("Start") {
                            pomodoroApp.startPomodoro(id: task.id)
                        }
                    }
                }
            }
        }
        .padding()
        
        Button("Add Task") {pomodoroApp.addTask()}
    }
}

#Preview {
    ContentView()
}
