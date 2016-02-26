//
//  GameScene.swift
//  FlappyBird
//
//  Created by Nate Murray on 6/2/14.
//  Copyright (c) 2014 Fullstack.io. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    let verticalPipeGap = 150.0
    
    var bird:SKSpriteNode!
    var skyColor:SKColor!
    var pipeTextureUp:SKTexture!
    var pipeTextureDown:SKTexture!
    var movePipesAndRemove:SKAction!
    var moving:SKNode!
    var pipes:SKNode!
    var canRestart = Bool()
    var scoreLabelNode:SKLabelNode!
    var score = NSInteger()
    
    let birdCategory: UInt32 = 1 << 0
    let worldCategory: UInt32 = 1 << 1
    let pipeCategory: UInt32 = 1 << 2
    let scoreCategory: UInt32 = 1 << 3
    
    let groundTexture = SKTexture(imageNamed: "land")
    
    override func didMoveToView(view: SKView) {
        
        canRestart = false
        
        //1
        setupBird()
        
        //2
        /*These two functions go together*/
        setupPhysics()
        
        setupBirdPhysics()
        
        //4
        setupTaps()
        
        //5
        createGround()
        
        //6
        createGroundInteraction(groundTexture)

        //7
        createSkyline(groundTexture)
        
        //8
        createPipes()

        //9
        setupBackgroundColor()
        
        //11
        setUpScore()
    }
    
    //Additional functions
    //1
    func setupBird() {

    }
    
    //2
    func setupPhysics() {

    }
    
    func setupBirdPhysics() {

    }
    
    //3
    // TODO: Move to utilities somewhere. There's no reason this should be a member function
    func clamp(min: CGFloat, max: CGFloat, value: CGFloat) -> CGFloat {
        if( value > max ) {
            return max
        } else if( value < min ) {
            return min
        } else {
            return value
        }
    }
    
    override func update(currentTime: CFTimeInterval) {

    }
    
    //4
    func setupTaps() {

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
    
    //5
    func createGround() {

    }
    
    //6
    func createGroundInteraction(groundTexture: SKTexture) {
        var ground = SKNode()
        ground.position = CGPoint(x: 0, y: groundTexture.size().height)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.size.width, height: groundTexture.size().height * 2.0))
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = worldCategory
        self.addChild(ground)
    }
    
    //7
    func createSkyline(groundTexture: SKTexture) {

    }
    
    //8
    func createPipes() {

    }
    
    //9
    func setupBackgroundColor() {

    }
    
    //10
    func didBeginContact(contact: SKPhysicsContact) {

    }
    
    //11
    func setUpScore() {

    }
    
    //12
    func resetScene (){

    }
    //End of Additional Functions
    
    func spawnPipes() {
                let pipePair = SKNode()
                pipePair.position = CGPoint( x: self.frame.size.width + pipeTextureUp.size().width * 2, y: 0 )
                pipePair.zPosition = -10
        
                let height = UInt32( self.frame.size.height / 4)
                let y = Double(arc4random_uniform(height) + height);
        
                let pipeDown = SKSpriteNode(texture: pipeTextureDown)
                pipeDown.setScale(2.0)
                pipeDown.position = CGPoint(x: 0.0, y: y + Double(pipeDown.size.height) + verticalPipeGap)
        
                pipeDown.physicsBody = SKPhysicsBody(rectangleOfSize: pipeDown.size)
                pipeDown.physicsBody?.dynamic = false
                pipeDown.physicsBody?.categoryBitMask = pipeCategory
                pipeDown.physicsBody?.contactTestBitMask = birdCategory
                pipePair.addChild(pipeDown)
        
                let pipeUp = SKSpriteNode(texture: pipeTextureUp)
                pipeUp.setScale(2.0)
                pipeUp.position = CGPoint(x: 0.0, y: y)
        
                pipeUp.physicsBody = SKPhysicsBody(rectangleOfSize: pipeUp.size)
                pipeUp.physicsBody?.dynamic = false
                pipeUp.physicsBody?.categoryBitMask = pipeCategory
                pipeUp.physicsBody?.contactTestBitMask = birdCategory
                pipePair.addChild(pipeUp)
        
                var contactNode = SKNode()
                contactNode.position = CGPoint( x: pipeDown.size.width + bird.size.width / 2, y: self.frame.midY )
                contactNode.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize( width: pipeUp.size.width, height: self.frame.size.height ))
                contactNode.physicsBody?.dynamic = false
                contactNode.physicsBody?.categoryBitMask = scoreCategory
                contactNode.physicsBody?.contactTestBitMask = birdCategory
                pipePair.addChild(contactNode)
        
                pipePair.runAction(movePipesAndRemove)
                pipes.addChild(pipePair)
        
    }
}
