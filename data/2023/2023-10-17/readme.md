# Taylor Swift

Since [The Eras Tour Film](https://www.tstheerastourfilm.com/) was just released, this week we're exploring Taylor Swift song data! 

Are you Ready for It? 

The [taylor](https://taylor.wjakethompson.com/) R package from W. Jake Thompson is a curated data set of Taylor Swift songs, including lyrics and audio characteristics. 
The data comes from Genius and the Spotify API.

There are three main datasets.

> The first is taylor_album_songs, which includes lyrics and audio features from the Spotify API for all songs on Taylor’s official studio albums. Notably this excludes singles released separately from an album (e.g., Only the Young, Christmas Tree Farm, etc.), and non-Taylor-owned albums that have a Taylor-owned alternative (e.g., Fearless is excluded in favor of Fearless (Taylor’s Version)). We stan artists owning their own songs.

> You can access Taylor’s entire discography with taylor_all_songs. This includes all of the songs in taylor_album_songs plus EPs, individual singles, and the original versions of albums that have been re-released as Taylor’s Version.

> Finally, there is a small data set, taylor_albums, summarizing Taylor’s album release history.

Information on the audio features in the dataset from Spotify are included in their [API documentation](https://developer.spotify.com/documentation/web-api/reference/get-audio-features).

For your visualizations, the {taylor} package comes with it’s own class of color palettes, inspired by the work of Josiah Parry in the [{cpcinema}](https://github.com/JosiahParry/cpcinema) package.

You might also be interested in the [tayoRswift package](https://asteves.github.io/tayloRswift/) by Alex Stephenson, a ggplot2 color palette based on Taylor Swift album covers. "For when your colors absolutely should not be excluded from the narrative."



## The Data

```{r}
# Option 1: tidytuesdayR package 
## install.packages("tidytuesdayR")

tuesdata <- tidytuesdayR::tt_load('2023-10-17')
## OR
tuesdata <- tidytuesdayR::tt_load(2023, week = 42)

taylor_album_songs <- tuesdata$taylor_album_songs
taylor_all_songs <- tuesdata$taylor_all_songs
taylor_albums <- tuesdata$taylor_albums

# Option 2: Read directly from GitHub

taylor_album_songs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-17/taylor_album_songs.csv')
taylor_all_songs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-17/taylor_all_songs.csv')
taylor_albums <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-17/taylor_albums.csv')

```

## How to Participate

- [Explore the data](https://r4ds.hadley.nz/), watching out for interesting relationships. We would like to emphasize that you should not draw conclusions about **causation** in the data. There are various moderating variables that affect all data, many of which might not have been captured in these datasets. As such, our suggestion is to use the data provided to practice your data tidying and plotting techniques, and to consider for yourself what nuances might underlie these relationships.
- Create a visualization, a model, a [shiny app](https://shiny.posit.co/), or some other piece of data-science-related output, using R or another programming language.
- [Share your output and the code used to generate it](../../../sharing.md) on social media with the #TidyTuesday hashtag.


### Data Dictionary

# `taylor_album_songs.csv`

|variable            |class     |description         |
|:-------------------|:---------|:-------------------|
|album_name          |character |Album name         |
|ep                  |logical   |Is it an EP                  |
|album_release       |double    |Album release date       |
|track_number        |integer   |Track number        |
|track_name          |character |Track name          |
|artist              |character |Artists             |
|featuring           |character |Artists featured           |
|bonus_track         |logical   |Is it a bonus track         |
|promotional_release |double    |Date of promotional release |
|single_release      |double    |Date of single release      |
|track_release       |double    |Date of track release       |
|danceability        |double    |Spotify danceability score. A value of 0.0 is least danceable and 1.0 is most danceable.        |
|energy              |double    |Spotify energy score. Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity.        |
|key                 |integer   |The key the track is in.                 |
|loudness            |double    |Spotify loudness score. The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track.        |
|mode                |integer   |Mode indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived. Major is represented by 1 and minor is 0.               |
|speechiness         |double    |Spotify speechiness score. Speechiness detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value.          |
|acousticness        |double    |Spotify acousticness score. A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic.        |
|instrumentalness    |double    |Spotify instrumentalness score. Predicts whether a track contains no vocals. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0.   |
|liveness            |double    |Spotify liveness score. Detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live.            |
|valence             |double    |Spotify valence score. A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry).             |
|tempo               |double    |The overall estimated tempo of a track in beats per minute (BPM). In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration.          |
|time_signature      |integer   |An estimated time signature. The time signature (meter) is a notational convention to specify how many beats are in each bar (or measure). The time signature ranges from 3 to 7 indicating time signatures of "3/4", to "7/4".     |
|duration_ms         |integer   |The duration of the track in milliseconds.       |
|explicit            |logical   |Does the track have explicit lyrics.           |
|key_name            |character |The key the track is in. Integers map to pitches using standard Pitch Class notation. E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on. If no key was detected, the value is -1.         |
|mode_name           |character |Modality of the track.           |
|key_mode            |character |The key of the track.       |
|lyrics              |list      |Track lyrics.       |

# `taylor_all_songs.csv`

|variable            |class     |description         |
|:-------------------|:---------|:-------------------|
|album_name          |character |Album name         |
|ep                  |logical   |Is it an EP                  |
|album_release       |double    |Album release date       |
|track_number        |integer   |Track number        |
|track_name          |character |Track name          |
|artist              |character |Artists             |
|featuring           |character |Artists featured           |
|bonus_track         |logical   |Is it a bonus track         |
|promotional_release |double    |Date of promotional release |
|single_release      |double    |Date of single release      |
|track_release       |double    |Date of track release       |
|danceability        |double    |Spotify danceability score. A value of 0.0 is least danceable and 1.0 is most danceable.        |
|energy              |double    |Spotify energy score. Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity.        |
|key                 |integer   |The key the track is in.                 |
|loudness            |double    |Spotify loudness score. The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track.        |
|mode                |integer   |Mode indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived. Major is represented by 1 and minor is 0.               |
|speechiness         |double    |Spotify speechiness score. Speechiness detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value.          |
|acousticness        |double    |Spotify acousticness score. A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic.        |
|instrumentalness    |double    |Spotify instrumentalness score. Predicts whether a track contains no vocals. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0.   |
|liveness            |double    |Spotify liveness score. Detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live.            |
|valence             |double    |Spotify valence score. A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry).             |
|tempo               |double    |The overall estimated tempo of a track in beats per minute (BPM). In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration.          |
|time_signature      |integer   |An estimated time signature. The time signature (meter) is a notational convention to specify how many beats are in each bar (or measure). The time signature ranges from 3 to 7 indicating time signatures of "3/4", to "7/4".     |
|duration_ms         |integer   |The duration of the track in milliseconds.       |
|explicit            |logical   |Does the track have explicit lyrics.           |
|key_name            |character |The key the track is in. Integers map to pitches using standard Pitch Class notation. E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on. If no key was detected, the value is -1.         |
|mode_name           |character |Modality of the track.           |
|key_mode            |character |The key of the track.       |
|lyrics              |list      |Track lyrics.       |

# `taylor_albums.csv`

|variable         |class     |description      |
|:----------------|:---------|:----------------|
|album_name       |character |Album name      |
|ep               |logical   |Is it an EP       |
|album_release    |double    |Album release date    |
|metacritic_score |integer   |Metacritic score |
|user_score       |double    |User score       |

### Cleaning Script

``` r
library(tidyverse)
library(taylor)

write_csv(taylor_album_songs, "taylor_album_songs.csv")
write_csv(taylor_all_songs, "taylor_all_songs.csv")
write_csv(taylor_albums, "taylor_albums.csv")


```
