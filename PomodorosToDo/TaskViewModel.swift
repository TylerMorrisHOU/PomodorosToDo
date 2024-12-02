//
//  TaskViewModel.swift
//  PomodorosToDo
//
//  Created by Tyler Morris on 11/30/24.
//

import Foundation

class TaskViewModel : ObservableObject {
    let POMODORO_LENGTH : Int = 25 * 1
    let SHORT_BREAK : Int = 5 * 1
    let LONG_BREAK : Int = 20 * 1
    
    @Published var tasks = [TaskModel]()
    @Published var timeRemaining : Int = 0
    var pomodorosCompleted : Int = 0
    var activePomodoro : Bool = false
    
    func startPomodoro(id : UUID) {
        if (!activePomodoro) {
            activePomodoro = true
            self.timeRemaining = POMODORO_LENGTH
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {timer in
                if (self.timeRemaining > 0) {
                    self.timeRemaining -= 1
                } else {
                    timer.invalidate()
                    self.activePomodoro = false
                    self.pomodorosCompleted += 1
                    for i in self.tasks.indices {
                        if (self.tasks[i].id == id) {
                            self.tasks[i].completed += 1
                            self.tasks[i].remaining -= 1
                        }
                    }
                    self.startBreak()
                }
            }
        }
    }
    
    func startBreak() {
        if (pomodorosCompleted % 4 == 0) {
            self.timeRemaining = LONG_BREAK
        } else {
            self.timeRemaining = SHORT_BREAK
        }
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {timer in
            if (self.timeRemaining > 0) {
                self.timeRemaining -= 1
            } else {
                timer.invalidate()
            }
        }
    }
    
    func addTask() {
        let newTask = TaskModel(id: UUID(), name: "New Task", remaining: 0)
        self.tasks.append(newTask)
    }
}
