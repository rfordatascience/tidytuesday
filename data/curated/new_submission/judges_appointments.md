|variable                       |class     |description                           |
|:------------------------------|:---------|:-------------------------------------|
|judge_id                       |integer   |"Judge Identification Number."" This was used as a unique identifier for each judge, generated for purposes of the database, until July 2016. These numbers are no longer used and will not be generated for judges added to the database after July 2016, but will remain in the export as a courtesy to researchers who may have relied on them. This is one area that should be updated when the package gets a new maintainer. |
|court_name                     |character |The name of the court to which the judge was appointed. |
|court_type                     |character |The type of court to which the judge was appointed. "U. S. Court of Custo" and "U. S. Court of Inter" each have 1 entry due to coding issues. |
|president_name                 |character |The name of the President who appointed the judge. Some entries have "Assignment" or "Reassignment", indicating the judge was assigned or reassigned to this appointment via statute rather than by a President. |
|president_party                |character |The political party of the President who appointed the judge. Some entries have "Assignment" or "Reassignment", indicating the judge was assigned or reassigned to this appointment via statute rather than by a President. |
|nomination_date                |character |The date on which the judge was nominated, in "MM/DD/YYYY" format. |
|predecessor_last_name          |character |The last name of the judge's predecessor in this position. The word "new" is sometimes used to indicate that this is a new position (but also check "predecessor_first_name"). |
|predecessor_first_name         |character |The first name of the judge's predecessor in this position. The word "new" is sometimes used to indicate that this is a new position (but also check "predecessor_last_name"). |
|senate_confirmation_date       |character |The date on which the Senate confirmed this appointment, in "MM/DD/YYYY" format. Note that some judges were never confirmed (they were "recess appointments"), and some were put into the office by statute ("Assignment" or "Reassignment"). |
|commission_date                |character |The date on which the judgeship officially began, in "MM/DD/YYYY" format. NA for all recess appointments, as well as for four judgeships with missing information. |
|chief_judge_begin              |integer   |Year in which the judge began temporary service as Chief Judge. Only non-NA for 2 judges. |
|chief_judge_end                |integer   |Year in which the judge ended temporary service as Chief Judge. Only non-NA for 2 judges. |
|retirement_from_active_service |character |The date on which the judge retired from active service, in "MM/DD/YYYY" format. |
|termination_date               |character |The date on which the judge's service ended (when appropriate), in "MM/DD/YYYY" format. |
|termination_reason             |character |The reason that the judge's service ended (when appropriate). One of "Abolition of Court", "Appointment to Another Judicial Position", "Death", "Impeachment & Conviction", "Reassignment", "Recess Appointment-Not Confirmed", "Resignation", "Retirement" or NA. |
