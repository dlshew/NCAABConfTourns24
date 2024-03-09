using DataFrames, StatsPlots, GLM, CSV, StatsBase, Normalization

PowerNormAll = CSV.read("PowerNormAll.csv", DataFrame)
HighNormAll = CSV.read("HighNormAll.csv", DataFrame)
LowNormAll = CSV.read("LowNormAll.csv", DataFrame)

#Fitting the linear and probit regression models to the data
Pols = lm(@formula(Win ~ WAB+OEFG+DEFG+OFTR+DFTR+OFTR+DFTR+OTOR+DTOR+ORB+DRB), PowerNormAll)
PowerNormAll.OLS = predict(Pols)

ProbitP = glm(@formula(Win ~ WAB+OEFG+DEFG+OFTR+DFTR+OFTR+DFTR+OTOR+DTOR+ORB+DRB), PowerNormAll, Binomial(), ProbitLink())
PowerNormAll.Probit = predict(ProbitP)

select!(PowerNormAll, :Team, :Conf, :Year, :Win, :OLS, :Probit)

PowerNormWinners = PowerNormAll[PowerNormAll.Win .== 1, :]
PowerNormLosers = PowerNormAll[PowerNormAll.Win .== 0, :]
#Plots to test see if the data makes sense 
@df PowerNormLosers scatter(:Team, :OLS, color=:red, title="Power Conference (Linear Regression)", label="Losers")
@df PowerNormWinners scatter!(:OLS, color=:green, label="Winners", legend=:topright, rotation=45)
savefig("TestingOLSPower.png")

@df PowerNormLosers scatter(:Team, :Probit, color=:red, title="Power Conference (Probit Regression)", label="Losers")
@df PowerNormWinners scatter!(:Probit, color=:green, label="Winners", legend=:topright, rotation=45)
savefig("TestingProbitPower.png")


Hols = lm(@formula(Win ~ WAB+OEFG+DEFG+OFTR+DFTR+OFTR+DFTR+OTOR+DTOR+ORB+DRB), HighNormAll)
HighNormAll.OLS = predict(Hols)

ProbitH = glm(@formula(Win ~ WAB+OEFG+DEFG+OFTR+DFTR+OFTR+DFTR+OTOR+DTOR+ORB+DRB), HighNormAll, Binomial(), ProbitLink())
HighNormAll.Probit = predict(ProbitH)

select!(HighNormAll, :Team, :Conf, :Year, :Win, :OLS, :Probit)

HighNormWinners = HighNormAll[HighNormAll.Win .== 1, :]
HighNormLosers = HighNormAll[HighNormAll.Win .== 0, :]

@df HighNormLosers scatter(:Team, :OLS, color=:red, title="High Conference (Linear Regression)", label="Losers")
@df HighNormWinners scatter!(:OLS, color=:green)
savefig("TestingOLSHigh.png")

@df HighNormLosers scatter(:Team, :Probit, color=:red, title="High Conference (Probit Regression)", label="Losers")
@df HighNormWinners scatter!(:Probit, color=:green, label="Winners", legend=:topright, rotation=45)
savefig("TestingProbitHigh.png")


Lols = lm(@formula(Win ~ WAB+OEFG+DEFG+OFTR+DFTR+OFTR+DFTR+OTOR+DTOR+ORB+DRB), LowNormAll)
LowNormAll.OLS = predict(Lols)

ProbitL = glm(@formula(Win ~ WAB+OEFG+DEFG+OFTR+DFTR+OFTR+DFTR+OTOR+DTOR+ORB+DRB), LowNormAll, Binomial(), ProbitLink())
LowNormAll.Probit = predict(ProbitL)

select!(LowNormAll, :Team, :Conf, :Year, :Win, :OLS, :Probit)


LowNormWinners = LowNormAll[LowNormAll.Win .== 1, :]
LowNormLosers = LowNormAll[LowNormAll.Win .== 0, :]

