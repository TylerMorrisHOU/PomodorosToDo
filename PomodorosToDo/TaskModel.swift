//
//  TaskModel.swift
//  PomodorosToDo
//
//  Created by Tyler Morris on 11/30/24.
//

import Foundation

struct TaskModel : Codable, Identifiable {
    var id : UUID
    var name : String
    var remaining : Int
    var completed : Int = 0
}
