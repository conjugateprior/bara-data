# bara-data

Various slicings of a 1966 UK Commons debate on relaxing the abortion laws.

* `corpus_bara_speaker` (aggregated by speaker)
* `corpus_bara_turn` (by conversational turn)
* `corpus_bara_para` (by individual paragraph)

These are [quanteda](https://CRAN.R-project.org/package=quanteda) corpora.  To load them

```r
library(quanteda)
load('corpus_bara_turn.rda') # creates corpus_bara_turn
```

The debate's web page page is `abortion_debate_hansard.html` is taken from [http://hansard.millbanksystems.com/](http://hansard.millbanksystems.com/).