@df LowNormLosers scatter(:Team, :OLS, color=:red, title="Low Conference (Linear Regression)", label="Losers")
@df LowNormWinners scatter!(:OLS, color=:green, label="Winners", legend=:topright, rotation=45)
savefig("TestingOLSLow.png")

@df LowNormLosers scatter(:Team, :Probit, color=:red, title="Low Conference (Probit Regression)", label="Losers")
@df LowNormWinners scatter!(:Probit, color=:green, label="Winners", legend=:topright, rotation=45)
savefig("TestingProbitLow.png")

#loads 2024 data and uses the fitted models to make predictions 
function Predictions(Conference, TypeOLS, TypePro)
    Conf = CSV.read(Conference * "Norm.csv", DataFrame)
    Conf.OLS = predict(TypeOLS, Conf)
    Conf.Probit = predict(TypePro, Conf)
    Conf.Probit = Conf.Probit ./ sum(Conf.Probit)
    sort!(Conf, :Probit, rev=true)
    select!(Conf, :Team, :Conf, :OLS, :Probit)
    return Conf
end
#Plots the results of the linear and probit models
function Plotting(DF, ConfName::String)
    ConfOLS = @df DF scatter(:Team, :OLS, color=:red, title="$ConfName Linear Regression", legend=:none,
    xlabel="Teams", ylabel="Probablites", rotation=45, xflip=true)
    ConfProbit = @df DF scatter(:Team, :Probit, color=:red, title="$ConfName Probit Regression", legend=:none,
    xlabel="Teams", ylabel="Probablites", rotation=45, xflip=true)
    plot(ConfOLS, ConfProbit, layout=(1, 2))
    savefig(ConfName * "RegressionPlots")
end
#Calling the above functions 
ASun = Predictions("ASun", Lols, ProbitL)
Plotting(ASun, "ASun")

Horz = Predictions("Horz", Lols, ProbitL)
Plotting(Horz, "Horz")

Pat = Predictions("Pat", Lols, ProbitL)
Plotting(Pat, "Pat")

SunBelt = Predictions("SB", Lols, ProbitL)
Plotting(SunBelt, "SunBelt")

NEC = Predictions("NEC", Lols, ProbitL)
Plotting(NEC, "Nec")

OVC = Predictions("OVC", Lols, ProbitL)
Plotting(OVC, "OVC")

BSth = Predictions("BSth", Lols, ProbitL)
Plotting(BSth, "BSth")

MVC = Predictions("MVC", Lols, ProbitL)
Plotting(MVC, "MVC")

WCC = Predictions("WCC", Lols, ProbitL)
Plotting(WCC, "WCC")

CAA = Predictions("CAA", Lols, ProbitL)
Plotting(CAA, "CAA")

SC = Predictions("SC", Lols, ProbitL)
Plotting(SC, "SC")

Sum = Predictions("Sum", Lols, ProbitL)
Plotting(Sum, "Sum")

AE = Predictions("AE", Lols, ProbitL)
Plotting(AE, "AE")

BSky = Predictions("BSky", Lols, ProbitL)
Plotting(BSky, "BSky")

Slnd = Predictions("Slnd", Lols, ProbitL)
Plotting(Slnd, "Slnd")
#Saving "regression tables" to have them for later 
CSV.write("ASunRegTable.csv", ASun)
CSV.write("HorzRegTable.csv", Horz)
CSV.write("PatRegTable.csv", Pat)
CSV.write("SunBeltRegTable.csv", SunBelt)
CSV.write("NECRegTable.csv", NEC)
CSV.write("OVCRegTable.csv", OVC)
CSV.write("BSthRegTable.csv", BSth)
CSV.write("MVCRegTable.csv", MVC)
CSV.write("WCCRegTable.csv", WCC)
CSV.write("CAARegTable.csv", CAA)
CSV.write("SCRegTable.csv", SC)
CSV.write("SumRegTable.csv", Sum)
CSV.write("AERegTable.csv", AE)
CSV.write("BSkyRegTable.csv", BSky)
CSV.write("SlndRegTable.csv", Slnd)
