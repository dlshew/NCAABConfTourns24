using DataFrames, StatsPlots, GLM, CSV, StatsBase

PowerNormAll = CSV.read("PowerNormAll.csv", DataFrame)
HighNormAll = CSV.read("HighNormAll.csv", DataFrame)
LowNormAll = CSV.read("LowNormAll.csv", DataFrame)

#Training the linear ordinary least squares and probit regression
#Also plotting the results
Pols = lm(@formula(Win ~ WAB+OEFG+DEFG+OFTR+DFTR+OFTR+DFTR+OTOR+DTOR+ORB+DRB), PowerNormAll)
PowerNormAll.OLS = predict(Pols)

ProbitP = glm(@formula(Win ~ WAB+OEFG+DEFG+OFTR+DFTR+OFTR+DFTR+OTOR+DTOR+ORB+DRB), PowerNormAll, Binomial(), ProbitLink())
PowerNormAll.Probit = predict(ProbitP)

select!(PowerNormAll, :Team, :Conf, :Year, :Win, :OLS, :Probit)

PowerNormWinners = PowerNormAll[PowerNormAll.Win .== 1, :]
PowerNormLosers = PowerNormAll[PowerNormAll.Win .== 0, :]

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

#loading and applying the linear and probit models to 2024 confs
ASunNorm = CSV.read("AsunNorm.csv", DataFrame)
HorzNorm = CSV.read("HorzNorm.csv", DataFrame)
PatNorm = CSV.read("PatNorm.csv", DataFrame)
SunBeltNorm = CSV.read("SBNorm.csv", DataFrame)
NECNorm = CSV.read("NECNorm.csv", DataFrame)
OVCNorm = CSV.read("OVCNorm.csv", DataFrame)
MVCNorm = CSV.read("MVCNorm.csv", DataFrame)
WCCNorm = CSV.read("WCCNorm.csv", DataFrame)

#Applying the models from above, didn't do any splititng for training and testing.
function Predictions(Conf, TypeOLS, TypePro)
    Conf.OLS = predict(TypeOLS, Conf)
    Conf.Probit = predict(TypePro, Conf)
    sort!(Conf, :Probit, rev=true)
    select!(Conf, :Team, :Conf, :OLS, :Probit)
    return Conf
end
#plotting the predictions
function Plotting(DF, ConfName::String)
    ConfOLS = @df DF scatter(:Team, :OLS, color=:red, title="$ConfName Linear Regression", legend=:none, rotation=45, xflip=true)
    ConfProbit = @df DF scatter(:Team, :OLS, color=:red, title="$ConfName Probit Regression", legend=:none, rotation=45, xflip=true)
    plot(ConfOLS, ConfProbit, layout=(1, 2))
    savefig(ConfName * "RegressionPlots")
end
#calling the above functions
ASun = Predictions(ASunNorm, Lols, ProbitL)
Plotting(ASun, "ASun")

Horz = Predictions(HorzNorm, Lols, ProbitL)
Plotting(Horz, "Horz")

Pat = Predictions(PatNorm, Lols, ProbitL)
Plotting(Pat, "Pat")

SunBelt = Predictions(SunBeltNorm, Lols, ProbitL)
Plotting(SunBelt, "SunBelt")

NEC = Predictions(NECNorm, Lols, ProbitL)
Plotting(NEC, "Nec")

OVC = Predictions(OVCNorm, Lols, ProbitL)
Plotting(OVC, "OVC")

MVC = Predictions(MVCNorm, Lols, ProbitL)
Plotting(MVC, "MVC")

WCC = Predictions(WCCNorm, Lols, ProbitL)
Plotting(WCC, "WCC")
#Saving predictions for later
CSV.write("ASunRegTable.csv", ASun)
CSV.write("HorzRegTable.csv", Horz)
CSV.write("PatRegTable.csv", Pat)
CSV.write("SunBeltRegTable.csv", SunBelt)
CSV.write("NECRegTable.csv", NEC)
CSV.write("OVCRegTable.csv", OVC)
CSV.write("MVCRegTable.csv", MVC)
CSV.write("WCCRegTable.csv", WCC)
