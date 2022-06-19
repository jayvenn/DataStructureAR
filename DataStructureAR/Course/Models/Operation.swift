//
//  Operation.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import Foundation

enum Operation: String {
  case push =  "push(cube)"
  case pop = "pop()"
  case peek = "peek()"
  case isEmpty = "isEmpty()"
  
  case enqueue = "enqueue(cube)"
  case dequeue = "dequeue()"
  
  case append = "append(cube)"
  case remove = "remove(cube)"
  case nodeAtIndex = "elementAt(index: Int)"
  case removeAll = "removeAll()"
  
  case insertAfter = "insert(after: cube)"
  case removeLast = "removeLast()"
  case removeAfter = "remove(after: cube)"
  
  case find = "find(cube)"
  case addChild = "add(child: cube)"
  case removeChild = "remove(child: cube)"
  
  case comingSoon = "Coming Soon\nTap to Contribute"
}
