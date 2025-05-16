# Welcome
To get started setup a NixOS system with the username and hostname and run `./switch.sh`.
Note that I built this with the intention that I will be the only one using it. If you want to use some parts of it, feel free to copy. 

# Prerequisites
- Computer that matches the hostname and has NixOS already installed.
    - Prevalance: ideapad
    - Malevolence: alienware
    - Nighthound: AMD desktop
    - NewMoon: Virtual Machine
    - Vantage: x220 thinkpad
- A user named 'alxjron' with a password already set.

# Scripts
`./switch.sh` Runs a full switch taking in the username and the hostname of the current system.  
`./home-switch.sh` Same as switch but only runs the home-manager part.  
`./clean.sh` To clean the garbage that Nix tends to leave out.
