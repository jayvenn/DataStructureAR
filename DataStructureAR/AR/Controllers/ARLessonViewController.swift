//
//  ARLessonViewController.swift
//  DataStructuresAR
//
//  Created by Jayvenn on 2022-06-19.
//

import UIKit
import ARKit
import SpriteKit
import SnapKit

let initialSpringVelocity: CGFloat = 1 // 1
let springWithDaming: CGFloat = 0.9 // 0.7

// MARK: ARLessonViewController
final class ARLessonViewController: DefaultARViewController {
  
  // MARK: - Properties
  private lazy var stackView = ARStackView(viewController: self)
  
  private lazy var containerBoxNode = ContainerBoxNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength, lesson: lesson)
  
  private lazy var subtitleView: SubtitleView = {
    let view = SubtitleView(lesson: lesson)
    let string = "Lesson info"
    let localizedString = NSLocalizedString(string, comment: string)
    view.accessibilityLabel = localizedString
    view.delegate = self
    return view
  }()
  
  private lazy var operationView: OperationView = {
    let view = OperationView(lesson: lesson)
    let string = "Operation info"
    let localizedString = NSLocalizedString(string, comment: string)
    view.accessibilityLabel = localizedString
    view.delegate = self
    return view
  }()
  
  private lazy var linkedListNode = LinkedListNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength, lesson: lesson)
  
  private lazy var binaryTreeNode = BinaryTreeNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength, lesson: lesson)
  
  private let lesson: Lesson
  
  private var subtitleViewTopConstraint: Constraint?
  private var subtitleViewBottomConstraint: Constraint?
  
  private var operationViewBottomConstraint: Constraint?
  
  private var subtitleViewMaximized = false
  
  private lazy var subtitleViewHeight: CGFloat = view.frame.height/3
  private lazy var subtitleViewTopOffset: CGFloat = view.frame.height - subtitleViewHeight + 120
  
  private let synthesizer = SpeechSynthesizer.shared
  private let notificationCenter = NotificationCenter.default
  
  init(lesson: Lesson) {
    self.lesson = lesson
    super.init(nibName: nil, bundle: nil)
    modalPresentationStyle = .fullScreen
    setAccessibilityLabel()
  }
  
  private func setAccessibilityLabel() {
    let string = "%@ lesson"
    let localizedString = NSLocalizedString(string, comment: string)
    let localizedStringWithFormat =  String.localizedStringWithFormat(localizedString, lesson.name.rawValue)
    accessibilityLabel = localizedStringWithFormat
  }
  
  deinit {
    print("ARLessonViewController did deinit")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Override methods
  override func finishedIntroductionAnimation() {
    super.finishedIntroductionAnimation()
    beginLesson()
  }
  
  private func speak() {
    DispatchQueue.main.async {
      guard let text = self.subtitleView.textView.accessibilityValue else { return }
      self.synthesizer.speak(text)
    }
  }
  
  // MARK: - Button methods
  @objc func orderingButtonDidTouchUpInside(_ sender: ARButton) {
    setCubeNodes()
    runOrdering()
    subtitleView.setOrdering()
    fadeOutBottomStackView {
      self.fadeInView(targetView: self.subtitleView, completion: { })
    }
  }
  
  @objc func operationButtonDidTouchUpInside(_ sender: ARButton) {
    setCubeNodes()
    operationView.setOperation()
    fadeOutBottomStackView {
      self.fadeInView(targetView: self.operationView, completion: { })
    }
    
  }
  
  @objc func bigOButtonDidTouchUpInside(_ sender: ARButton) {
    subtitleView.setBigO()
    fadeOutBottomStackView {
      self.fadeInView(targetView: self.subtitleView, completion: { })
    }
  }
  
  @objc func resetButtonDidTouchUpInside(_ sender: AlternateARButton) {
    fadeOutBottomStackView(completion: {
      DispatchQueue.main.async {
        self.resetTrackingConfiguration()
      }
    })
  }
  
  func addObservers() {
    notificationCenter.addObserver(forName: .operationButtonDidTouchUpInside, object: nil, queue: .main) { [weak self] (notification) in
      guard let self = self,
            let operation = notification.object as? Operation
      else { return }
      self.operationAnimation(operation: operation)
    }
  }
  
  func operationAnimation(operation: Operation) {
    switch operation {
    case .push, .enqueue:
      switch lesson.name {
      case .stack, .queue:
        containerBoxNode.pushCubeNode { }
      case .singlyLinkedList, .doublyLinkedList:
        break
      default:
        break
      }
    case .pop, .dequeue:
      containerBoxNode.popCubeNode {
        
      }
    case .comingSoon:
      break
    default:
      break
    }
    
  }
  
  override func configureView() {
    super.configureView()
    // TODO: Update subtitle view with accessible fonts
    switch lesson.name {
    case .stack, .queue:
      break
    default:
      stackView.operationStackView.isHidden = true
    }
  }
  
}

