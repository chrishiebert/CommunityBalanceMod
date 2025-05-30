-- ======= Copyright (c) 2003-2011, Unknown Worlds Entertainment, Inc. All rights reserved. =======
--
-- lua\Sentry.lua
--
--    Created by:   Charlie Cleveland (charlie@unknownworlds.com)
--                  Andreas Urwalek (andi@unknownworlds.com)
--
-- ========= For more information, visit us at http://www.unknownworlds.com =====================

Script.Load("lua/Mixins/ClientModelMixin.lua")
Script.Load("lua/LiveMixin.lua")
Script.Load("lua/PointGiverMixin.lua")
Script.Load("lua/AchievementGiverMixin.lua")
Script.Load("lua/GameEffectsMixin.lua")
Script.Load("lua/SelectableMixin.lua")
Script.Load("lua/FlinchMixin.lua")
Script.Load("lua/LOSMixin.lua")
Script.Load("lua/TeamMixin.lua")
Script.Load("lua/EntityChangeMixin.lua")
Script.Load("lua/CorrodeMixin.lua")
Script.Load("lua/ConstructMixin.lua")
Script.Load("lua/ResearchMixin.lua")
Script.Load("lua/RecycleMixin.lua")
Script.Load("lua/ScriptActor.lua")
Script.Load("lua/RagdollMixin.lua")
Script.Load("lua/NanoShieldMixin.lua")
Script.Load("lua/SleeperMixin.lua")
Script.Load("lua/StunMixin.lua")
Script.Load("lua/ObstacleMixin.lua")
Script.Load("lua/WeldableMixin.lua")
--Script.Load("lua/LaserMixin.lua")
Script.Load("lua/TargetCacheMixin.lua")
Script.Load("lua/OrdersMixin.lua")
Script.Load("lua/UnitStatusMixin.lua")
Script.Load("lua/DamageMixin.lua")
Script.Load("lua/DissolveMixin.lua")
Script.Load("lua/GhostStructureMixin.lua")
Script.Load("lua/MapBlipMixin.lua")
Script.Load("lua/TriggerMixin.lua")
Script.Load("lua/TargettingMixin.lua")
Script.Load("lua/CombatMixin.lua")
Script.Load("lua/CommanderGlowMixin.lua")
Script.Load("lua/InfestationTrackerMixin.lua")
Script.Load("lua/SupplyUserMixin.lua")
Script.Load("lua/BlightMixin.lua")
Script.Load("lua/BlowtorchTargetMixin.lua")
Script.Load("lua/PowerConsumerMixin.lua")

local kSpinUpSoundName = PrecacheAsset("sound/NS2.fev/marine/structures/sentry_spin_up")
local kSpinDownSoundName = PrecacheAsset("sound/NS2.fev/marine/structures/sentry_spin_down")

class 'Sentry' (ScriptActor)

Sentry.kMapName = "sentry"

Sentry.kModelName = PrecacheAsset("models/marine/sentry/sentry.model")
local kAnimationGraph = PrecacheAsset("models/marine/sentry/sentry.animation_graph")

local kAttackSoundName = PrecacheAsset("sound/NS2.fev/marine/structures/sentry_fire_loop")

local kSentryScanSoundName = PrecacheAsset("sound/NS2.fev/marine/structures/sentry_scan")
-- happens in TechData
--local kUnderAttackSound = PrecacheAsset("sound/NS2.fev/marine/voiceovers/commander/sentry_taking_damage")
local kFiringAlertSound = PrecacheAsset("sound/NS2.fev/marine/voiceovers/commander/sentry_firing")

local kConfusedSound = PrecacheAsset("sound/NS2.fev/marine/structures/sentry_confused")

local kFireShellEffect = PrecacheAsset("cinematics/marine/sentry/fire_shell.cinematic")

-- Balance
Sentry.kPingInterval = 4
Sentry.kFov = 360
Sentry.kMaxPitch = 180 -- 160 total
Sentry.kMaxYaw = Sentry.kFov / 2
Sentry.kTargetScanDelay = 1.5

