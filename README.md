### Ceci's Self Hosted Servers

This is a repository for deploying all of my self-hosted servers.

### Architecture

```
                    ┌─────────────── smp.cecilias.me ─────> [minecraft-smp     :25565]
((Internet)) ─> [Infrared :25565] ── atm.cecilias.me ─────> [minecraft-atm     :25565]
                    └─────────────── origins.cecilias.me ─> [minecraft-origins :25565]
```

**Infrared:** A reverse proxy server built specifically for minecraft. ([Link](https://github.com/haveachin/infrared))

### Resources

- [itzg/minecraft-server docs](https://github.com/itzg/docker-minecraft-server)