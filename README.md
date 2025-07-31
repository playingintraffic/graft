![pit_graft_thumb](https://github.com/user-attachments/assets/83551524-8d00-4f24-9590-bb0d9d38fd36)

# GRAFT - General Runtime Abstraction & Framework Toolkit

📚 **Full Docs:** [Documentation](https://playingintraffic.site/docs/graft)

💬 **Support:** [Discord](https://discord.gg/MUckUyS5Kq)

## What Is GRAFT?

> **Normally?** General Runtime Abstraction & Framework Toolkit  
> **When it works?** Greatly Reduces All Frustrating Tasks  
> **When it doesn't?** Goddamn Rage-Angering Frustrating Tool

GRAFT is the evolution of `boii_utils` rewritten, reorganized, and reimagined.  
A modular utility suite made to eliminate boilerplate, unify frameworks, and stay out of your way in the process.

Whether you're building standalone systems or cross-framework scripts, GRAFT does the hard work so you don't have too..

## Who's It For?

- Framework devs needing reusable base modules
- Script authors supporting multiple frameworks
- Solo scripters tired of rewriting the same junk
- Teams needing shared dev tools across resources

## Why Use GRAFT?

- **Unified Framework Bridge** - Supports ESX, QB, Ox, ND, QBox & more
- **Modular** - Load only what you need. Zero hard dependencies.
- **Reusable Patterns** - Handles the common logic so you don't have to
- **Consistent Structure** - Shared naming and layout across modules
- **Time-Saver** - Drop-in tools, clean wrappers, and sane defaults

## What's Inside?

### Bridges

- **Framework** - Abstracts player, job, metadata, and other core logic
- **Notifications** - Works with bduk, boii_ui, okok, ox_lib, etc.
- **DrawText UI** - Supports boii_ui, okok, esx, qb, and ox variations

### Standalone Systems

- **Callbacks** - Framework-free client/server promise callbacks
- **Commands** - With permissions, ACE support, and helpers
- **Licences** - Theory/practical tests, XP, revoking - DMV-style
- **XP System** - Trackable per-player XP with growth curves

### Utility Modules

- **Appearance** - Clothing, tattoos, shared ped styles
- **Vehicles** - Spawn, save, set properties safely
- **Items** - Usable item definitions outside any core
- **Methods** - Attach dynamic functions to players, vehicles, etc.
- **Player Helpers** - Animations, props, directions, more
- **Timestamps** - Consistent date/time across client/server
- **Environment** - Time, weather, season sync and detection
- **Entities** - NPC, vehicle, and object utility
- **Profanity** - Replace or block banned words cleanly
- **Buckets** - Easy routing bucket management + static data store

### Smart Libraries

- **Geometry** - Shapes, zones, distances, vectors, angles
- **Maths** - Curves, clamping, interpolation, rounding
- **Strings** - Slugify, wrap, pad, and format
- **Tables** - Merge, clone, scrub, sample, clean
- **Keys** - Named input constants with lookup helpers

## How's It Structured?

- **Bridge-Based** - Abstracted APIs across all major frameworks
- **Environment-Aware** - Auto-detects user environment
- **Drop-In Ready** - Use one module or all, no setup hell
- **Scalable** - Grow projects without growing clutter

Every module is **fully isolated**.
You can `graft.get("module")` and be ready to roll.

## Quick Install

1. **Download GRAFT**  
   [GitHub Releases](https://github.com/playingintraffic/graft/releases)

2. **Add to Resources**  
   Drop the folder into your server's resources directory

3. **Ensure It**  
   In `server.cfg`:  `ensure graft`

4. **SQL Setup**
   Run the included `REQUIRED.sql` to enable XP, licenses, and more

5. **Restart Server**
   Bridges will auto-detect your framework.
   Safe fallback mode if none detected.

## Support

Need help?
Ran into bugs?
Screaming at a missing comma?

[Join the PIT Discord](https://discord.gg/MUckUyS5Kq)

> **Support Hours:** Mon-Fri, 10AM-10PM GMT
> Outside hours? Sacrifice a chicken or leave a message.

## Warning

GRAFT will drastically reduce the amount of dumb code you write.
Side effects may include:

* Clean projects
* Faster development
* Uncomfortable productivity

Use responsibly.
