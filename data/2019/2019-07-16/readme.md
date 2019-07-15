# R for Data Science Online Learning Community Stats

In honor of the R4DS Online Learning Community team's recent [presentation at useR-2019](https://t.co/wNexiphbr5), here are the stats for the R4DS community from it's founding through the start of July. No user names or user information is included - it is aggregated by date.

See Jesse's talk about founding this community [here](https://resources.rstudio.com/rstudio-conf-2019/r4ds-online-learning-community-improvements-to-self-taught-data-science-and-the-critical-need-for-diversity-equity-and-inclusion-in-data-science-education). 

Join us on Slack [here](https://join.slack.com/t/rfordatascience/shared_invite/enQtMzA1Nzk1MjIzNDczLTY0OTVlMzM3ZTU5ZjA3NWE5ZDkxOGVmNjRjODQ2YmRjMzg4NWQxMDAxZTcwNzViZTczOThiNzBhYWJhZDM2ZTU) or check out our [website](https://www.rfordatasci.com/).

# Get the data!

```
r4ds_members <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-07-16/r4ds_members.csv")

```

# Data Dictionary

### `r4ds_members.csv`

|variable                             |class  |description |
|:------------------------------------|:------|:-----------|
|date                                 | date | date |
|total_membership                     |double | total Members |
|full_members                         |double | Full members |
|guests                               |double |  Guests |
|daily_active_members                 |double | Daily active members |
|daily_members_posting_messages       |double | Daily members posting messages |
|weekly_active_members                |double | Weekly active members |
|weekly_members_posting_messages      |double | Weekly members posting messages |
|messages_in_public_channels          |double | Messages in public channels |
|messages_in_private_channels         |double | Messages in private channels |
|messages_in_shared_channels          |double | Messages in shared channels |
|messages_in_d_ms                     |double | messages in Direct Messages |
|percent_of_messages_public_channels  |double | percent of messages in public channels |
|percent_of_messages_private_channels |double | percent of messages in private channels |
|percent_of_messages_d_ms             |double | percent of messages in Direct Messages |
|percent_of_views_public_channels     |double | Percent of Views public channels |
|percent_of_views_private_channels    |double | Percent of views private channels |
|percent_of_views_d_ms                |double | Percent of Views DMs |
|name                                 |double | Redacted |
|public_channels_single_workspace     |double | Public channels single workspace |
|messages_posted                      |double | Messages posted |


