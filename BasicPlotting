using CSV, DataFrames, StatsBase, StatsPlots


PowerConfAll = CSV.read("PowerConfAll.csv", DataFrame)
PowerNormAll = CSV.read("PowerNormAll.csv", DataFrame)

PowerNormWinners = CSV.read("PowerNormWinners.csv", DataFrame)
PowerNormLosers = CSV.read("PowerNormLosers.csv", DataFrame)

PowerConfWinners = CSV.read("PowerConfWinners.csv", DataFrame)
PowerConfLosers = CSV.read("PowerConfLosers.csv", DataFrame)

HighConfWinners = CSV.read("HighConfWinners.csv", DataFrame)
HighConfLosers = CSV.read("HighConfLosers.csv", DataFrame)

LowConfWinners = CSV.read("LowConfWinners.csv", DataFrame)
LowConfLosers = CSV.read("LowConfLosers.csv", DataFrame)

#Plotting for the part 1 basic stats
function BasicRanksPlot(df, ConfType)

    WinPer = bar([minimum(df.WinPer), mean(df.WinPer), median(df.WinPer), mode(df.WinPer),  maximum(df.WinPer)], 
    title="$ConfType Conf Winners Win %", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfWinPerBar$ConfType.png")

    WAB = bar([minimum(df.WAB), mean(df.WAB), median(df.WAB), mode(df.WAB),  maximum(df.WAB)],
    title="$ConfType Conf Winners WAB", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfWinWABBar$ConfType.png")  
    
    Barthag = bar([minimum(df.BARTHAG), mean(df.BARTHAG), median(df.BARTHAG), mode(df.BARTHAG),  maximum(df.BARTHAG)],
    title="$ConfType Conf Winners BARTHAG", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfWinBARTHAGBar$ConfType.png")

    plot(WinPer, WAB, Barthag, layout=(3,1))
    savefig("ConfWinGeneral$ConfType.png")

    AdjOE = bar([minimum(df.ADJOE), mean(df.ADJOE), median(df.ADJOE), mode(df.ADJOE),  maximum(df.ADJOE)], 
    title="$ConfType Conf Winners AdjOE %", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfAdjOEBar$ConfType.png")

    AdjDE = bar([minimum(df.ADJDE), mean(df.ADJDE), median(df.ADJDE), mode(df.ADJDE),  maximum(df.ADJDE)], 
    title="$ConfType Conf Winners AdjDE %", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfAdjOEBar$ConfType.png")

    OEFG = bar([minimum(df.OEFG), mean(df.OEFG), median(df.OEFG), mode(df.OEFG),  maximum(df.OEFG)], 
    title="$ConfType Conf Winners OEFG %", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfOEFGBar$ConfType.png")

    DEFG = bar([minimum(df.DEFG), mean(df.DEFG), median(df.DEFG), mode(df.DEFG),  maximum(df.DEFG)], 
    title="$ConfType Conf Winners DEFG %", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfDEFGBar$ConfType.png")

    plot(AdjOE, AdjDE, OEFG, DEFG)
    savefig("ConfOffDef$ConfType.png")

    OFTR = bar([minimum(df.OFTR), mean(df.OFTR), median(df.OFTR), mode(df.OFTR),  maximum(df.OFTR)], 
    title="$ConfType Conf Winners OFTR %", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfOFTRBar$ConfType.png")

    DFTR = bar([minimum(df.DFTR), mean(df.DFTR), median(df.DFTR), mode(df.DFTR),  maximum(df.DFTR)], 
    title="$ConfType Conf Winners DFTR %", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfDFTRBar$ConfType.png")

    OTOR = bar([minimum(df.OTOR), mean(df.OTOR), median(df.OTOR), mode(df.OTOR),  maximum(df.OTOR)], 
    title="$ConfType Conf Winners OTOR %", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfOTORBar$ConfType.png")

    DTOR = bar([minimum(df.DTOR), mean(df.DTOR), median(df.DTOR), mode(df.DTOR),  maximum(df.DTOR)], 
    title="$ConfType Conf Winners DTOR %", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfDTORBar$ConfType.png")

    ORB = bar([minimum(df.ORB), mean(df.ORB), median(df.ORB), mode(df.ORB),  maximum(df.ORB)], 
    title="$ConfType Conf Winners ORB %", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfORBBar$ConfType.png")

    DRB = bar([minimum(df.DRB), mean(df.DRB), median(df.DRB), mode(df.DRB),  maximum(df.DRB)], 
    title="$ConfType Conf Winners DRB %", legend=false, xticks=(1:5, ["Min", "Mean", "Median", "Mode", "Max"]))
    savefig("ConfORBAar$ConfType.png")


    plot(OFTR, DFTR, OTOR, DTOR, ORB, DRB, layout=(3, 2))
    savefig("ConfExtraPandFTs$ConfType.png")
end

BasicRanksPlot(PowerConfWinners, "Power")
BasicRanksPlot(HighConfWinners, "High")
BasicRanksPlot(LowConfWinners, "Low")
