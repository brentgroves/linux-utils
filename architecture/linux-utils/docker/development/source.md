https://github.com/docker/docker-ce
Docker CE
warning This repository is now deprecated and will be archived (Docker CE itself is NOT deprecated) warning

Starting with the Docker 20.10 release, packages for the Docker Engine and Docker CLI are built directly from their respective source repositories instead of from this repository.

Practically this means:

This repository is no longer the “source of truth” for Docker CE builds.
The commit SHA and tag for Docker CLI build will come from the docker/cli repository and the commit SHA and tag for the Docker Engine will come from the moby/moby repository.
Release branches for the Engine, CLI, and packaging will be maintained on their respective repositories.
Updates will stop being made to this repository and it will be archived in the future.
Changelog is now Release Notes.
The master branch of this repository will be emptied when the repository is archived.
https://github.com/moby/moby
https://github.com/docker/cli