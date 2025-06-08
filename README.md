# Compute UCD Quarter Dates

```r
q = UCDQuarters::getQuarterInfo()
```

The result is a data.frame with 3 columns:
+ start, end - Date objects
+ term - ordered factor giving the term string as it appears in other systems, e.g., OASIS.

```
       start        end   term
1 2025-03-27 2025-06-12 202503
2 2025-01-03 2025-03-21 202501
3 2024-09-23 2024-12-13 202410
4 2024-03-28 2024-06-13 202403
5 2024-01-05 2024-03-22 202401
6 2023-09-25 2023-12-15 202310
```


##  Mapping a date to a term code

```r
dateToTerm(as.Date("2024-01-05"), q)
```
```
[1] "202501"
```



