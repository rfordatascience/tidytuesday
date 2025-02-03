|variable                     |class     |description                           |
|:----------------------------|:---------|:-------------------------------------|
|dataset_url                  |character |The location to download the metadata about the archived dataset. The dataset itself is at this location with `-meta` removed (replace "-meta.csv" with ".csv"). |
|contact_name                 |character |A name to contact about the dataset. Sometimes this field contains the name of the dataset. |
|contact_email                |character |A government email to contact about the dataset. Many of these email addresses likely no longer work under the Trump administration. |
|bureau_code                  |character |Federal agencies, combined agency and bureau code from OMB Circular A-11, Appendix C (see omb_codes dataset). |
|program_code                 |character |The primary program related to this data asset, from the Federal Program Inventory (see fpi_codes dataset). |
|category                     |character |Main thematic category of the dataset. |
|tags                         |character |Tags (or keywords) to help users discover the dataset. Intended to include terms that would be used by technical and non-technical users. |
|publisher                    |character |The publishing entity and optionally their parent organization(s). |
|public_access_level          |character |The degree to which this dataset could be made publicly-available, regardless of whether it has been made available. Choices: public (Data asset is or could be made publicly available to all without restrictions), restricted public (Data asset is available under certain use restrictions), or non-public (Data asset is not available to members of the public). |
|footnotes                    |character |Additional notes about this dataset. |
|license                      |character |The license or non-license (i.e. Public Domain) status with which the dataset or API has been published. |
|source_link                  |character |The location where the dataset was stored. |
|issued                       |character |Date of formal issuance. |
|geographic_coverage          |character |The range of spatial applicability of a dataset. Could include a spatial region like a bounding box or a named place. |
|temporal_applicability       |character |The range of temporal applicability of a dataset (i.e., a start and end date of applicability for the data). |
|update_frequency             |character |The frequency with which dataset is published. |
|described_by                 |character |URL to the data dictionary for the dataset. |
|homepage                     |character |Intended for use if a dataset has a human-friendly hub or landing page that users can be directed to for all resources tied to the dataset. |
|geographic_unit_of_analysis  |character |Likely very similar to geographic_coverage. |
|suggested_citation           |character |How to cite this dataset. |
|geospatial_resolution        |character |The sizes of geospatial units included in the dataset. |
|references                   |character |Related documents such as technical information about a dataset, developer documentation, etc. |
|glossary_methodology         |character |A URL or reference to how things were named. |
|access_level_comment         |character |This may include information regarding access or restrictions based on privacy, security, or other policies. |
|analytical_methods_reference |character |Usually a URL describing the methodology. URL may not be available under the Trump administration. |
|language                     |character |The language of the dataset. |
|collection                   |character |The collection of which the dataset is a subset. |
