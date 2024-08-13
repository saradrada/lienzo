//
//  ARViewController.swift
//  SpeakArt
//
//  Created by Sara Ortiz Drada on 12.08.24.
//

import SwiftUI
import UIKit
import ARKit

struct ARViewContainer: UIViewControllerRepresentable {
    let design: Design

    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController(
            imageURL: URL(string: design.thumbnail.url)!,
            designWidth: CGFloat(design.thumbnail.width),
            designHeight: CGFloat(design.thumbnail.height)
        )
    }

    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        // No updates required at this time
    }
}

class ARViewController: UIViewController, ARSCNViewDelegate {
    var arView: ARSCNView!
    let imageURL: URL
    let designWidth: CGFloat
    let designHeight: CGFloat
    var nodeWeCanChange: SCNNode?

    init(imageURL: URL, designWidth: CGFloat, designHeight: CGFloat) {
        self.imageURL = imageURL
        self.designWidth = designWidth
        self.designHeight = designHeight
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize ARSCNView and set up the AR session
        arView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(arView)

        arView.session = ARSession()
        arView.delegate = self

        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .vertical
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Check if the anchor is a vertical plane
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else { return }

        if nodeWeCanChange == nil {
            // Use the design's width and height to create the SCNPlane
            let plane = SCNPlane(width: designWidth / 1000, height: designHeight / 1000)
            plane.firstMaterial?.isDoubleSided = true  // Ensure the image can be seen from both sides

            nodeWeCanChange = SCNNode(geometry: plane)

            // Correctly rotate the plane to face the user
            nodeWeCanChange?.eulerAngles.x = -.pi / 2  // Rotate 90 degrees along the x-axis

            // Adjust the position slightly away from the wall to avoid clipping issues
            nodeWeCanChange?.position = SCNVector3(x: planeAnchor.center.x, y: planeAnchor.center.y, z: planeAnchor.center.z + 0.01)

            // Load and apply the image
            loadImageAndApply()

            node.addChildNode(nodeWeCanChange!)
        }
    }

    func loadImageAndApply() {
        // Load the image from the URL asynchronously
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, let uiImage = UIImage(data: data) else {
                print("Failed to load image")
                return
            }

            DispatchQueue.main.async {
                // Apply the image to the plane
                self.nodeWeCanChange?.geometry?.firstMaterial?.diffuse.contents = uiImage
            }
        }
        task.resume()
    }
}

