//
//  Lesson.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import Foundation

struct Lesson {
  let name: LessonName
  lazy var operations: [Operation] = {
    var operations = [Operation]()
    switch name {
    case .stack:
      operations = [.push, .pop]
    case .queue:
      operations = [.enqueue, .dequeue]
    case .singlyLinkedList, .doublyLinkedList:
      operations = [.comingSoon, .comingSoon]
    case .binaryTree:
      operations = [.comingSoon, .comingSoon]
    }
    return operations
  }()
  init(lessonName: LessonName) {
    self.name = lessonName
  }
}