Sentry.kDamage = kSentryDamage
Sentry.kRange = kSentryRange
Sentry.kBuildRange = kSentryBuildRange
Sentry.kBaseROF = kSentryAttackBaseROF
Sentry.kRandROF = kSentryAttackRandROF
Sentry.kSpread = kSentrySpread
Sentry.kBulletsPerSalvo = kSentryAttackBulletsPerSalvo
Sentry.kBarrelScanRate = 60      -- Degrees per second to scan back and forth with no target
Sentry.kBarrelMoveRate = 150    -- Degrees per second to move sentry orientation towards target or back to flat when targeted
Sentry.kBarrelMoveTargetMult = 4 -- when a target is acquired, how fast to swivel the barrel
Sentry.kReorientSpeed = .05

Sentry.kTargetAcquireTime = kSentryTargetAcquireTime
Sentry.kConfuseDuration = kSentryConfuseDuration
Sentry.kAttackEffectInterval = kSentryAttackEffectInterval
Sentry.kConfusedAttackEffectInterval = kConfusedSentryBaseROF

-- Animations
Sentry.kYawPoseParam = "sentry_yaw" -- Sentry yaw pose parameter for aiming
Sentry.kPitchPoseParam = "sentry_pitch"
Sentry.kMuzzleNode = "fxnode_sentrymuzzle"
Sentry.kEyeNode = "fxnode_eye"
Sentry.kLaserNode = "fxnode_eye"

-- prevents attacking during deploy animation for kDeployTime seconds
local kDeployTime = 3.5

local networkVars =
{    
    -- So we can update angles and pose parameters smoothly on client
    targetDirection = "vector",  
    
    confused = "boolean",
    
    deployed = "boolean",
    
    attacking = "boolean",
    
    attachedToBattery = "boolean"
}

AddMixinNetworkVars(BaseModelMixin, networkVars)
AddMixinNetworkVars(ClientModelMixin, networkVars)
AddMixinNetworkVars(LiveMixin, networkVars)
AddMixinNetworkVars(GameEffectsMixin, networkVars)
AddMixinNetworkVars(FlinchMixin, networkVars)
AddMixinNetworkVars(TeamMixin, networkVars)
AddMixinNetworkVars(LOSMixin, networkVars)
AddMixinNetworkVars(CorrodeMixin, networkVars)
AddMixinNetworkVars(ConstructMixin, networkVars)
AddMixinNetworkVars(ResearchMixin, networkVars)
AddMixinNetworkVars(RecycleMixin, networkVars)
AddMixinNetworkVars(CombatMixin, networkVars)
AddMixinNetworkVars(NanoShieldMixin, networkVars)
AddMixinNetworkVars(StunMixin, networkVars)
AddMixinNetworkVars(ObstacleMixin, networkVars)
--AddMixinNetworkVars(LaserMixin, networkVars)
AddMixinNetworkVars(OrdersMixin, networkVars)
AddMixinNetworkVars(DissolveMixin, networkVars)
AddMixinNetworkVars(GhostStructureMixin, networkVars)
AddMixinNetworkVars(SelectableMixin, networkVars)
AddMixinNetworkVars(ParasiteMixin, networkVars)
AddMixinNetworkVars(BlightMixin, networkVars)
AddMixinNetworkVars(PowerConsumerMixin, networkVars)

