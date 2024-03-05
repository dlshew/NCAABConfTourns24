using CSV, DataFrames, DataFramesMeta, Random, MLJ, TreeRecipe, Plots

Tree = @load DecisionTreeClassifier pkg=DecisionTree
PowerTree = machine("PowerDecTree.jlso")
HighTree = machine("HighDecTree.jlso")
LowTree = machine("LowDecTree.jlso")

function DecTree(Conf, Mach)
    ConfRanks = CSV.read(Conf * "Ranks.csv", DataFrame)
    select!(ConfRanks, Not([:WinPer, :BARTHAG]))

    DTPredict = predict(Mach, ConfRanks[:, 4:14])
    ConfRanks.YesDT .= broadcast(pdf, DTPredict, 1)
    ConfRanks.YesDT .= ConfRanks.YesDT ./ sum(ConfRanks.YesDT)

    select!(ConfRanks, :Conf, :Team, :Year, :YesDT)
    sort!(ConfRanks, :YesDT, rev=true)

    return ConfRanks
end

ASunRanks = DecTree("ASun", LowTree)
HorzRanks = DecTree("Horz", LowTree)
PatRanks = DecTree("Pat", LowTree)
SunBeltRanks = DecTree("SB", LowTree)
NECRanks = DecTree("NEC", LowTree)
OVCRanks = DecTree("OVC", LowTree)
MVCRanks = DecTree("MVC", LowTree)
WCCRanks = DecTree("WCC", HighTree)
CAARanks = DecTree("CAA", LowTree)
SCRanks = DecTree("SC", LowTree)
SumRanks = DecTree("Sum", LowTree)

CSV.write("ASunDTTable.csv", ASunRanks)
CSV.write("HorzDTTable.csv", HorzRanks)
CSV.write("PatDTTable.csv", PatRanks)
CSV.write("SunBeltDTTable.csv", SunBeltRanks)
CSV.write("NECDTTable.csv", NECRanks)
CSV.write("OVCDTTable.csv", OVCRanks)
CSV.write("MVCDTTable.csv", MVCRanks)
CSV.write("WCCDTTable.csv", WCCRanks)
CSV.write("CAADTTable.csv", CAARanks)
CSV.write("SCDTTable.csv", SCRanks)
CSV.write("SumDTTable.csv", SumRanks)
