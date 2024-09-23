|variable             |class     |description                           |
|:--------------------|:---------|:-------------------------------------|
|ParkCode             |character |National Park Code. |
|ParkName             |character |National Park Full Name. |
|CategoryName         |character |Species Category. |
|Order                |character |Species Order. |
|Family               |character |Species Family. |
|TaxonRecordStatus    |character |whether or not the taxon is active. |
|SciName              |character |scientific name for the species. |
|CommonNames          |character |common name of the species. |
|Synonyms             |list      |other names the species may go by. |
|ParkAccepted         |logical   |whether or not the park accepts this species. |
|Sensitive            |logical   |whether or not the species is 'sensitive'. |
|RecordStatus         |character |whether or not nps approved the species. |
|Occurrence           |character |The current status of existence or presence of each species in each park. Applicable only to scientific names with Park Accepted Status of "Accepted". Possible values reflect a combination of confidence, and availability and currency of verifiable evidence. |
|OccurrenceTags       |character | additional sighting informational tag. |
|Nativeness           |character | whether or not the species is native. |
|NativenessTags       |character | additional native informational tag. |
|Abundance            |character | how abundant is the species in the park. |
|NPSTags              |character | NPSpecies system-wide attributes and tags are standard categories and designations that apply across all parks and species. |
|ParkTags             |character | parks can create their own custom attributes, called “park tags,” and apply them to their park species records. For example, perhaps a park wants to set up a list of spring wildflowers, or identify the park subunits in which species occur. |
|References           |integer   | four columns that display the number of associated evidence records that substantiate the status of the species in the park: Observations, Vouchers, References, and External Links. A document, publication, article, database, or other information resource that contains information on one or more park species. |
|Observations         |integer   | four columns that display the number of associated evidence records that substantiate the status of the species in the park: Observations, Vouchers, References, and External Links. An observation is subjective evidence (no physical proof taken) as to the identity and the location of an organism. |
|Vouchers             |integer   | four columns that display the number of associated evidence records that substantiate the status of the species in the park: Observations, Vouchers, References, and External Links. Physical evidence used to confirm identity and prove an organism was found in a particular location. Forms of physical evidence include a voucher specimen at a museum or herbarium (including whole or piece of organism), or in some cases a photo image (i.e. digital or hardcopy) |
|ExternalLinks        |character | four columns that display the number of associated evidence records that substantiate the status of the species in the park: Observations, Vouchers, References, and External Links.  |
|TEStatus             |character | indicates any FWS Threatened or Endangered species status. |
|StateStatus          |character | Many states and US territories maintain their own lists of species of concern, or may have other status categories that are assigned to species within a state/territory. |
|OzoneSensitiveStatus |character | Plant species found within National Park boundaries that are known to have a negative response to high ozone exposure. Ground-level ozone can cause visible leaf injury (e.g. bleaching or dark stippling), growth and yield reductions, and altered sensitivity to stressors (e.g. pests, diseases, or drought). |
|GRank                |character | Global ranks assess the level of rarity or abundance of a taxon throughout its range. |
|SRank                |character | State ranks assess rarity or abundance of a taxon within a state. |
