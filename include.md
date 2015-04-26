### Welcome to the CMS Medicare Spending Data Explorer

This application is based on the CMS Medicare data set from 2012.

What you can do:

1. Select one or more provider type from the left pane. 
2. This filter the data to so the $ of Medicare services performed for that provider type.
3. Select the Download tab to view the data and download the data set. 

Data Source:The primary data source for these data is CMS’s CY2012 National Claims History (NCH) Standard Analytic Files (SAFs) which include claims as of 6/30/2013. The NCH SAFs contain 100 percent of Medicare final action claims for beneficiaries who are enrolled in the FFS program. [CMS Data](http://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Physician-and-Other-Supplier.html)

Study Population: Providers that had a valid NPI and submitted Medicare Part B non-institutional claims (excluding DME) during the 2012 calendar year.
Years: Calendar Year 2012

Special Note: This aggregate report was created using the Medicare Physician and Other Supplier Public Use File (PUF).  In the Medicare Physician and Other Supplier PUF any aggregated records which are derived from 10 or fewer beneficiaries are excluded to protect the privacy of Medicare beneficiaries.  As a result, the data in this aggregate report also reflect these redactions.  

The data was processed as follows:

1. States were changed from abbreviations to full names
2. Data related to overseas locations were removed
3. Numeric data was cleaned up to remove $ and commas

Source code is available on the [GitHub](https://github.com/Patel4721/Data-Products-Course-Project).