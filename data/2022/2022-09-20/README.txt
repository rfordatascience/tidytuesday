HydroWASTE: Global wastewater treatment plant database
Date: December 2021
Version: 1.0

Reference paper: Ehalt Macedo, H., Lehner, B., Nicell, J. A., Grill, G., Li, J., Limtong, A., Shakya, R.: Distribution and characteristics of wastewater treatment plants within the global river network. Earth System Science Data. 2022.
Correspondence to: Heloisa Ehalt Macedo (heloisa.ehaltmacedo@mail.mcgill.ca) or Bernhard Lehner (bernhard.lehner@mcgill.ca)

Column description:

WASTE_ID	ID of WWTP in HydroWASTE
SOURCE		National/regional dataset: 1 = Europe; 2 = United States; 3 = Brazil; 4 = Mexico; 5 = China; 6 = Canada; 7 = Australia;	8 = South Africa; 9 = India; 10 = New Zealand; 11 = Peru; 12 = Remaining Countries
ORG_ID		ID from national/regional dataset (see reference paper for more information)
WWTP_NAME	Name of the WWTP from national/regional dataset (empty if not reported)
COUNTRY		Country in which WWTP is located
CNTRY_ISO	Country ISO
LAT_WWTP	Latitude of reported WWTP location
LON_WWTP	Longitude of reported WWTP location
QUAL_LOC	Quality indicator related to reported WWTP location (see SI of reference paper for more information): 1 = high (tests indicated >80% of reported WWTP locations in country/region to be accurate); 2 = medium (tests indicated between 50% and 80% of reported WWTP locations in country/region to be accurate); 3 = low (tests indicated <50% of reported WWTP locations in country/region to be accurate); 4 = Quality of WWTP locations in country/region not analysed
LAT_OUT		Latitude of the estimated outfall location (see reference paper for more information)
LON_OUT		Longitude of the estimated outfall location (see reference paper for more information)
STATUS		Status of the WWTP from national/regional dataset: Closed, Construction Completed, Decommissioned, Non-Operational, Operational, Projected, Proposed, Under Construction, Not Reported (assumed operational)
POP_SERVED	Population served by the WWTP
QUAL_POP	Quality indicator related to the attribute "population served" (see reference paper for more information): 1 = Reported as ‘population served’ by national/regional dataset; 2 = Reported as ‘population equivalent’ by national/regional dataset; 3 = Estimated (with wastewater discharge available); 4 = Estimated (without wastewater discharge available)
WASTE_DIS	Treated wastewater discharged by the WWTP in m3 d-1
QUAL_WASTE	Quality indicator related to the attribute "Treated wastewater discharged" (see reference paper for more information): 1 = Reported as ‘treated’ by national/regional dataset; 2 = Reported as ‘design capacity’ by national/regional dataset; 3 = Reported but type not identified; 4 = Estimated
LEVEL		Level of treatment of the WWTP: Primary, Secondary, Advanced
QUAL_LEVEL	Quality indicator related to the attribute "level of treatment" (see reference paper for more information): 1 = Reported by national/regional dataset; 2 = Estimated
DF		Estimated dilution factor (empty if estimated outfall location is the ocean or large lake; see reference paper for more information)
HYRIV_ID	ID of associated river reach in RiverATLAS at estimated outfall location (link to HydroATLAS database; empty if estimated outfall location is the ocean or an endorheic sink)
RIVER_DIS	Estimated river discharge at the WWTP outfall location in m3 s-1 (derived from HydroATLAS database; empty if estimated outfall location is the ocean)
COAST_10KM	1 = Estimated outfall location within 10 km of the ocean or a large lake (surface area larger than 500 km2); 0 = Estimated outfall location further than 10 km of the ocean or a large lake (surface area larger than 500 km2)
COAST_50KM	1 = Estimated outfall location within 50 km of the ocean or a large lake (surface area larger than 500 km2); 0 = Estimated outfall location further than 50 km of the ocean or a large lake (surface area larger than 500 km2)
DESIGN_CAP	Design capacity of WWTP as reported in national/regional dataset (empty if not reported)
QUAL_CAP	Quality indicator related to the attribute "design capacity": 1 = Reported as design capacity in m3 d-1; 2 = Reported as design capacity in 'population equivalent'; 3 = Not reported