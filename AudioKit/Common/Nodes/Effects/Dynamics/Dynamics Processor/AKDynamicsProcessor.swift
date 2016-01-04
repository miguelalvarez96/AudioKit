//
//  AKDynamicsProcessor.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright (c) 2016 Aurelius Prochazka. All rights reserved.
//

import AVFoundation

/// AudioKit version of Apple's DynamicsProcessor Audio Unit
///
/// - parameter input: Input node to process
/// - parameter threshold: Threshold (dB) ranges from -40 to 20 (Default: -20)
/// - parameter headRoom: Head Room (dB) ranges from 0.1 to 40.0 (Default: 5)
/// - parameter expansionRatio: Expansion Ratio (rate) ranges from 1 to 50.0 (Default: 2)
/// - parameter expansionThreshold: Expansion Threshold (rate) ranges from 1 to 50.0 (Default: 2)
/// - parameter attackTime: Attack Time (secs) ranges from 0.0001 to 0.2 (Default: 0.001)
/// - parameter releaseTime: Release Time (secs) ranges from 0.01 to 3 (Default: 0.05)
/// - parameter masterGain: Master Gain (dB) ranges from -40 to 40 (Default: 0)
/// - parameter compressionAmount: Compression Amount (dB) ranges from -40 to 40 (Default: 0)
/// - parameter inputAmplitude: Input Amplitude (dB) ranges from -40 to 40 (Default: 0)
/// - parameter outputAmplitude: Output Amplitude (dB) ranges from -40 to 40 (Default: 0)
///
public class AKDynamicsProcessor: AKNode {

    private let cd = AudioComponentDescription(
        componentType: kAudioUnitType_Effect,
        componentSubType: kAudioUnitSubType_DynamicsProcessor,
        componentManufacturer: kAudioUnitManufacturer_Apple,
        componentFlags: 0,
        componentFlagsMask: 0)

    internal var internalEffect = AVAudioUnitEffect()
    internal var internalAU = AudioUnit()

    /// Required property for AKNode containing the output node
    public var avAudioNode: AVAudioNode

    /// Required property for AKNode containing all the node's connections
    public var connectionPoints = [AVAudioConnectionPoint]()

    private var input: AKNode?
    private var mixer: AKMixer

    /// Threshold (dB) ranges from -40 to 20 (Default: -20)
    public var threshold: Double = -20 {
        didSet {
            if threshold < -40 {
                threshold = -40
            }            
            if threshold > 20 {
                threshold = 20
            }
            AudioUnitSetParameter(
                internalAU,
                kDynamicsProcessorParam_Threshold,
                kAudioUnitScope_Global, 0,
                Float(threshold), 0)
        }
    }

    /// Head Room (dB) ranges from 0.1 to 40.0 (Default: 5)
    public var headRoom: Double = 5 {
        didSet {
            if headRoom < 0.1 {
                headRoom = 0.1
            }            
            if headRoom > 40.0 {
                headRoom = 40.0
            }
            AudioUnitSetParameter(
                internalAU,
                kDynamicsProcessorParam_HeadRoom,
                kAudioUnitScope_Global, 0,
                Float(headRoom), 0)
        }
    }

    /// Expansion Ratio (rate) ranges from 1 to 50.0 (Default: 2)
    public var expansionRatio: Double = 2 {
        didSet {
            if expansionRatio < 1 {
                expansionRatio = 1
            }            
            if expansionRatio > 50.0 {
                expansionRatio = 50.0
            }
            AudioUnitSetParameter(
                internalAU,
                kDynamicsProcessorParam_ExpansionRatio,
                kAudioUnitScope_Global, 0,
                Float(expansionRatio), 0)
        }
    }

    /// Expansion Threshold (rate) ranges from 1 to 50.0 (Default: 2)
    public var expansionThreshold: Double = 2 {
        didSet {
            if expansionThreshold < 1 {
                expansionThreshold = 1
            }            
            if expansionThreshold > 50.0 {
                expansionThreshold = 50.0
            }
            AudioUnitSetParameter(
                internalAU,
                kDynamicsProcessorParam_ExpansionThreshold,
                kAudioUnitScope_Global, 0,
                Float(expansionThreshold), 0)
        }
    }

