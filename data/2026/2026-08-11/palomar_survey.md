|variable                  |class     |description                           |
|:-------------------------|:---------|:-------------------------------------|
|galaxy_name               |character |Common name of the galaxy (e.g. "NGC 224", "IC 342"). |
|hubble_type               |character |Morphological type in the Hubble sequence (e.g. "Sb", "E2", "SBc"). Includes luminosity class when available. |
|b_magnitude               |double    |Apparent blue (B-band) magnitude, uncorrected for extinction. Brighter objects have lower values. |
|helio_velocity_km_s       |double    |Heliocentric radial velocity in km/s. Negative values indicate motion toward us. Dividing by ~70 gives approximate distance in Mpc. |
|ra_j2000                  |character |Right ascension in J2000 coordinates (hours, minutes, seconds). |
|dec_j2000                 |character |Declination in J2000 coordinates (degrees, arcminutes, arcseconds). |
|ha_hb_ratio               |double    |Observed H-alpha to H-beta intensity ratio. The theoretical value for pure hydrogen gas is 2.86; higher values indicate dust reddening. |
|internal_reddening_ebv    |double    |Internal color excess E(B-V) derived from the H-alpha/H-beta ratio. Measures dust inside the galaxy reddening the nuclear light. |
|sii_density_ratio         |double    |Ratio of [S II] 6716 to [S II] 6731 line intensities. Used to estimate electron density in the emitting gas. |
|electron_density_cm3      |double    |Electron density in particles per cubic centimeter, derived from the [S II] doublet ratio. |
|log_oiii_hb               |double    |Dereddened [O III] 5007 / H-beta intensity ratio. Higher values indicate higher ionization. Used on the y-axis of BPT diagrams. |
|log_oi_ha                 |double    |Dereddened [O I] 6300 / H-alpha intensity ratio. Sensitive to shock excitation and partial ionization zones common in LINERs. |
|log_nii_ha                |double    |Dereddened [N II] 6583 / H-alpha intensity ratio. The primary x-axis of the classic BPT diagnostic diagram. |
|log_sii_ha                |double    |Dereddened [S II] (6716+6731) / H-alpha intensity ratio. Used in alternative BPT diagrams to separate Seyferts from LINERs. |
|spectral_class            |character |Nuclear spectral classification code (e.g. "S1.9", "L2", "T2:", "H"). Letters encode type, numbers subtype, colons indicate uncertainty. |
|activity_type             |character |Simplified nuclear activity classification: "Seyfert", "LINER", "Transition", "H II", or "Absorption". |
|activity_subtype          |integer   |Numeric subtype (1 or 2). Type 1 shows broad emission lines; type 2 shows only narrow lines. |
|classification_confidence |character |Confidence level: "confident", "uncertain", or "very uncertain". |
|velocity_dispersion_km_s  |double    |Adopted central stellar velocity dispersion in km/s. Correlates with central mass via the M-sigma relation. |
|velocity_dispersion_error |double    |Measurement uncertainty on the velocity dispersion in km/s. |

