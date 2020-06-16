# Nuclear Explosions

This week's [**data**](nuclear_explosions.csv) is from [Stockholm International Peace Research Institute](https://github.com/data-is-plural/nuclear-explosions/blob/master/documents/sipri-report-original.pdf), by way of [data is plural](https://github.com/data-is-plural/nuclear-explosions) with credit to [Jesus Castagnetto](https://github.com/rfordatascience/tidytuesday/issues/91) for sharing the dataset.

Additional information can be found on [Wikipedia](https://en.wikipedia.org/wiki/List_of_nuclear_weapons_tests) or via the original report [PDF](https://github.com/data-is-plural/nuclear-explosions/blob/master/documents/sipri-report-original.pdf).

Additional related datasets can be found at [Our World in Data](https://ourworldindata.org/nuclear-weapons).

For details around units for yield/magnitude, please see the [Nuclear Yield](https://seismo.berkeley.edu/~rallen/research/nuke/yield.html) formulas.


# Get the data!

```
nuclear_explosions <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-08-20/nuclear_explosions.csv")

```

# Data Dictionary

## `nuclear_explosions.csv`

|variable          |class     |description |
|:--- |:--- |:-----------|
|date_long         |date    | ymd date|
|year              |double    | year of explosion |
|id_no             |double    | unique ID |
|country   |character | Country deploying the nuclear device |
|region    |character | Region where nuclear device was deployed |
|source    |character | Source the reported the explosion event |
|latitude  |double    | Latitude position |
|longitude |double    | Longitude position |
|magnitude_body    |double    | Body wave magnitude of explosion (mb)|
|magnitude_surface |double    | Surface wave magnitude of explosion (Ms) |
|depth             |double    | Depth at detonation in Km (could be underground or above ground) -- please note that positive = depth (below ground), while negative = height (above ground) |
|yield_lower       |double    | Explosion yield lower estimate in kilotons of TNT |
|yield_upper       |double    | Explosion yield upper estimate in kilotons of TNT |
|purpose           |character | Purpose of detonation: COMBAT (WWII bombs dropped over Japan), FMS (Soviet test, study phenomenon of nuclear explosion), ME (Military Exercise), PNE (Peaceful nuclear explosion), SAM (Soviet test, accidental mode/emergency), SSE (French/US tests - testing safety of nuclear weapons in case of accident), TRANSP (Transportation-storage purposes), WE (British, French, US, evaluate effects of nuclear detonation on various targets), WR (Weapons development program) |
|name              |character | Name of event or bomb |
|type              |character | type - method of deployment -- ATMOSPH (Atmospheric), UG (underground), BALLOON (Balloon drop), AIRDROP (Airplane deployed), ROCKET (Rocket deployed), TOWER (deplyed at top of constructed tower), WATERSURFACE (on surface of body of water), BARGE (on barge boat), SURFACE (on surface or in shallow crater), UW (Underwater), SHAFT (Vertical Shaft underground), TUNNEL/GALLERY (Horizontal tunnel) |
