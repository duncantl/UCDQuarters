#

quarters =
function()    
{
   info = lapply(c("https://registrar.ucdavis.edu/calendar/quarter",
                   "https://registrar.ucdavis.edu/calendar/archive/quarter"),
                 getQuarterInfo)
   ans = rbind(info[[1]], info[[2]])
   ans = ans[!duplicated(ans$start),]
   ans$term = ordered(ans$term, rev(ans$term))
   ans
}


getQuarterInfo =
   # Can also point it to the URL for the current and future AY
   # getQuarterInfo("https://registrar.ucdavis.edu/calendar/quarter")
   #
function(u = "https://registrar.ucdavis.edu/calendar/archive/quarter")
{
    doc = htmlParse(readLines(u))

    y = getNodeSet(doc, "//div[./table[contains(., 'Quarter begins')]]")

    dates = lapply(y, doYear)
    quarters = do.call(rbind, dates)
    quarters = quarters[order(quarters$start, decreasing = TRUE), ]
    quarters$term = ordered(quarters$term, rev(quarters$term))
    rownames(quarters) = NULL
    quarters
}


doYear = 
function(div)
{
    q = xpathSApply(div, ".//thead//th", xmlValue)[-1]
    q2 = trimws(gsub("Fall|Winter|Spring " , "", q))
    s = getDates(div, 'Quarter begins', q2)
    e = getDates(div, 'Quarter ends', q2)
    ans = lapply(list(start = s, end = e), function(x) as.Date(x, '%Y/%b %d'))
    ans = as.data.frame(ans)

    ans$term = paste0(q2, c("10", "01", "03"))
    # reverse the order so that we will have most recent first
    ans[nrow(ans):1,]
}

getDates =
function(div, text, q2)    
{
    xp = sprintf(".//tr[./td[contains(., '%s')]]/td", text)
    dt = xpathSApply(div, xp, xmlValue)[-1]
    paste(q2, dt, sep = "/")
}

