# `#rstats` and `#TidyTuesday` Tweets from `rtweet`

Data for this week comes from [Mike Kearney](https://twitter.com/kearneymw) - author of the awesome [`rtweet` package](https://rtweet.info/), as well as several other [packages](https://github.com/mkearney)!

## Datasets

[`#rstats`](https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-01-01/rstats_tweets.rds)  
[`#TidyTuesday`](https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-01-01/tidytuesday_tweets.rds)

Just a heads up, there are A LOT of columns (88!) in this collection - feel free to select whichever are useful for your analysis or interest! Both datasets have the same column types which can be seen below.

|variable                |class     |
|:-----------------------|:---------|
|user_id                 |character |
|status_id               |character |
|created_at              |double    |
|screen_name             |character |
|text                    |character |
|source                  |character |
|display_text_width      |double    |
|reply_to_status_id      |character |
|reply_to_user_id        |character |
|reply_to_screen_name    |character |
|is_quote                |logical   |
|is_retweet              |logical   |
|favorite_count          |integer   |
|retweet_count           |integer   |
|hashtags                |list      |
|symbols                 |list      |
|urls_url                |list      |
|urls_t.co               |list      |
|urls_expanded_url       |list      |
|media_url               |list      |
|media_t.co              |list      |
|media_expanded_url      |list      |
|media_type              |list      |
|ext_media_url           |list      |
|ext_media_t.co          |list      |
|ext_media_expanded_url  |list      |
|ext_media_type          |character |
|mentions_user_id        |list      |
|mentions_screen_name    |list      |
|lang                    |character |
|quoted_status_id        |character |
|quoted_text             |character |
|quoted_created_at       |double    |
|quoted_source           |character |
|quoted_favorite_count   |integer   |
|quoted_retweet_count    |integer   |
|quoted_user_id          |character |
|quoted_screen_name      |character |
|quoted_name             |character |
|quoted_followers_count  |integer   |
|quoted_friends_count    |integer   |
|quoted_statuses_count   |integer   |
|quoted_location         |character |
|quoted_description      |character |
|quoted_verified         |logical   |
|retweet_status_id       |character |
|retweet_text            |character |
|retweet_created_at      |double    |
|retweet_source          |character |
|retweet_favorite_count  |integer   |
|retweet_retweet_count   |integer   |
|retweet_user_id         |character |
|retweet_screen_name     |character |
|retweet_name            |character |
|retweet_followers_count |integer   |
|retweet_friends_count   |integer   |
|retweet_statuses_count  |integer   |
|retweet_location        |character |
|retweet_description     |character |
|retweet_verified        |logical   |
|place_url               |character |
|place_name              |character |
|place_full_name         |character |
|place_type              |character |
|country                 |character |
|country_code            |character |
|geo_coords              |list      |
|coords_coords           |list      |
|bbox_coords             |list      |
|status_url              |character |
|name                    |character |
|location                |character |
|description             |character |
|url                     |character |
|protected               |logical   |
|followers_count         |integer   |
|friends_count           |integer   |
|listed_count            |integer   |
|statuses_count          |integer   |
|favourites_count        |integer   |
|account_created_at      |double    |
|verified                |logical   |
|profile_url             |character |
|profile_expanded_url    |character |
|account_lang            |character |
|profile_banner_url      |character |
|profile_background_url  |character |
|profile_image_url       |character |