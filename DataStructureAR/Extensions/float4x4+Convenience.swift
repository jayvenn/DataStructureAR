//
//  float4x4+Convenience.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import Foundation

extension float4x4 {
  var translation: float3 {
    let translation = self.columns.3
    return float3(translation.x, translation.y, translation.z)
  }
}