    /// Attack Time (secs) ranges from 0.0001 to 0.2 (Default: 0.001)
    public var attackTime: Double = 0.001 {
        didSet {
            if attackTime < 0.0001 {
                attackTime = 0.0001
            }            
            if attackTime > 0.2 {
                attackTime = 0.2
            }
            AudioUnitSetParameter(
                internalAU,
                kDynamicsProcessorParam_AttackTime,
                kAudioUnitScope_Global, 0,
                Float(attackTime), 0)
        }
    }

    /// Release Time (secs) ranges from 0.01 to 3 (Default: 0.05)
    public var releaseTime: Double = 0.05 {
        didSet {
            if releaseTime < 0.01 {
                releaseTime = 0.01
            }            
            if releaseTime > 3 {
                releaseTime = 3
            }
            AudioUnitSetParameter(
                internalAU,
                kDynamicsProcessorParam_ReleaseTime,
                kAudioUnitScope_Global, 0,
                Float(releaseTime), 0)
        }
    }

    /// Master Gain (dB) ranges from -40 to 40 (Default: 0)
    public var masterGain: Double = 0 {
        didSet {
            if masterGain < -40 {
                masterGain = -40
            }            
            if masterGain > 40 {
                masterGain = 40
            }
            AudioUnitSetParameter(
                internalAU,
                kDynamicsProcessorParam_MasterGain,
                kAudioUnitScope_Global, 0,
                Float(masterGain), 0)
        }
    }

    /// Compression Amount (dB) ranges from -40 to 40 (Default: 0)
    public var compressionAmount: Double = 0 {
        didSet {
            if compressionAmount < -40 {
                compressionAmount = -40
            }            
            if compressionAmount > 40 {
                compressionAmount = 40
            }
            AudioUnitSetParameter(
                internalAU,
                kDynamicsProcessorParam_CompressionAmount,
                kAudioUnitScope_Global, 0,
                Float(compressionAmount), 0)
        }
    }

    /// Input Amplitude (dB) ranges from -40 to 40 (Default: 0)
    public var inputAmplitude: Double = 0 {
        didSet {
            if inputAmplitude < -40 {
                inputAmplitude = -40
            }            
            if inputAmplitude > 40 {
                inputAmplitude = 40
            }
            AudioUnitSetParameter(
                internalAU,
                kDynamicsProcessorParam_InputAmplitude,
                kAudioUnitScope_Global, 0,
                Float(inputAmplitude), 0)
        }
    }

    /// Output Amplitude (dB) ranges from -40 to 40 (Default: 0)
    public var outputAmplitude: Double = 0 {
        didSet {
            if outputAmplitude < -40 {
                outputAmplitude = -40
            }            
            if outputAmplitude > 40 {
                outputAmplitude = 40
            }
            AudioUnitSetParameter(
                internalAU,
                kDynamicsProcessorParam_OutputAmplitude,
                kAudioUnitScope_Global, 0,
                Float(outputAmplitude), 0)
        }
    }

    /// Dry/Wet Mix (Default 100)
    public var dryWetMix: Double = 100 {
        didSet {
            if dryWetMix < 0 {
                dryWetMix = 0
            }
            if dryWetMix > 100 {
                dryWetMix = 100
            }
            inputGain?.gain = 1 - dryWetMix / 100
            effectGain?.gain = dryWetMix / 100
        }
    }

    private var inputGain: AKGain?
    private var effectGain: AKGain?

    /// Tells whether the node is processing (ie. started, playing, or active)
    public var isStarted = true

    /// Tells whether the node is processing (ie. started, playing, or active)
    public var isPlaying: Bool {
        return isStarted
    }

    /// Tells whether the node is not processing (ie. stopped or bypassed)
    public var isStopped: Bool {
        return !isStarted
    }

    /// Tells whether the node is not processing (ie. stopped or bypassed)
    public var isBypassed: Bool {
        return !isStarted
    }