// MARK: ARLessonViewController - Life cycles
extension ARLessonViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    //        let button = ARButton(image: #imageLiteral(resourceName: "operation"))
    //        operationButtonDidTouchUpInside(button)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    addObservers()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    notificationCenter.removeObserver(self)
  }
}


// MARK: - Animation
extension ARLessonViewController {
  @objc func maximizeSubtitleView() {
    subtitleView.fadeInSpeakerButton()
    self.subtitleViewTopConstraint?.update(offset: 0)
    self.subtitleViewBottomConstraint?.update(offset: self.subtitleViewTopOffset)
    animateMaximizedSubtitleView()
    subtitleViewMaximized = true
  }
  
  func animateMaximizedSubtitleView() {
    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springWithDaming, initialSpringVelocity: initialSpringVelocity, options: .curveEaseOut, animations: {
      self.view.layoutIfNeeded()
    }, completion: { _ in
      self.subtitleViewBottomConstraint?.update(offset: 0)
    })
  }
  
  @objc func minimizeSubtitleView() {
    subtitleView.fadeOutSpeakerButton()
    if !subtitleViewMaximized {
      SpeechSynthesizer.shared.stopSpeaking()
      refreshSubtitleView()
      fadeOutView(targetView: self.operationView, completion: {}) //
      fadeOutView(targetView: self.subtitleView) {
        self.fadeInBottomStackView(completion: { })
      }
      return
    }
    animateMinimizeSubtitleView()
    subtitleViewMaximized = false
  }
  
  func animateMinimizeSubtitleView() {
    self.subtitleViewTopConstraint?.update(offset: self.subtitleViewTopOffset)
    self.subtitleViewBottomConstraint?.update(offset: self.subtitleViewTopOffset)
    UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springWithDaming, initialSpringVelocity: initialSpringVelocity, options: .curveEaseOut, animations: {
      self.view.layoutIfNeeded()
    }, completion: { _ in
      self.subtitleViewBottomConstraint?.update(offset: 0)
    })
  }
}

// MARK: - Set cube nodes
extension ARLessonViewController {
  func setCubeNodes() {
    switch lesson.name {
    case .stack, .queue :
      guard containerBoxNode.cubeNodes.isEmpty else { return }
      containerBoxNode.cubeNodes = cubeNodes
    case .singlyLinkedList:
      runSinglyLinkedListLesson()
    case .doublyLinkedList:
      fadeInBottomStackView { }
    case .binaryTree:
      fadeInBottomStackView { }
    }
  }
}

// MARK: - Lesson
extension ARLessonViewController {
  
  func beginLesson() {
    mainNode.addChildNode(containerBoxNode)
    switch lesson.name {
    case .stack:
      runStackLesson()
    case .queue:
      runQueueLesson()
    case .singlyLinkedList:
      runSinglyLinkedListLesson()
    case .doublyLinkedList:
      fadeInBottomStackView { }
    case .binaryTree:
      fadeInBottomStackView { }
    }
  }
  
  func setupLayout() {
    setupStackView()
    setupSubtitleView()
    setupOperationView()
  }
  
  func setupStackView() {
    view.addSubview(stackView)
    NSLayoutConstraint.activate(
      [
        
      ]
    )
    stackView.snp.makeConstraints {
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
    }
  }
  
  func setupSubtitleView() {
    view.addSubview(subtitleView)
    subtitleView.snp.makeConstraints {
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
      subtitleViewBottomConstraint = $0.bottom.equalTo(view.snp.bottom).constraint
      subtitleViewTopConstraint = $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(subtitleViewTopOffset).constraint
    }
    view.setNeedsLayout()
  }
  
  func setupOperationView() {
    view.addSubview(operationView)
    
    let height = (view.frame.height / 4).rounded()
    operationView.snp.makeConstraints {
      $0.leading.trailing.equalTo(subtitleView)
      $0.bottom.equalToSuperview()
      $0.height.equalTo(height)
    }
  }
}

