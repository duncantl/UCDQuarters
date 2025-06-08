dateToTerm =
function(date, qinfo = getQuarterInfo())
{
    w = date >= qinfo$start & date <= qinfo$end
    if(!any(w)) {
        # in between quarters
        w = which(date >= qinfo$start)[1]
    }
    
    as.character(qinfo$term[w])
}

earlierQuarters =
function(date, qinfo = getQuarterInfo())
{
    term = dateToTerm(date, qinfo)
    qtr = levels(qinfo$term)
    i = which(qtr == term)
    qtr[1:i]
}