function Sentry:OnCreate()

    ScriptActor.OnCreate(self)
    
    InitMixin(self, BaseModelMixin)
    InitMixin(self, ClientModelMixin)
    InitMixin(self, LiveMixin)
    InitMixin(self, GameEffectsMixin)
    InitMixin(self, FlinchMixin, { kPlayFlinchAnimations = true })
    InitMixin(self, TeamMixin)
    InitMixin(self, PointGiverMixin)
    InitMixin(self, AchievementGiverMixin)
    InitMixin(self, SelectableMixin)
    InitMixin(self, EntityChangeMixin)
    InitMixin(self, LOSMixin)
    InitMixin(self, CorrodeMixin)
    InitMixin(self, ConstructMixin)
    InitMixin(self, ResearchMixin)
    InitMixin(self, RecycleMixin)
    InitMixin(self, CombatMixin)
    InitMixin(self, RagdollMixin)
    InitMixin(self, DamageMixin)
    InitMixin(self, StunMixin)
    InitMixin(self, ObstacleMixin)
    InitMixin(self, OrdersMixin, { kMoveOrderCompleteDistance = kAIMoveOrderCompleteDistance })
    InitMixin(self, DissolveMixin)
    InitMixin(self, GhostStructureMixin)
    InitMixin(self, ParasiteMixin)
	InitMixin(self, BlightMixin)
	InitMixin(self, PowerConsumerMixin)    
    
    if Client then
        InitMixin(self, CommanderGlowMixin)
		InitMixin(self, BlowtorchTargetMixin)
    end
    
	self.relativeTargetDirectionOld = Vector(1,0,0)
	self.desiredYawDegreesOld = -90
    self.desiredYawDegrees = 0
    self.desiredPitchDegrees = 0
    self.barrelYawDegrees = 0
    self.barrelPitchDegrees = 0

    self.confused = false
    self.attachedToBattery = true
    
    if Server then

        self.attackSound = Server.CreateEntity(SoundEffect.kMapName)
        self.attackSound:SetParent(self)
        self.attackSound:SetAsset(kAttackSoundName)
        
    elseif Client then
    
        self.timeLastAttackEffect = Shared.GetTime()
        
        -- Play a "ping" sound effect every Sentry.kPingInterval while scanning.
        local function PlayScanPing(sentry)
        
            local interval = sentry.kTargetScanDelay + sentry.kPingInterval
            if GetIsUnitActive(sentry) and not sentry.attacking and sentry.attachedToBattery and (sentry.timeLastAttackEffect + interval < Shared.GetTime())  then
                local player = Client.GetLocalPlayer()
                Shared.PlayPrivateSound(player, kSentryScanSoundName, nil, 1, sentry:GetModelOrigin())
            end
            return true
            
        end
        
        self:AddTimedCallback(PlayScanPing, self.kPingInterval)
        
    end
    
    self:SetLagCompensated(false)
    self:SetPhysicsType(PhysicsType.Kinematic)
    self:SetPhysicsGroup(PhysicsGroup.MediumStructuresGroup)
    self:SetUpdates(true, .05)
    
end

function Sentry:OnInitialized()

    ScriptActor.OnInitialized(self)
    
    InitMixin(self, NanoShieldMixin)
    InitMixin(self, WeldableMixin)
    
    --InitMixin(self, LaserMixin)
    
    self:SetModel(Sentry.kModelName, kAnimationGraph)
    
    if Server then 
    
        InitMixin(self, SleeperMixin)
        
        self.timeLastTargetChange = Shared.GetTime()
        
        -- This Mixin must be inited inside this OnInitialized() function.
        if not HasMixin(self, "MapBlip") then
            InitMixin(self, MapBlipMixin)
        end
        
        -- TargetSelectors require the TargetCacheMixin for cleanup.
        InitMixin(self, TargetCacheMixin)
        InitMixin(self, SupplyUserMixin)
        
        -- configure how targets are selected and validated
        self.targetSelector = TargetSelector():Init(
            self,
            Sentry.kRange, 
            true,
            { kMarineStaticTargets, kMarineMobileTargets },
            { PitchTargetFilter(self,  -Sentry.kMaxPitch, Sentry.kMaxPitch), CloakTargetFilter() },
            { function(target) return target:isa("Player") end } )

        InitMixin(self, StaticTargetMixin)
        InitMixin(self, InfestationTrackerMixin)
        
    elseif Client then
    
        InitMixin(self, UnitStatusMixin)   
        InitMixin(self, HiveVisionMixin)
 
    end
    
end

function Sentry:OnDestroy()

    ScriptActor.OnDestroy(self)
    
    -- The attackSound was already destroyed at this point, clear the reference.
    if Server then
        self.attackSound = nil
    end
    
end

function Sentry:GetCanSleep()
    return self.attacking == false
end

function Sentry:GetMinimumAwakeTime()
    return 10
end 

function Sentry:GetFov()
    return Sentry.kFov
end

local kSentryEyeHeight = Vector(0, 0.8, 0)
function Sentry:GetEyePos()
    return self:GetOrigin() + kSentryEyeHeight
end

function Sentry:GetDeathIconIndex()
    return kDeathMessageIcon.Sentry
end

function Sentry:GetReceivesStructuralDamage()
    return true
end

function Sentry:GetBarrelPoint()
    return self:GetAttachPointOrigin(Sentry.kMuzzleNode)    
end

function Sentry:GetLaserAttachCoords()

    local coords = self:GetAttachPointCoords(Sentry.kLaserNode)    
    local xAxis = coords.xAxis
    coords.xAxis = -coords.zAxis
    coords.zAxis = xAxis

    return coords   
end

function Sentry:OverrideLaserLength()
    return self.kRange
