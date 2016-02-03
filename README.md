# kikaha-cli
### Command line interface for Kikaha and Maven developers

[Kikaha](http://kikaha.skullabs.io) is a developer friendly micro-services middleware focused on hi-performance.
**Kikaha-cli** is a command line tool that automates most of hard work developers face on their daily routine.

## Available commands
Build commands:
- ```kikaha build [<module>]``` - builds a kikaha/maven project
- ```kikaha package [<module>]``` - generates a zip package with an executable kikaha project
- ```kikaha run_app [<module>]``` - run a kikaha project
- ```kikaha clean [<module>]``` - remove artifacts and stuffs generated by the lastests builds
- ```kikaha test [<module>]``` - forces to run all unit and integration tests

Repository commands:
- ```kikaha repo add <repo_name> <git_repository_url>``` - adds a plugin repository
- ```kikaha repo update <repo_name>``` - updates a plugin repository

## Environment Variables
Some special _environment variables_ chages the execution behavior of _kikaha-cli_.
- ```SKIPTESTS=true``` - avoids the unit and integration tests executions
- ```DEBUG=true``` - print some verbose information about _kikaha-cli_ execution. Useful for
    plugin development debugging.
- ```QUIET=true``` - print only useful and straighforward informations about the build. No logo
    and no debug information will be printed.

## Installation instructions
Download kikaha cli from your terminal.
```bash
curl -s http://skullabs.github.io/kikaha-cli/installer | bash
```
Please open a new terminal, or run the following in the existing one:
```bash
. ~/.bashrc
```
Run the setup.
```bash
kikaha setup
```
