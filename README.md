# eqemu-quests-docker
A Docker container containing a snapshot checkout of PEQ quests. To run as a sidekick with eqemu-server-docker.

Quests are located at /home/eqemu/quests within the container. Mount this as a volume into /home/eqemu/quests in the eqemu-server-container.

This container's ENTRYPOINT is set to /bin/true, so it will simply exit once run. It exists only to provide its volume, as any sidekick container does.
