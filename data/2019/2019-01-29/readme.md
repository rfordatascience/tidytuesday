# Datasets

[milkcow_facts.csv](milkcow_facts.csv)  
[milk_facts.csv](milk_facts.csv)  
[milk_products_facts.csv](milk_products_facts.csv)  
[clean_cheese.csv](clean_cheese.csv)  
[state_milk_production.csv](state_milk_production.csv)  

Data this week comes from the USDA (United States Department of Agriculture)! The raw datasets (Excel Sheets) can be found [here](https://www.ers.usda.gov/data-products/dairy-data/documentation/#Loc3). There is even more data at the source if you are interested, much of which requires a LOT of `fun` Excel sheet data munging. Enjoy!


A related NPR article - ["Nobody is Moving our Cheese"](https://www.npr.org/2019/01/09/683339929/nobody-is-moving-our-cheese-american-surplus-reaches-record-high) and Washington Post article - ["America's Cheese Stockpile hit an alltime high""](https://www.washingtonpost.com/news/wonk/wp/2018/06/28/americas-cheese-stockpile-just-hit-an-all-time-high/?noredirect=on&utm_term=.e9b90767af27). 

This week's data was found via the [Data is Plural](https://tinyletter.com/data-is-plural) newsletter.

# Data Dictionary

* milkcow_facts.csv
* fluid_milk_sales.csv
* milk_products_facts.csv
* clean_cheese.csv
* state_milk_production.csv

The "tame" datasets seen here might require a few `gather` calls, while some are already pretty tidy. Fluid milk sales, milkcow facts, and state milk production are good ones if you just want to plot, while the milk products and clean cheese allow for some creativity in the data organization steps. 

## milkcow_facts

|variable                      |class  | Description |
|:-----|:---| :--------- |
|year                          |date | Year |
|avg_milk_cow_number           |double | Average number of milk cows |
|milk_per_cow                  |double | Average milk production/cow in pounds |
|milk_production_lbs           |double | Total Milk production in pounds |
|avg_price_milk                |double | Average price paid for milk (dollars per pound) |
|dairy_ration                  |double | Average price paid for dairy cow rations (dollars per pound) |
|milk_feed_price_ratio         |double | Ratio of average price of milk per dairy cow ration |
|milk_cow_cost_per_animal      |double | Average cost of milk cow per animal (dollars) |
|milk_volume_to_buy_cow_in_lbs |double | Milk volume required to purchase a cow (pounds) |
|alfalfa_hay_price             |double | Alfalfa hay price received by farmers (tons)  |
|slaughter_cow_price           |double | Slaughter cow price (value of meat in dollars per pound)  |

## fluid_milk_sales

|variable  |class   |description |
|:----|:---|:-----------|
|year      |date  | Year  |
|milk_type |integer | Category of Milk product|
|pounds    |double  | Pounds of milk product per year |

## milk_products_facts

|variable                        |class   |description                   |
|:-----------|:---|:-----------------------------|
|year                            |date |Year |
|fluid_milk                      |double  |Average milk consumption in lbs per person |
|fluid_yogurt                    |double  |Average yogurt consumption in lbs per person |
|butter                          |double  |Average butter consumption in lbs per person |
|cheese_american                 |double  | Average American cheese consumption in lbs per person |
|cheese_other                    |double  | Average other cheese consumption in lbs per person |
|cheese_cottage                  |double  | Average cottage cheese consumption in lbs per person |
|evap_cnd_canned_whole_milk      |double  | Average evaporated and canned whole milk consumption in lbs per person |
|evap_cnd_bulk_whole_milk        |double  | Average evaporated and canned bulk whole milk consumption in lbs per person |
|evap_cnd_bulk_and_can_skim_milk |double  | Average evaporated and canned bulk and can skim milk consumption in lbs per person |
|frozen_ice_cream_regular        |double  | Average regular frozen ice cream consumption in lbs per person |
|frozen_ice_cream_reduced_fat    |double  | Average reducated fat frozen ice cream consumption in lbs per person |
|frozen_sherbet                  |double  | Average frozen sherbet consumption in lbs per person |
|frozen_other                    |double  | Average other frozen milk product consumption in lbs per person |
|dry_whole_milk                  |double  | Average dry whole milk consumption in lbs per person |
|dry_nonfat_milk                 |double  | Average dry nonfat milk consumption in lbs per person |
|dry_buttermilk                  |double  | Average dry buttermilk consumption in lbs per person |
|dry_whey                        |double  | Average dry whey (milk protein) consumption in lbs per person |

## clean_cheese

|variable                        |class   |description                                                   |
|:-------------------------------|:-------|:-------------------------------------------------------------|
|Year                            |date |Year                            |
|Cheddar                         |double  |Cheddar consumption in lbs per person                         |
|American Other                  |double  |American Other consumption in lbs per person                  |
|Mozzarella                      |double  |Mozzarella consumption in lbs per person                      |
|Italian other                   |double  |Italian other consumption in lbs per person                   |
|Swiss                           |double  |Swiss consumption in lbs per person                           |
|Brick                           |double  |Brick consumption in lbs per person                           |
|Muenster                        |double  |Muenster consumption in lbs per person                        |
|Cream and Neufchatel            |double  |Cream and Neufchatel consumption in lbs per person            |
|Blue                            |double  |Blue consumption in lbs per person                            |
|Other Dairy Cheese              |double  |Other Dairy Cheese consumption in lbs per person              |
|Processed Cheese                |double  |Processed Cheese consumption in lbs per person                |
|Foods and spreads               |double  |Foods and spreads consumption in lbs per person               |
|Total American Chese            |double  |Total American Chese consumption in lbs per person            |
|Total Italian Cheese            |double  |Total Italian Cheese consumption in lbs per person            |
|Total Natural Cheese            |double  |Total Natural Cheese consumption in lbs per person            |
|Total Processed Cheese Products |double  |Total Processed Cheese Products consumption in lbs per person |

## state_milk_production

|variable      |class     |description |
|:-------------|:---------|:-----------|
|region        |character |  Region of the US          |
|state         |character |     US State       |
|year          |date    |    Year        |
|milk_produced |double    |  Pounds of Milk Produced      |
