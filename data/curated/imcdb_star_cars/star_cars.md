|variable       |class     |description                           |
|:--------------|:---------|:-------------------------------------|
|make           |character |Make of the vehicle, e.g. `Ford`. Vehicles built specially for a production are listed under the pseudo-makes `Made for Movie` and `Custom Made`, and unidentified vehicles under `unknown`. |
|model          |character |Model of the vehicle, e.g. `Mustang`. `NA` when the vehicle is only identified by its make. |
|vehicle_year   |integer   |Model year of the vehicle, when known. |
|chassis        |character |Chassis or generation code of the vehicle, e.g. `NA1` for the 1991 Acura NSX. |
|extra          |character |Extra note attached to the vehicle name on IMCDb, such as a trim level, coachbuilder, or the vehicle's name in the production, e.g. `'Klingeling'`. |
|vehicle_class  |character |Body class of the vehicle, e.g. `Sedan`, `Coupé`, `Moped`, `Double-deck`. |
|origin_country |character |Country of origin of the model, e.g. `Germany` for the Volkswagen up!. |
|built_in       |character |Country where the vehicle was built, when different from the model's origin, e.g. `Slovakia` for the Volkswagen up!. |
|made_for       |character |Market the vehicle version was made for, when noted, e.g. the Acura NSX is the version of the Honda NSX made for the `United States of America`. |
|movie_title    |character |Title of the movie or show the vehicle appears in, in its original language. |
|movie_type     |character |Type of production: `Movie`, `TV Series`, `Short Movie`, `Movie made for TV`, `Music Video`, `Documentary`, `Animation Series`, `Mini-Series`, `Non-fiction TV`, or `Animation Movie`. |
|movie_year     |integer   |Release year of the movie, or first year of the series. |
|movie_year_end |integer   |Final year of a series. `NA` for single releases and for series still running. |
|vehicle_url    |character |URL of the vehicle's IMCDb page, with screen captures and comments. |
|movie_url      |character |URL of the IMCDb page of the movie or show, listing all vehicles that appear in it. |
