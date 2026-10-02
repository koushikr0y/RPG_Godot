# RPG First Project

A 2D RPG prototype built with **Godot 4.7** featuring a finite state machine architecture for player controls, health/mana systems, experience/leveling, and directional animations.

## Features

- **Finite State Machine (FSM)** - Clean state management for player (Idle, Walk, Attack)
- **Player Controller** - WASD movement, Space to attack, 4-directional animations
- **Health & Mana System** - Reusable `HealthComponent` with damage/death events
- **Experience & Leveling** - XP gain, level-ups with stat points allocation
- **Event Bus** - Decoupled communication between systems
- **Mobile-ready** - Configured for mobile rendering (CanvasItems stretch mode)

## Project Structure

```
rpg-first-project/
├── project.godot              # Godot project config
├── icon.svg                   # App icon
├── .editorconfig              # Editor settings
├── Scripts/
│   ├── fsm.gd                 # Finite State Machine base class
│   └── state.gd               # State base class
├── scenes/
│   ├── player/
│   │   ├── player.tscn        # Player scene (CharacterBody2D)
│   │   ├── player.gd          # Player logic (stats, movement, FSM)
│   │   └── states/
│   │       ├── player_state.gd       # Base player state
│   │       ├── player_idle_state.gd  # Idle state
│   │       ├── player_walk_state.gd  # Walk state
│   │       └── player_attack_state.gd # Attack state
│   └── health_component/
│       ├── health_component.tscn
│       └── health_component.gd       # Reusable health/mana component
├── Sprites/
│   ├── Actor/
│   │   ├── Characters/        # Player sprites (Boy, Shadow)
│   │   └── Animals/           # Enemy/NPC sprites (Donkey, Horse, Chicken, Lion)
│   ├── Backgrounds/Vehicles/  # Environment props (Crane, Boat, Sail, FishNet)
│   └── Items/Weapons/         # Weapon sprites (Lance)
└── Audio/Jingles/             # SFX (LevelUp, Success, GameOver, Secret)
```

## Getting Started

### Prerequisites
- [Godot Engine 4.7+](https://godotengine.org/download)

### Installation
```bash
git clone <repository-url>
cd rpg-first-project
```

Open the project in Godot 4.7 and run the main scene (F5).

## Controls

| Action | Key |
|--------|-----|
| Move Up | W |
| Move Down | S |
| Move Left | A |
| Move Right | D |
| Attack | Space |

## Architecture

### FSM Pattern
- `FSM` node manages state transitions
- Each `State` has `enter_state()`, `exit_state()`, `process_state(delta)`
- States are child nodes of the FSM

### Player Stats
- Health / Mana (configurable max values)
- Move Speed
- Damage, Crit Chance, Crit Damage
- Experience system with exponential scaling

### Events (EventBus Autoload)
- `on_player_health_updated(curr, max)`
- `on_player_mana_updated(curr, max)`
- `on_player_new_level(curr_exp, next_level_exp)`
- `on_player_stats_updated()`

## Physics Layers
| Layer | Name |
|-------|------|
| 1 | World |
| 2 | Player |
| 3 | Enemy |

## License

MIT License - Feel free to use for learning or as a base for your own projects.