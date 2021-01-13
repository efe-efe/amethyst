<!-- kv3 encoding:text:version{e21c7f3c-8a33-41c5-9977-a76d3a32aa0d} format:vpcf31:version{593cd181-a1d6-4c6f-9a8c-0534e8d44db0} -->
{
	_class = "CParticleSystemDefinition"
	m_bShouldHitboxesFallbackToRenderBounds = false
	m_nMaxParticles = 50
	m_flConstantRadius = 40.0
	m_ConstantColor = [ 41, 242, 202, 255 ]
	m_nBehaviorVersion = 10
	m_nFirstMultipleOverride_BackwardCompat = 7
	m_controlPointConfigurations = 
	[
		{
			m_name = "preview"
			m_drivers = 
			[
				{
					m_iAttachType = "PATTACH_WORLDORIGIN"
					m_vecOffset = [ 0.0, 0.0, 0.0 ]
					m_angOffset = [ 0.0, 0.0, 0.0 ]
					m_entityName = "self"
				},
				{
					m_iControlPoint = 1
					m_iAttachType = "PATTACH_WORLDORIGIN"
					m_vecOffset = [ 0.0, 0.0, 0.0 ]
					m_angOffset = [ 0.0, 0.0, 0.0 ]
					m_entityName = "self"
				},
			]
		},
	]
	m_Emitters = 
	[
		{
			_class = "C_OP_ContinuousEmitter"
			m_flEmissionDuration = 
			{
				m_nType = "PF_TYPE_LITERAL"
				m_flLiteralValue = 0.15
			}
			m_flEmitRate = 
			{
				m_nType = "PF_TYPE_LITERAL"
				m_flLiteralValue = 300.0
			}
			m_bDisableOperator = true
		},
		{
			_class = "C_OP_InstantaneousEmitter"
			m_nParticlesToEmit = 
			{
				m_nType = "PF_TYPE_LITERAL"
				m_nMapType = "PF_MAP_TYPE_DIRECT"
				m_flLiteralValue = 50.0
				m_nControlPoint = 0
				m_nScalarAttribute = 3
				m_nVectorAttribute = 6
				m_nVectorComponent = 0
				m_flRandomMin = 0.0
				m_flRandomMax = 1.0
				m_nRandomMode = "PF_RANDOM_MODE_CONSTANT"
				m_flMultFactor = 1.0
				m_flInput0 = 0.0
				m_flInput1 = 1.0
				m_flOutput0 = 0.0
				m_flOutput1 = 1.0
				m_nBiasType = "PF_BIAS_TYPE_STANDARD"
				m_flBiasParameter = 0.0
				m_Curve = 
				{
					m_spline = [  ]
					m_tangents = [  ]
					m_vDomainMins = [ 0.0, 0.0 ]
					m_vDomainMaxs = [ 0.0, 0.0 ]
				}
			}
		},
	]
	m_Initializers = 
	[
		{
			_class = "C_INIT_RandomTrailLength"
			m_flMinLength = 1.0
			m_flMaxLength = 6.0
		},
		{
			_class = "C_INIT_RandomAlpha"
			m_bDisableOperator = true
		},
		{
			_class = "C_INIT_RandomScalar"
			m_nFieldOutput = "18"
			m_flMax = 5.0
			m_flMin = 0.1
		},
		{
			_class = "C_INIT_RandomRadius"
			m_flRadiusMin = 80.0
			m_flRadiusMax = 120.0
		},
		{
			_class = "C_INIT_RingWave"
			m_flInitialRadius = 
			{
				m_nType = "PF_TYPE_CONTROL_POINT_COMPONENT"
				m_nMapType = "PF_MAP_TYPE_DIRECT"
				m_flLiteralValue = 400.0
				m_nControlPoint = 2
				m_nScalarAttribute = 3
				m_nVectorAttribute = 6
				m_nVectorComponent = 0
				m_flRandomMin = 0.0
				m_flRandomMax = 1.0
				m_nRandomMode = "PF_RANDOM_MODE_CONSTANT"
				m_flLOD0 = 0.0
				m_flLOD1 = 0.0
				m_flLOD2 = 0.0
				m_flLOD3 = 0.0
				m_flNoiseOutputMin = 0.0
				m_flNoiseOutputMax = 1.0
				m_flNoiseScale = 0.1
				m_vecNoiseOffsetRate = [ 0.0, 0.0, 0.0 ]
				m_flNoiseOffset = 0.0
				m_nNoiseOctaves = 1
				m_nNoiseTurbulence = "PF_NOISE_TURB_NONE"
				m_nNoiseType = "PF_NOISE_TYPE_PERLIN"
				m_nNoiseModifier = "PF_NOISE_MODIFIER_NONE"
				m_flNoiseTurbulenceScale = 1.25
				m_flNoiseTurbulenceMix = 0.5
				m_flNoiseImgPreviewScale = 1.0
				m_bNoiseImgPreviewLive = true
				m_nInputMode = "PF_INPUT_MODE_CLAMPED"
				m_flMultFactor = 1.0
				m_flInput0 = 0.0
				m_flInput1 = 1.0
				m_flOutput0 = 0.0
				m_flOutput1 = 1.0
				m_nBiasType = "PF_BIAS_TYPE_STANDARD"
				m_flBiasParameter = 0.0
				m_Curve = 
				{
					m_spline = [  ]
					m_tangents = [  ]
					m_vDomainMins = [ 0.0, 0.0 ]
					m_vDomainMaxs = [ 0.0, 0.0 ]
				}
			}
			m_flInitialSpeedMin = 
			{
				m_nType = "PF_TYPE_LITERAL"
				m_flLiteralValue = -400.0
			}
			m_flInitialSpeedMax = 
			{
				m_nType = "PF_TYPE_LITERAL"
				m_flLiteralValue = -400.0
			}
		},
		{
			_class = "C_INIT_AddVectorToVector"
			m_nFieldOutput = "2"
			m_vOffsetMin = [ 0.0, 0.0, 900.0 ]
			m_vOffsetMax = [ 0.0, 0.0, 1200.0 ]
		},
		{
			_class = "C_INIT_RandomYawFlip"
		},
		{
			_class = "C_INIT_RandomLifeTime"
			m_fLifetimeMin = 0.3
			m_fLifetimeMax = 0.4
		},
		{
			_class = "C_INIT_RandomRadius"
			m_flRadiusMin = 8.0
			m_flRadiusMax = 60.0
		},
		{
			_class = "C_INIT_OffsetVectorToVector"
			m_nFieldOutput = "2"
			m_vecOutputMin = [ 0.0, 0.0, 400.0 ]
			m_vecOutputMax = [ 0.0, 0.0, 1200.0 ]
		},
		{
			_class = "C_INIT_RandomColor"
			m_ColorMin = [ 0, 253, 219 ]
			m_ColorMax = [ 0, 152, 255 ]
			m_TintMin = [ 0, 0, 0 ]
			m_TintMax = [ 255, 255, 255 ]
		},
		{
			_class = "C_INIT_RandomTrailLength"
			m_flMinLength = 0.3
			m_flMaxLength = 0.8
		},
	]
	m_Operators = 
	[
		{
			_class = "C_OP_Decay"
		},
		{
			_class = "C_OP_FadeOutSimple"
			m_flFadeOutTime = 0.5
		},
		{
			_class = "C_OP_FadeInSimple"
			m_flFadeInTime = 0.1
		},
		{
			_class = "C_OP_LerpScalar"
			m_flOutput = 0.5
			m_nFieldOutput = "18"
		},
		{
			_class = "C_OP_EndCapTimedDecay"
		},
		{
			_class = "C_OP_PositionLock"
			m_nControlPointNumber = 1
			m_bLockRot = true
		},
		{
			_class = "C_OP_InterpolateRadius"
			m_flStartScale = 0.0
			m_flBias = 0.45
		},
		{
			_class = "C_OP_RemapScalar"
			m_nFieldInput = "3"
			m_nFieldOutput = "10"
			m_bDisableOperator = true
		},
		{
			_class = "C_OP_ColorInterpolate"
			m_ColorFade = [ 43, 28, 128 ]
			m_flFadeStartTime = 0.5
		},
	]
	m_Renderers = 
	[
		{
			_class = "C_OP_RenderTrails"
			m_flMaxLength = 20000.0
			m_bIgnoreDT = true
			m_nVertCropField = "18"
			m_flRadiusScale = 
			{
				m_nType = "PF_TYPE_LITERAL"
				m_flLiteralValue = 5.0
			}
			m_vecTailColorScale = 
			{
				m_nType = "PVEC_TYPE_LITERAL"
				m_vLiteralValue = [ 1.0, 0.0, 1.0 ]
			}
			m_flTailAlphaScale = 
			{
				m_nType = "PF_TYPE_LITERAL"
				m_flLiteralValue = 0.0
			}
			m_vecTexturesInput = 
			[
				{
					m_hTexture = resource:"materials/particle/beam_generic_7.vtex"
					m_TextureControls = 
					{
						m_flFinalTextureScaleV = 
						{
							m_nType = "PF_TYPE_LITERAL"
							m_flLiteralValue = -1.0
						}
						m_flFinalTextureOffsetV = 
						{
							m_nType = "PF_TYPE_LITERAL"
							m_flLiteralValue = 1.0
						}
					}
				},
			]
			m_nOutputBlendMode = "PARTICLE_OUTPUT_BLEND_MODE_ADD"
		},
		{
			_class = "C_OP_RenderTrails"
			m_flMaxLength = 20000.0
			m_bIgnoreDT = true
			m_nVertCropField = "18"
			m_flRadiusTaper = 
			{
				m_nType = "PF_TYPE_LITERAL"
				m_flLiteralValue = 0.5
			}
			m_vecTailColorScale = 
			{
				m_nType = "PVEC_TYPE_LITERAL_COLOR"
				m_LiteralColor = [ 255, 255, 255 ]
			}
			m_flTailAlphaScale = 
			{
				m_nType = "PF_TYPE_LITERAL"
				m_flLiteralValue = 0.0
			}
			m_vecTexturesInput = 
			[
				{
					m_hTexture = resource:"materials/particle/beam_noise05.vtex"
					m_TextureControls = 
					{
						m_flFinalTextureScaleV = 
						{
							m_nType = "PF_TYPE_LITERAL"
							m_flLiteralValue = -1.0
						}
						m_flFinalTextureOffsetV = 
						{
							m_nType = "PF_TYPE_LITERAL"
							m_flLiteralValue = 1.0
						}
					}
				},
			]
			m_nOutputBlendMode = "PARTICLE_OUTPUT_BLEND_MODE_ADD"
		},
	]
	m_Children = 
	[
		{
			m_ChildRef = resource:"particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_debut_ground_rays_sparks.vpcf"
		},
	]
}