end

function Sentry:GetPlayInstantRagdoll()
    return true
end

function Sentry:GetIsLaserActive()
    return GetIsUnitActive(self) and self.deployed and self.attachedToBattery
end

function Sentry:OnUpdatePoseParameters()

    PROFILE("Sentry:OnUpdatePoseParameters")

    local pitchConfused = 0
    local yawConfused = 0
    
    -- alter the yaw and pitch slightly, barrel will swirl around
    if self.confused then
    
        pitchConfused = math.sin(Shared.GetTime() * 6) * 2
        yawConfused = math.cos(Shared.GetTime() * 6) * 2
        
    end
    
    self:SetPoseParam(Sentry.kPitchPoseParam, self.barrelPitchDegrees + pitchConfused)
    self:SetPoseParam(Sentry.kYawPoseParam, self.barrelYawDegrees + yawConfused)
    
end

function Sentry:OnUpdateAnimationInput(modelMixin)

    PROFILE("Sentry:OnUpdateAnimationInput")    
    modelMixin:SetAnimationInput("attack", self.attacking)
    modelMixin:SetAnimationInput("powered", self.attachedToBattery)
    
end

-- used to prevent showing the hit indicator for the commander
function Sentry:GetShowHitIndicator()
    return false
end

function Sentry:OnWeldOverride(entity, elapsedTime)

    local welded = false

    -- faster repair rate for sentries, promote use of welders
    if entity:isa("Welder") or entity:isa("Exo") then

        local amount = kWelderSentryRepairRate * elapsedTime
        self:AddHealth(amount)

    elseif entity:isa("MAC") then

        self:AddHealth(MAC.kRepairHealthPerSecond * elapsedTime)

    end

end

function Sentry:GetHealthbarOffset()
    return 0.4
end 

