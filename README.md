# Zombie Biome Simulator

## Description
This project is a Lua  LÖVE based post-apocalyptic ecosystem simulator, featuring interactions between zombies, survivors, and resources.
It offers a grid-based simulation with a visual representation in a LÖVE window.

## Features
- Simulation of a world populated by zombies and survivors
- Random generation of resources
- Basic behaviors for zombies (hunting) and survivors (fleeing and resource collection)
- Health and hunger system for entities


## Prerequisites
- LÖVE 11.3 or higher

## Installation
1. Clone this repository:
   ```
   git clone https://github.com/nebul/zombie-biome.git
   ```
2. Navigate to the project folder:
   ```
   cd zombie-biome
   ```

## Usage

To start the simulation, you can use one of the following methods:

### Using Run Scripts

We've provided convenient scripts to run the simulation:

- On Windows:
  Double-click the `run.bat` file or run it from the command prompt:
   ```
      run.bat
   ```

- On Unix-based systems (Linux, macOS):
  Make the script executable and run it:
   ```
   chmod +x run.sh
   ./run.sh
   ```

These scripts will check if LÖVE is installed on your system and launch the game. If LÖVE is not found, they will provide instructions on how to install it.

### Manual Execution

Alternatively, if you have LÖVE installed and added to your system PATH, you can run the game directly using:

```
love .
```

Execute this command in the root directory of the project.

Note: If you encounter any issues with the scripts, ensure that LÖVE is properly installed on your system and that the scripts have the necessary permissions to execute.

## Configuration
You can adjust the simulation parameters by modifying the `src/config/Config.lua` file. Here are some available parameters:

- `GRID_WIDTH` and `GRID_HEIGHT`: Grid dimensions
- `INITIAL_ZOMBIES` and `INITIAL_SURVIVORS`: Initial number of zombies and survivors
- `ZOMBIE_SPEED` and `SURVIVOR_SPEED`: Movement speed of zombies and survivors
- `INFECTION_CHANCE`: Probability of a survivor being infected during an encounter with a zombie
- `RESOURCE_SPAWN_RATE`: Resource spawn rate

## How It Works
- Zombies hunt the nearest survivors.
- Survivors flee from zombies and search for resources.
- Resources appear randomly on the grid.
- Entities have a health and hunger system.
- Conflicts (encounters between zombies and survivors) are resolved each turn.

## License
This project is licensed under the Apache License 2.0. See the LICENSE file for details.