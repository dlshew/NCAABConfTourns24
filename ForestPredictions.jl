using CSV, DataFrames, DataFramesMeta, Random, MLJ
#Similar to TreePredictions.jl
Forest = @load RandomForestClassifier pkg=DecisionTree
PowerForest = machine("PowerForest.jlso")
HighForest = machine("HighForest.jlso")
LowForest = machine("LowForest.jlso")

function RandForest(Conf, Mach)
    ConfRanks = CSV.read(Conf * "Ranks.csv", DataFrame)
    select!(ConfRanks, Not([:WinPer, :BARTHAG]))

    ForPredict = predict(Mach, ConfRanks[:, 4:14])
    ConfRanks.YesForest .= broadcast(pdf, ForPredict, 1)
    ConfRanks.YesForest .= ConfRanks.YesForest ./ sum(ConfRanks.YesForest)

    select!(ConfRanks, :Conf, :Team, :Year, :YesForest)
    sort!(ConfRanks, :YesForest, rev=true)

    return ConfRanks
end

ASunRanks = RandForest("ASun", LowForest)
HorzRanks = RandForest("Horz", LowForest)
PatRanks = RandForest("Pat", LowForest)
SunBeltRanks = RandForest("SB", LowForest)
NECRanks = RandForest("NEC", LowForest)
OVCRanks = RandForest("OVC", LowForest)
MVCRanks = RandForest("MVC", LowForest)
WCCRanks = RandForest("WCC", HighForest)
CAARanks = RandForest("CAA", LowForest)
SCRanks = RandForest("SC", LowForest)
SumRanks = RandForest("Sum", LowForest)


CSV.write("ASunForestTable.csv", ASunRanks)
CSV.write("HorzForestTable.csv", HorzRanks)
CSV.write("PatForestTable.csv", PatRanks)
CSV.write("SunBeltForestTable.csv", SunBeltRanks)
CSV.write("NECForestTable.csv", NECRanks)
CSV.write("OVCForestTable.csv", OVCRanks)
CSV.write("MVCForestTable.csv", MVCRanks)
CSV.write("WCCForestTable.csv", WCCRanks)
CSV.write("CAAForestTable.csv", CAARanks)
CSV.write("SCForestTable.csv", SCRanks)
CSV.write("SumForestTable.csv", SumRanks)
