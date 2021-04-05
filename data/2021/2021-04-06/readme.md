![Image of a forest being cleared, representing industrial deforestation](https://ucsdnews.ucsd.edu/news_uploads/deforestation-2.jpg)

# Deforestation

The data this week comes from [Our World in Data](https://ourworldindata.org/forests-and-deforestation).

Hannah Ritchie and Max Roser (2021) - "Forests and Deforestation". Published online at OurWorldInData.org. Retrieved from: 'https://ourworldindata.org/forests-and-deforestation' [Online Resource]

Additional article from [UCSD and](https://ucsdnews.ucsd.edu/feature/deforestation-drives-disease-climate-change-and-its-happening-at-a-rapid-rate) about deforestation and its effects on climate change and disease.

There are a few datasets:  

- [Deforestation](https://ourworldindata.org/deforestation)  
- [Share of forest area](https://ourworldindata.org/forest-area)  
- [Drivers of deforestation](https://ourworldindata.org/drivers-of-deforestation)  
- [Deforestation by commodity](https://ourworldindata.org/grapher/deforestation-by-commodity)  
-[Soybean production and use](https://ourworldindata.org/soy)  
-[Palm oil production](https://ourworldindata.org/palm-oil)  

Quotes below from the Our World in Data articles:

> The net change in forest cover measures any gains in forest cover – either through natural forest expansion or afforestation through tree-planting – minus deforestation.

> How much of the world’s land surface today is covered by forest?
> 
> In the visualization we see the breakdown of global land area.
> 
> 10% of the world is covered by glaciers, and a further 19% is barren land – deserts, dry salt flats, beaches, sand dunes, and exposed rocks. This leaves what we call ‘habitable land’. 
>
> Forests account for a little over one-third (38%) of habitable land area. This is around one-quarter (26%) of total (both habitable and uninhabitable) land area.
>
> This marks a significant change from the past: global forest area has reduced significantly due to the expansion of agriculture. Today half of global habitable land is used for farming. The area used for livestock farming in particular is equal in area to the world’s forests.

> Every year the world loses around 5 million hectares of forest. 95% of this occurs in the tropics. At least three-quarters of this is driven by agriculture – clearing forests to grow crops, raise livestock and produce products such as paper.1
> 
> If we want to tackle deforestation we need to understand two key questions: where we’re losing forests, and what activities are driving it. This allows us to target our efforts towards specific industries, products, or countries where they will have the greatest impact.

> More than three-quarters (77%) of global soy is fed to livestock for meat and dairy production. Most of the rest is used for biofuels, industry or vegetable oils. Just 7% of soy is used directly for human food products such as tofu, soy milk, edamame beans, and tempeh. The idea that foods often promoted as substitutes for meat and dairy – such as tofu and soy milk – are driving deforestation is a common misconception.
>
> In this article I address some key questions about palm oil production: how has it changed; where is it grown; and how this has affected deforestation and biodiversity. The story of palm oil is not as simple as it is often portrayed. Global demand for vegetable oils has increased rapidly over the last 50 years. Being the most productive oilcrop, palm has taken up a lot of this production. This has had a negative impact on the environment, particularly in Indonesia and Malaysia. But it’s not clear that the alternatives would have fared any better. In fact, because we can produce up to 20 times as much oil per hectare from palm versus the alternatives, it has probably spared a lot of environmental impacts from elsewhere.

### Get the data here

```{r}
# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-04-06')
tuesdata <- tidytuesdayR::tt_load(2021, week = 15)

forest_change <- tuesdata$forest_change

# Or read in the data manually

forest <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-06/forest.csv')
forest_area <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-06/forest_area.csv')
brazil_loss <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-06/brazil_loss.csv')
soybean_use <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-06/soybean_use.csv')
vegetable_oil <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-06/vegetable_oil.csv')

```
### Data Dictionary

# `forest.csv`

Change every 5 years for forest area in conversion.

|variable              |class     |description |
|:---------------------|:---------|:-----------|
|entity                |character | Country |
|code                  |character | Country code |
|year                  |double    | Year |
|net_forest_conversion |double    | Net forest conversion in hectares|

# `forest_area.csv`

Change in global forest area as a percent of global forest area.

|variable    |class     |description |
|:-----------|:---------|:-----------|
|entity      |character | Country|
|code        |character | Country Code |
|year        |integer   | Year |
|forest_area |double    | Percent of global forest area |

# `brazil_loss.csv`

Loss of Brazilian forest due to specific types.

|variable                        |class     |description |
|:-------------------------------|:---------|:-----------|
|entity                          |character | Country |
|code                            |character | Country code |
|year                            |double    | Year |
|commercial_crops                |double    | Commercial crops |
|flooding_due_to_dams            |double    | Flooding |
|natural_disturbances            |double    | Natural disturbances |
|pasture                         |double    | Pasture for livestock |
|selective_logging               |double    | Logging for lumber |
|fire                            |double    | Fire loss |
|mining                          |double    | Mining|
|other_infrastructure            |double    | Infrastructure |
|roads                           |double    | Roads |
|tree_plantations_including_palm |double    | Tree plantations |
|small_scale_clearing            |double    | Small scale clearing |

# `soybean_use.csv`

Soybean production and use by year and country.

|variable    |class     |description |
|:-----------|:---------|:-----------|
|entity      |character | Country|
|code        |character | Country Code |
|year        |double    | Year |
|human_food  |double    | Use for human food (tempeh, tofu, etc) |
|animal_feed |double    | Used for animal food |
|processed   |double    | Processed into vegetable oil, biofuel, processed animal feed |

# `vegetable_oil.csv`

Vegetable oil production by crop type and year.

|variable   |class     |description |
|:----------|:---------|:-----------|
|entity     |character | Country |
|code       |character | Country code |
|year       |double    | Year |
|crop_oil   |character | Crop that was used to produce vegetable oil |
|production |double    | Oil production in tonnes |

### Cleaning Script

Just renaming of columns this week.