    /// Initialize the dynamics processor node
    ///
    /// - parameter input: Input node to process
    /// - parameter threshold: Threshold (dB) ranges from -40 to 20 (Default: -20)
    /// - parameter headRoom: Head Room (dB) ranges from 0.1 to 40.0 (Default: 5)
    /// - parameter expansionRatio: Expansion Ratio (rate) ranges from 1 to 50.0 (Default: 2)
    /// - parameter expansionThreshold: Expansion Threshold (rate) ranges from 1 to 50.0 (Default: 2)
    /// - parameter attackTime: Attack Time (secs) ranges from 0.0001 to 0.2 (Default: 0.001)
    /// - parameter releaseTime: Release Time (secs) ranges from 0.01 to 3 (Default: 0.05)
    /// - parameter masterGain: Master Gain (dB) ranges from -40 to 40 (Default: 0)
    /// - parameter compressionAmount: Compression Amount (dB) ranges from -40 to 40 (Default: 0)
    /// - parameter inputAmplitude: Input Amplitude (dB) ranges from -40 to 40 (Default: 0)
    /// - parameter outputAmplitude: Output Amplitude (dB) ranges from -40 to 40 (Default: 0)
    ///
    public init(
        var _ input: AKNode,
        threshold: Double = -20,
        headRoom: Double = 5,
        expansionRatio: Double = 2,
        expansionThreshold: Double = 2,
        attackTime: Double = 0.001,
        releaseTime: Double = 0.05,
        masterGain: Double = 0,
        compressionAmount: Double = 0,
        inputAmplitude: Double = 0,
        outputAmplitude: Double = 0) {
            self.input = input
            self.threshold = threshold
            self.headRoom = headRoom
            self.expansionRatio = expansionRatio
            self.expansionThreshold = expansionThreshold
            self.attackTime = attackTime
            self.releaseTime = releaseTime
            self.masterGain = masterGain
            self.compressionAmount = compressionAmount
            self.inputAmplitude = inputAmplitude
            self.outputAmplitude = outputAmplitude

            inputGain = AKGain(input, gain: 0)
            mixer = AKMixer(inputGain!)

            internalEffect = AVAudioUnitEffect(audioComponentDescription: cd)
            self.avAudioNode = internalEffect
            AKManager.sharedInstance.engine.attachNode(internalEffect)
            input.addConnectionPoint(self)
            internalAU = internalEffect.audioUnit

            effectGain = AKGain(self, gain: 1)
            mixer.connect(effectGain!)
            self.avAudioNode = mixer.avAudioNode

            AudioUnitSetParameter(internalAU, kDynamicsProcessorParam_Threshold, kAudioUnitScope_Global, 0, Float(threshold), 0)
            AudioUnitSetParameter(internalAU, kDynamicsProcessorParam_HeadRoom, kAudioUnitScope_Global, 0, Float(headRoom), 0)
            AudioUnitSetParameter(internalAU, kDynamicsProcessorParam_ExpansionRatio, kAudioUnitScope_Global, 0, Float(expansionRatio), 0)
            AudioUnitSetParameter(internalAU, kDynamicsProcessorParam_ExpansionThreshold, kAudioUnitScope_Global, 0, Float(expansionThreshold), 0)
            AudioUnitSetParameter(internalAU, kDynamicsProcessorParam_AttackTime, kAudioUnitScope_Global, 0, Float(attackTime), 0)
            AudioUnitSetParameter(internalAU, kDynamicsProcessorParam_ReleaseTime, kAudioUnitScope_Global, 0, Float(releaseTime), 0)
            AudioUnitSetParameter(internalAU, kDynamicsProcessorParam_MasterGain, kAudioUnitScope_Global, 0, Float(masterGain), 0)
            AudioUnitSetParameter(internalAU, kDynamicsProcessorParam_CompressionAmount, kAudioUnitScope_Global, 0, Float(compressionAmount), 0)
            AudioUnitSetParameter(internalAU, kDynamicsProcessorParam_InputAmplitude, kAudioUnitScope_Global, 0, Float(inputAmplitude), 0)
            AudioUnitSetParameter(internalAU, kDynamicsProcessorParam_OutputAmplitude, kAudioUnitScope_Global, 0, Float(outputAmplitude), 0)
    }

    /// Function to start, play, or activate the node, all do the same thing
    public func start() {
        if isStopped {
            inputGain?.gain = 0
            effectGain?.gain = 1
            isStarted = true
        }
    }

    /// Function to start, play, or activate the node, all do the same thing
    public func play() {
        start()
    }

    /// Function to stop or bypass the node, both are equivalent
    public func stop() {
        if isPlaying {
            inputGain?.gain = 1
            effectGain?.gain = 0
            isStarted = false
        }
    }

    /// Function to stop or bypass the node, both are equivalent
    public func bypass() {
        stop()
    }
}
