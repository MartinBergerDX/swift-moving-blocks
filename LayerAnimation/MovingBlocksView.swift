//
//  MovingBlocksView.swift
//  LayerAnimation
//
//  Created by Martin Berger on 10/12/16.
//  Copyright © 2016 heavy-debugging.inc. All rights reserved.
//

import UIKit

class MovingBlocksView: UIView, DisplayLinkerDelegate {
    var speed: Double = 0.0
    var rows: Int = 0
    var blockWidth: Float = 0
    
    var blockHeight: Float {
        get {
            let viewHeight = self.frame.height
            let rows = self.rows
            let height = Float(viewHeight) / Float(rows)
            return height
        }
    }
    
    private var linker: DisplayLinker? = nil
    private var layers: [[CALayer]]? = nil
    
    private let indianRed   = UIColor.init(red: 205 / 255, green: 92  / 255, blue: 92  / 255, alpha: 1.0)
    private let lightCoral  = UIColor.init(red: 240 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1.0)
    private let salmon      = UIColor.init(red: 250 / 255, green: 128 / 255, blue: 114 / 255, alpha: 1.0)
    private let darkSalmon  = UIColor.init(red: 233 / 255, green: 150 / 255, blue: 122 / 255, alpha: 1.0)
    private lazy var colors: [UIColor] = [indianRed, lightCoral, salmon, darkSalmon]
    private var colorIndex  = 0
    
    init(frame: CGRect, speed: Double, blockWidth: Int, rows: Int) {
        super.init(frame: frame)
        setup(speed: speed, blockWidth: blockWidth, rows: rows)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup(speed: Double, blockWidth: Int, rows: Int) {
        self.speed = speed
        self.blockWidth = Float(blockWidth)
        self.rows = rows
        
        self.linker = DisplayLinker.init(withDelegate: self)
    }
    
    private func setup(blocks rows: Int) {
        guard self.layers != nil else {
            return
        }
        
        var layers = [[CALayer]]()
        var width = self.blockWidth
        var height = self.blockHeight
        var x: Float = 0.0
        var y: Float = 0.0
        var viewWidth = Float(self.frame.width)
        var groupWidth = Float(0.0)
        
        for n: Int in 0...rows {
            var layerRow = [CALayer]()
            while groupWidth < viewWidth {
                var layer = CALayer.init()
                layerRow.append(layer)
                layer.frame = CGRect.init(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
                x += width
                groupWidth += width
            }
            x = 0.0
            y = height * Float(n)
            layers.append(layerRow)
        }
        
        self.layers = layers
    }
    
    func displayLinkUpdate(delta: TimeInterval) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup(blocks: self.rows)
    }
    
    private func addLayers() {
        guard self.layers != nil else {
            return
        }
        for layerRow: [CALayer] in self.layers! {
            for layer: CALayer in layerRow {
                self.layer.addSublayer(layer)
            }
        }
    }
    
    private func removeLayers() {
        guard self.layers != nil else {
            return
        }
        self.layer.sublayers?.removeAll()
    }
}
