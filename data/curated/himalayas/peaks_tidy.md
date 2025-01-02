|variable       |class     |description                           |
|:--------------|:---------|:-------------------------------------|
|PEAKID     |integer |Peak ID, the key field (unique identifier) for each record. |
|PKNAME     |integer |Peak name. |
|PKNAME2    |integer |Peak name 2. |
|LOCATION   |integer |Location of the peak. |
|HEIGHTM    |integer |Peak height in meters. |
|HEIGHTF    |integer |Peak height in feet. |
|HIMAL      |integer |Mountain range identifier.  See HIMAL_FACTOR for names.  |
|HIMAL_FACTOR   |integer   |Mountain range name. |
|REGION   |integer   |Region identifier. |
|REGION_FACTOR  |character |Region name. |
|OPEN     |logical   |Indicates  whether the peak is open for expeditions. |
|UNLISTED       |logical   |Indicates whether the peak is unlisted in official records. |
|TREKKING       |logical   |Indicates whether the peak is a trekking peak. |
|TREKYEAR        |integer   |Year the peak was designated as a trekking peak. |
|RESTRICT        |logical   |Indicates whether the peak is restricted for climbing or access. |
|PHOST           |integer   |Primary host country identifier for the peak. See PHOST_FACTOR for names. |
|PHOST_FACTOR    |character |Primary host country name corresponding to the PHOST identifier. |
|PSTATUS         |integer   |Climbing status identifier for the peak. See PSTATUS_FACTOR for names. |
|PSTATUS_FACTOR  |character |Climbing status description corresponding to the PSTATUS identifier. |
|PEAKMEMO        |character |Additional notes or remarks about the peak. |
|PYEAR           |integer   |Year of the first recorded climbing attempt on the peak. |
|PSEASON         |character |Climbing season associated with the first recorded ascent or expedition. |
|PEXPID          |integer   |Expedition ID associated with the first recorded climb. |
|PSMTDATE        |character |Date of the first successful summit. |
|PCOUNTRY        |character |Country of origin for the expedition or climbers. |
|PSUMMITERS      |integer   |Number of climbers who first reached the summit. |
|PSMTNOTE        |character |Notes or remarks related to the first successful summit. |
|REFERMEMO       |character |Peak chronology references. |
|PHOTOMEMO       |character |Peak photo references. |
