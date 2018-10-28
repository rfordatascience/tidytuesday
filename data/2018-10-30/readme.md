# Week 31 - R and Package download stats

Package and R language downloads from the RStudio CRAN mirror on October 23, 2018. 

## [`r-downloads.csv`]()
Header | Description
---|---------
`date` | date of download (y-m-d)
`time` | time of download (in UTC)
`size` | size (in bytes)
`version` | R release version
`os` | Operating System
`country` | Two letter ISO country code.
`ip_id` | Anonymized daily ip code (unique identifier)

date
time (in UTC)
size (in bytes)
r_version, version of R used to download package
r_arch (i386 = 32 bit, x86_64 = 64 bit)
r_os (darwin9.8.0 = mac, mingw32 = windows)
package
country, two letter ISO country code. Geocoded from IP using MaxMind's free database
ip_id, a daily unique id assigned to each IP address

## `pkg-downloads.csv`

Header | Description
---|---------
`date` | date of download (y-m-d)
`time` | time of download (h-m-s)
`size` | ?
`r_version` | Version of R used to download package
`r_arch` | R architecture (i386 = 32 bit, x86_64 = 64 bit)
`r_os` | R operating system (darwin9.8.0 = mac, mingw32 = windows)
`package` | Package Name
`version` |Package version
`country` | Two letter ISO country code.
`ip_id` | Anonymized daily ip code (unique identifier)

