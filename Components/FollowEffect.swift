//
//  FollowEffect.swift
//  
//
//  Created by Kai Quan Tay on 17/4/23.
//

import SwiftUI

struct FollowEffect: GeometryEffect {
    var pct: CGFloat = 0
    let path: Path

    var animatableData: CGFloat {
        get { return pct }
        set { pct = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        let pt1 = percentPoint(pct)
        let pt2 = percentPoint(pct - 0.01)

        let angle = calculateDirection(pt1, pt2)
        let transform = CGAffineTransform(translationX: pt1.x, y: pt1.y).rotated(by: angle)

        return ProjectionTransform(transform)
    }

    /// The point of a Path
    func percentPoint(_ percent: CGFloat) -> CGPoint {
        // handle limits, ensure percent is within 0 and 1, wrap otherwise
        let pct = (percent > 1) ? 0 : (percent < 0 ? 1 : percent)

        // get a small component of the path. Its small enough that its practically a point.
        let diff: CGFloat = 0.001               // the size of the comparison
        let comp: CGFloat = 1 - diff            // the comparison point
        let f = pct > comp ? comp : pct         // the lowerbound
        let t = pct > comp ? 1 : pct + diff     // the upperbound
        let tp = path.trimmedPath(from: f, to: t)

        // use the centre of the component
        return CGPoint(x: tp.boundingRect.midX, y: tp.boundingRect.midY)
    }

    /// Uses trig to figure out the angle between two points
    func calculateDirection(_ pt1: CGPoint,_ pt2: CGPoint) -> CGFloat {
        let a = pt2.x - pt1.x
        let b = pt2.y - pt1.y

        let angle = a < 0 ? atan(Double(b / a)) : atan(Double(b / a)) - Double.pi

        return CGFloat(angle)
    }
}
