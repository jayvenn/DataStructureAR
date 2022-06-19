//
//  SpeechSynthesizer.swift
//  DataStructureAR
//
//  Created by Jayvenn on 2022-06-19.
//

import AVFoundation

final class SpeechSynthesizer {
  static let shared = SpeechSynthesizer()
  private let synthesizer = AVSpeechSynthesizer()
  func speak(_ text: String) {
    guard !synthesizer.isSpeaking else { return stopSpeaking() }
    let utterance = AVSpeechUtterance(string: text)
    if isEnglish() {
      utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
    }
    utterance.rate = 0.56 // 0.54
    synthesizer.speak(utterance)
  }
  private func isEnglish() -> Bool {
    return NSLocale.preferredLanguages[0].range(of:"en") != nil
  }
  func stopSpeaking() {
    synthesizer.stopSpeaking(at: .word)
  }
}