if Server then

    local function OnDeploy(self)
    
        self.attacking = false
        self.deployed = true
        return false
        
    end
    
    function Sentry:OnConstructionComplete()
        self:AddTimedCallback(OnDeploy, kDeployTime)      
    end
    
    function Sentry:OnStun(duration)
        self:Confuse(duration)
    end
    
    function Sentry:GetDamagedAlertId()
        return kTechId.MarineAlertSentryUnderAttack
    end
    
    function Sentry:FireBullets()

        local fireCoords = Coords.GetLookIn(Vector(0,0,0), self.targetDirection)     
        local startPoint = self:GetBarrelPoint()

        for bullet = 1, self.kBulletsPerSalvo do
        
            local spreadDirection = CalculateSpread(fireCoords, self.kSpread, math.random)
            
            local endPoint = startPoint + spreadDirection * self.kRange
            
            local trace = Shared.TraceRay(startPoint, endPoint, CollisionRep.Damage, PhysicsMask.Bullets, EntityFilterOne(self))
            
            if trace.fraction < 1 then
            
                local damage = self.kDamage
                local surface = trace.surface
                
                -- Disable friendly fire.
                trace.entity = (not trace.entity or GetAreEnemies(trace.entity, self)) and trace.entity or nil
                
                local blockedByUmbra = trace.entity and GetBlockedByUmbra(trace.entity) or false
                
                if blockedByUmbra then
                    surface = "umbra"
                end
                
                local direction = (trace.endPoint - startPoint):GetUnit()
                --Print("Sentry %d doing %.2f damage to %s (ramp up %.2f)", self:GetId(), damage, SafeClassName(trace.entity), rampUpFraction)
                self:DoDamage(damage, trace.entity, trace.endPoint, direction, surface, false, true)
                                
            end
            
        end
        
    end
    
    -- checking at range 1.8 for overlapping the radius a bit. no LOS check here since i think it would become too expensive with multiple sentries
    function Sentry:GetFindsSporesAt(position)
        return #GetEntitiesWithinRange("SporeCloud", position, kSporesDustCloudRadius * 0.75) > 0
    end
    
    function Sentry:Confuse(duration)

        if not self.confused then
        
            self.confused = true
            self.timeConfused = Shared.GetTime() + duration
            
            StartSoundEffectOnEntity(kConfusedSound, self)
            
        end
        
    end
    

    local kSporesConfusionDelay = 0.2

    -- check for spores in our way every kSporesConfusionDelay seconds
    local function UpdateConfusedState(self, target)

        if not self.confused and target then
            
            if not self.timeCheckedForSpores then
                self.timeCheckedForSpores = Shared.GetTime() - kSporesConfusionDelay
            end
            
            if self.timeCheckedForSpores + kSporesConfusionDelay < Shared.GetTime() then
            
                self.timeCheckedForSpores = Shared.GetTime()
            
                local eyePos = self:GetEyePos()
                local toTarget = target:GetOrigin() - eyePos
                local distanceToTarget = toTarget:GetLength()
                toTarget:Normalize()
                
                local stepLength = 3
                local numChecks = math.ceil(self.kRange/stepLength)
                
                -- check every few meters for a spore in the way, min distance 3 meters, max 12 meters (but also check sentry eyepos)
                for i = 0, numChecks do
                
                    -- stop when target has reached, any spores would be behind
                    if distanceToTarget < (i * stepLength) then
                        break
                    end
                
                    local checkAtPoint = eyePos + toTarget * i * stepLength
                    if self:GetFindsSporesAt(checkAtPoint) then
                        self:Confuse(self.kConfuseDuration)
                        break
                    end
                
                end
            
            end
            
        elseif self.confused then
        
            if self.timeConfused < Shared.GetTime() then
                self.confused = false
            end
        
        end

    end
    
    local function UpdateBatteryState(self)
    
        local time = Shared.GetTime()
        
        if self.lastBatteryCheckTime == nil or (time > self.lastBatteryCheckTime + 0.5) then
        
            -- Update if we're powered or not
            self.attachedToBattery = false
            
            local ents = GetEntitiesForTeamWithinRange("SentryBattery", self:GetTeamNumber(), self:GetOrigin(), SentryBattery.kRange)
            for index, ent in ipairs(ents) do
            
                if GetIsUnitActive(ent) and ent:GetLocationName() == self:GetLocationName() then
                
                    self.attachedToBattery = true
                    break
                    
                end
                
            end
            
            self.lastBatteryCheckTime = time
            
        end
        
    end
    
    function Sentry:OnUpdate(deltaTime)
    
        PROFILE("Sentry:OnUpdate")
        
        ScriptActor.OnUpdate(self, deltaTime)  
        
        --UpdateBatteryState(self)
        
        if self.timeNextAttack == nil or (Shared.GetTime() > self.timeNextAttack) then
        
            local initialAttack = self.target == nil
            
            local prevTarget
            if self.target then
                prevTarget = self.target
            end
            
            self.target = nil
            
            if GetIsUnitActive(self) and self.attachedToBattery and self.deployed then
                self.target = self.targetSelector:AcquireTarget()
            end
            
            UpdateConfusedState(self, self.target)
            -- slower fire rate when confused
            local confusedTime = self.confused == true and self.kConfusedAttackEffectInterval or 0

            -- Random rate of fire so it can't be gamed
            if initialAttack and self.target then
                self.timeNextAttack = Shared.GetTime() + self.kTargetAcquireTime
            else
                self.timeNextAttack = confusedTime + Shared.GetTime() + self.kBaseROF + math.random() * self.kRandROF
            end

            if self.target then
            
                local previousTargetDirection = self.targetDirection
                self.targetDirection = GetNormalizedVector(self.target:GetEngagementPoint() - self:GetAttachPointOrigin(Sentry.kMuzzleNode))
                
                -- Reset damage ramp up if we moved barrel at all
                if previousTargetDirection then
                    local dotProduct = previousTargetDirection:DotProduct(self.targetDirection)
                    if dotProduct < .99 then
                    
                        self.timeLastTargetChange = Shared.GetTime()
                        
                    end    
                end

                -- Or if target changed, reset it even if we're still firing in the exact same direction
                if self.target ~= prevTarget then
                    self.timeLastTargetChange = Shared.GetTime()
                end            
                
                -- don't shoot immediately
                if not initialAttack then
                
                    self.attacking = true
                    self:FireBullets()
                    
                end    
                
            else
            
                self.attacking = false
                self.timeLastTargetChange = Shared.GetTime()

            end
            
            if not GetIsUnitActive() or self.confused or not self.attacking or not self.attachedToBattery then
            
                if self.attackSound:GetIsPlaying() then
                    self.attackSound:Stop()
                end
                
            elseif self.attacking then
            
                if not self.attackSound:GetIsPlaying() then
                    self.attackSound:Start()
                end

            end 
        
        end
    
    end

