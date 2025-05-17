#  RPG Maker VX Ace - Step Sounds Script
# Script creation by CrypticTM / Tristan

A lightweight and flexible step sound system for **RPG Maker VX Ace**, allowing mappers and developers to assign walking sound effects based on **Region IDs** or **map-wide overrides**.
This script is compatible with Yanfly's engine scripts

---

## 📦 Features

- 🎯 Region-based walking sounds (e.g., grass, stone, wood)
- 🌍 Map-specific override support
- 🎵 Customizable step sound volume/pitch
- 🧩 Fully compatible with **Yanfly Engine Ace**
- 🌀 Cooldown prevents overlapping sounds

---

## 🛠️ Installation

1. Open your **Script Editor** in RPG Maker VX Ace.
2. Paste the script `Step_Sounds.rb` **below Yanfly scripts** (if used) and **above Main**.
3. Add your walking sound effects (e.g., `Walk_Grass.ogg`) into the `Audio/SE/` folder.
4. Configure region and map settings in the `StepSoundsConfig` module at the top of the script.

---

## ⚙️ Configuration

```ruby
DEFAULT_SOUND = "Walk_Grass"

REGION_SOUNDS = {
  1 => "Walk_Grass",
  2 => "Walk_Wood",
  3 => "Walk_Stone",
  4 => "Walk_Sand",
  5 => "Walk_Metal"
}

MAP_SOUNDS = {
  3 => "Walk_Water"
}

STEP_SE = RPG::SE.new("", 80, 100)  # default volume/pitch
STEP_COOLDOWN = 10  # delay between step sounds in frames
