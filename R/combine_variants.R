library(argparser)
library(TopmedPipeline)
sessionInfo()

argp <- arg_parser("Combine variants in files split by chromosome")
argp <- add_argument(argp, "config", help="path to config file")
argv <- parse_args(argp)
config <- readConfig(argv$config)

required <- c("in_file")
optional <- c("chromosomes"="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22",
              "out_file"="variants.RData")
config <- setConfigDefaults(config, required, optional)
print(config)

chr <- strsplit(config["chromosomes"], " ", fixed=TRUE)[[1]]
files <- sapply(chr, function(c) insertChromString(config["in_file"], c, "in_file"))

var <- unlist(lapply(files, getobj), use.names=FALSE)
save(var, file=config["out_file"])