elseif Client then

    local function UpdateAttackEffects(self, deltaTime)
    
        local intervall = self.confused == true and self.kConfusedAttackEffectInterval or self.kAttackEffectInterval

        if self.attacking and (self.timeLastAttackEffect + intervall < Shared.GetTime()) then
        
            if self.confused then
                self:TriggerEffects("sentry_single_attack")
            end
            
            -- plays muzzle flash and smoke
            self:TriggerEffects("sentry_attack")

            self.timeLastAttackEffect = Shared.GetTime()
            
        end
        
    end

    function Sentry:OnUpdate(deltaTime)
    
        ScriptActor.OnUpdate(self, deltaTime)
        
        if GetIsUnitActive(self) and self.deployed and self.attachedToBattery then
			
            local swingMult = 1.0

            -- Swing barrel yaw towards target
            if self.attacking then
            
                if self.targetDirection then
                
                    local invSentryCoords = self:GetAngles():GetCoords():GetInverse()
					
                    self.relativeTargetDirection = GetNormalizedVector( invSentryCoords:TransformVector( self.targetDirection ) )
					
					--This causes spinning at -270 to 90 degree transition...					
					--self.desiredYawDegrees = math.deg(math.atan2(self.relativeTargetDirection.z,self.relativeTargetDirection.x)) - 90 
										
					local x1 = self.relativeTargetDirectionOld.x
					local x2 = self.relativeTargetDirection.x
					local z1 = self.relativeTargetDirectionOld.z
					local z2 = self.relativeTargetDirection.z

					deltaAngle = math.deg(math.atan2(x1*z2 - z1*x2, x1*x2 + z1*z2))
					self.desiredYawDegrees = self.desiredYawDegreesOld + deltaAngle
					
                    self.desiredPitchDegrees = Clamp(math.asin(self.relativeTargetDirection.y) * 180 / math.pi, -self.kMaxPitch, self.kMaxPitch)
                    
                    swingMult = self.kBarrelMoveTargetMult
					
					self.desiredYawDegreesOld = self.desiredYawDegrees
					self.relativeTargetDirectionOld = self.relativeTargetDirection
                end
                
                UpdateAttackEffects(self, deltaTime)
                
            -- Else when we have no target, swing it back and forth looking for targets
            else
            
                local interval = self.kTargetScanDelay
                if (self.timeLastAttackEffect + interval < Shared.GetTime()) then
                    local sin = math.sin(math.rad((Shared.GetTime() + self:GetId() * .3) * Sentry.kBarrelScanRate))
                    self.desiredYawDegrees = self.desiredYawDegreesOld + sin * self:GetFov() / 2

                    -- Swing barrel pitch back to flat
                    self.desiredPitchDegrees = 0
                end
            end
            
            -- swing towards desired direction
            self.barrelPitchDegrees = Slerp(self.barrelPitchDegrees, self.desiredPitchDegrees, self.kBarrelMoveRate * swingMult * deltaTime)
            self.barrelYawDegrees = Slerp(self.barrelYawDegrees , self.desiredYawDegrees, self.kBarrelMoveRate * swingMult * deltaTime)
        
        end
    
    end

end

function GetCheckSentryLimit(techId, origin, normal, commander)

	local location = GetLocationForPoint(origin)
    local locationName = location and location:GetName() or nil

    -- Prevent the case where a Sentry in one room is being placed next to another one.
    local sentries = Shared.GetEntitiesWithClassname("Sentry")

	if sentries:GetSize() >= kSentryLimit then
		return false
	end
	
	for b = 0, sentries:GetSize() - 1 do
		
		local sentry = sentries:GetEntityAtIndex(b)
		
		if (sentry:GetOrigin() - origin):GetLength() < sentry.kBuildRange then
			return false
		end
				
		if sentry:GetLocationName() == locationName then
			return false
		end
		
	end
	return true        
end

function GetBatteryInRange(commander)

    local entities = { }
    local ranges = { }

    for _, battery in ipairs(GetEntitiesForTeam("SentryBattery", commander:GetTeamNumber())) do
        ranges[battery] = SentryBattery.kRange
        table.insert(entities, battery)
    end
    
    return entities, ranges
    
end

function Sentry:GetRequiresPower()
    return true
end

Shared.LinkClassToMap("Sentry", Sentry.kMapName, networkVars)
