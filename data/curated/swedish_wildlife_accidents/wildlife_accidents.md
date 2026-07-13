|variable      |class         |description                           |
|:-------------|:-------------|:-------------------------------------|
|accident_id   |integer       |Identifier of the reported accident (OlycksID). A single accident can involve more than one animal, so this value is not unique across rows. |
|accident_type |character     |Whether the collision happened on a road (`Road`) or a railway (`Railway`). |
|datetime      |datetime<UTC> |Date and time the accident occurred, in local Swedish time. |
|county        |character     |Swedish county (län) where the accident occurred, e.g. `Stockholm County`. |
|municipality  |character     |Swedish municipality (kommun) where the accident occurred. |
|species       |character     |Wildlife species involved: `Roe deer`, `Wild boar`, `Moose`, `Fallow deer`, `Red deer`, `Otter`, `Eagle`, `Lynx`, `Wolf`, `Bear`, `Mouflon`, `Wolverine`, or `Other animals`. |
|lat           |double        |Latitude of the accident site (WGS84). For a few accidents this was derived from the reported RT90 coordinates. |
|long          |double        |Longitude of the accident site (WGS84). For a few accidents this was derived from the reported RT90 coordinates. |
|sex           |character     |Sex of the animal: `Female`, `Male`, or `Unknown`. |
|juvenile      |character     |Whether the animal was a juvenile / young-of-the-year (årsunge): `Yes`, `No`, or `Unknown`. |
|outcome       |character     |What happened to the animal, as concluded after the follow-up search (eftersök) by a trained hunter: `Died at the scene`, `Found dead` (during the follow-up search), `Euthanised`, `Assessed uninjured`, `Assessed injured, not found` (the search was called off although the animal was injured), `Not found`, or `Accident site not found`. |
