#==============================================================================
# ▼ Step Sounds System (VX Ace)
# Author: CrypticTM
# Version: 1.0
# Compatibility: Yanfly Engine Ace Core, Region Events
#------------------------------------------------------------------------------
# Adds footstep sounds based on Region IDs or full map overrides.
# Supports volume/pitch config and step delay.
#==============================================================================

module StepSoundsConfig
  # Default step sound if no region or map override applies
  DEFAULT_SOUND = "Walk_Grass"

  # Region ID to step sound mapping
  REGION_SOUNDS = {
    1 => "Walk_Grass",
    2 => "Walk_Wood",
    3 => "Walk_Stone",
    4 => "Walk_Sand",
    5 => "Walk_Metal"
  }

  # Map ID override for full-map sounds
  MAP_SOUNDS = {
    3 => "Walk_Water"  # Entire map 3 uses this sound
  }

  # Default step sound object; name is replaced dynamically
  STEP_SE = RPG::SE.new("", 80, 100)  # name, volume, pitch

  # Delay between footstep sounds (in frames)
  STEP_COOLDOWN = 10
end

class Game_Player < Game_Character
  alias stepsound_update_move update_move
  def update_move
    stepsound_update_move
    update_step_sound if moving? && @real_x % 32 == 0 && @real_y % 32 == 0
  end

  def update_step_sound
    @step_sound_cooldown ||= 0
    return if @step_sound_cooldown > 0
    @step_sound_cooldown = StepSoundsConfig::STEP_COOLDOWN

    sound = determine_step_sound
    play_step_sound(sound)
  end

  def determine_step_sound
    map_id = $game_map.map_id
    return StepSoundsConfig::MAP_SOUNDS[map_id] if StepSoundsConfig::MAP_SOUNDS.key?(map_id)

    region_id = $game_map.region_id(@x, @y)
    return StepSoundsConfig::REGION_SOUNDS[region_id] if StepSoundsConfig::REGION_SOUNDS.key?(region_id)

    StepSoundsConfig::DEFAULT_SOUND
  end

  def play_step_sound(sound_name)
    sound = StepSoundsConfig::STEP_SE.clone
    sound.name = sound_name
    sound.play
  end

  alias step_sounds_update_nonmoving update_nonmoving
  def update_nonmoving(last_moving)
    step_sounds_update_nonmoving(last_moving)
    @step_sound_cooldown = [@step_sound_cooldown - 1, 0].max if @step_sound_cooldown
  end
end