// MARK: - Lesson Ordering, Operation, Big O
extension ARLessonViewController {
  // Ordering
  func runOrdering() {
    fadeInView(targetView: self.subtitleView, completion: {})
    switch lesson.name {
    case .stack, .queue:
      containerBoxNode.pushCubeNodes()
    case .singlyLinkedList:
      linkedListNode.generateSinglyLinkingNodes(basedOn: self.cubeNodes)
      //            DispatchQueue.main.async {
      //                self.linkedListNode.generateSinglyLinkingNodes(basedOn: self.cubeNodes)
      //            }
    case .doublyLinkedList:
      linkedListNode.generateSinglyLinkingNodes(basedOn: self.cubeNodes, isDoubly: true)
      //            DispatchQueue.main.async {
      //                self.linkedListNode.generateSinglyLinkingNodes(basedOn: self.cubeNodes, isDoubly: true)
      //            }
    case .binaryTree:
      DispatchQueue.main.async {
        self.binaryTreeNode.animate(with: self.cubeNodes)
      }
    }
  }
  
  // Operation
  func runStackOperation(_ operation: Operation, boxes: [SCNNode]) {
    switch operation {
    case .push:
      break
    case .pop:
      break
    case .peek:
      break
    case .isEmpty:
      break
    default:
      break
    }
  }
}

// MARK: - Stack Lesson
extension ARLessonViewController {
  func runStackLesson() {
    containerBoxNode = ContainerBoxNode(cubeLength: cubeLength, cubeSpacing: cubeSpacing, trackerNodeLength: trackerNodeLength, lesson: lesson)
    containerBoxNode.delegate = self
    containerBoxNode.position = SCNVector3(0, 0.6, 0)
    containerBoxNode.runFadeInAction(completion: {
      self.containerBoxNode.runAssembleSquareAction(completion: {
        self.fadeInBottomStackView() { }
      })
    })
    mainNode.addChildNode(containerBoxNode)
  }
}

// MARK: - Queue Lesson
extension ARLessonViewController {
  func runQueueLesson() {
    runStackLesson()
  }
}

// MARK: - Singly-Linked List Lesson
extension ARLessonViewController {
  func runSinglyLinkedListLesson() {
    fadeInBottomStackView() { }
  }
}

// MARK: ARLessonViewController - Animation
extension ARLessonViewController {
  // Bottom Stack View
  func fadeInBottomStackView(completion: @escaping () -> ()) {
    DispatchQueue.main.async {
      UIView.animate(withDuration: fadeInAnimationDuration, delay: 0, options: [.curveEaseIn], animations: {
        self.stackView.alpha = 1
      }, completion: { _ in completion() })
    }
  }
  
  func fadeOutBottomStackView(completion: @escaping () -> ()) {
    DispatchQueue.main.async {
      UIView.animate(withDuration: fadeInAnimationDuration, delay: 0, options: [.curveEaseOut], animations: {
        self.stackView.alpha = 0
      }, completion: { _ in completion() })
    }
  }
  
  // Subtitle Stack View
  func fadeInView(targetView: BaseARView, completion: @escaping () -> ()) {
    DispatchQueue.main.async {
      UIView.animate(withDuration: fadeInAnimationDuration, delay: 0, options: [.curveEaseIn], animations: {
        targetView.alpha = 1
      }, completion: { _ in completion() })
    }
  }
  
  func fadeOutView(targetView: BaseARView, completion: @escaping () -> ()) {
    DispatchQueue.main.async {
      UIView.animate(withDuration: fadeInAnimationDuration, delay: 0, options: [.curveEaseOut], animations: {
        targetView.alpha = 0
      }, completion: { _ in completion() })
    }
  }
}

// MARK: ARLessonViewController - ContainerBoxNodeDelegate
extension ARLessonViewController: ContainerBoxNodeDelegate {
  func didFinishOrdering() {
    
  }
}

// MARK: ARLessonViewController - Subtitle
extension ARLessonViewController: SubtitleViewDelegate {
  func speakerButtonDidTouchUpInside() {
    speak()
  }
  
  func subtitleDidTranslate(y: CGFloat) {
    self.subtitleViewBottomConstraint?.update(offset: -y)
    UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [], animations: {
      self.view.layoutIfNeeded()
    }, completion: { _ in
      
    })
  }
  
  func refreshSubtitleView() {
    if subtitleViewMaximized {
      animateMaximizedSubtitleView()
    } else {
      animateMinimizeSubtitleView()
    }
  }
  
  func closeButtonDidTouchUpInside() {
    DispatchQueue.main.async {
      SpeechSynthesizer.shared.stopSpeaking()
      self.minimizeSubtitleView()
      self.fadeOutView(targetView: self.operationView, completion: {})
      self.fadeOutView(targetView: self.subtitleView, completion: {
        self.fadeInBottomStackView(completion: {})
      })
    }
  }
  
  func sliderButtonDidTouchUpInside() {
    DispatchQueue.main.async {
      if !self.subtitleViewMaximized {
        self.maximizeSubtitleView()
      } else {
        self.minimizeSubtitleView()
      }
    }
    
  }
}
