AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "'PeaceKeeper' SMG"
	SWEP.Description = "'this weapon can fire 3 bullets per 1 ammo used."
	SWEP.Slot = 3
	SWEP.SlotPos = 0

	SWEP.HUD3DBone = "v_weapon.sg552_Parent"
	SWEP.HUD3DPos = Vector(-1, -6.5, -3)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.0225

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_sg552.mdl"
SWEP.WorldModel = "models/weapons/w_rif_sg552.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = true

SWEP.ReloadSound = Sound("Weapon_SG552.Reload")
SWEP.Primary.Sound = Sound("Weapon_FAMAS.Single")
SWEP.Primary.Damage = 22
SWEP.Primary.NumShots = 3
SWEP.Primary.Delay = 0.11

SWEP.Primary.ClipSize = 25
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.ConeMax = 0.049
SWEP.ConeMin = 0.020

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.IronSightsPos = Vector(7.25, -8, 2.52)
SWEP.IronSightsAng = Vector(0, 0, 0)

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end

if CLIENT then
	SWEP.IronsightsMultiplier = 0.25

	function SWEP:GetViewModelPosition(pos, ang)
		if self:IsScoped() then
			return pos + ang:Up() * 256, ang
		end

		return self.BaseClass.GetViewModelPosition(self, pos, ang)
	end

	local matScope = Material("zombiesurvival/scope")
	function SWEP:DrawHUDBackground()
		if self:IsScoped() then
			local scrw, scrh = ScrW(), ScrH()
			local size = math.min(scrw, scrh)
			surface.SetMaterial(matScope)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect((scrw - size) * 0.5, (scrh - size) * 0.5, size, size)
			surface.SetDrawColor(0, 0, 0, 255)
			if scrw > size then
				local extra = (scrw - size) * 0.5
				surface.DrawRect(0, 0, extra, scrh)
				surface.DrawRect(scrw - extra, 0, extra, scrh)
			end
			if scrh > size then
				local extra = (scrh - size) * 0.5
				surface.DrawRect(0, 0, scrw, extra)
				surface.DrawRect(0, scrh - extra, scrw, extra)
			end
		end
	end
end

