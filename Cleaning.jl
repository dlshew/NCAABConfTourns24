using DataFrames, CSV, StatsBase, DataFramesMeta, StatsPlots, BenchmarkTools

#Reading the CSV files that need to be cleaned
Tor23 = CSV.read("2023RegSeason.csv", DataFrame)
Tor16 = CSV.read("2016RegSeason.csv", DataFrame)

Tor22 = CSV.read("2022RegSeason.csv", DataFrame)
Sum22 = CSV.read("summary22_pt.csv", DataFrame)

Tor21 = CSV.read("2021RegSeason.csv", DataFrame)
Sum21 = CSV.read("summary21_pt.csv", DataFrame)

Tor19 = CSV.read("2019RegSeason.csv", DataFrame)
Sum19 = CSV.read("summary19_pt.csv", DataFrame)

Tor18 = CSV.read("2018RegSeason.csv", DataFrame)
Sum18 = CSV.read("summary18_pt.csv", DataFrame)

Tor17 = CSV.read("2017RegSeason.csv", DataFrame)
Sum17 = CSV.read("summary17_pt.csv", DataFrame)


#For 2017 through 2022 I don't have the conferecnes already in the data sets so these have to be different 
function cleanup2316(df, year)
    rename!(df, :Column1 => :Team, :Column2 => :ADJOE, :Column3 => :ADJDE, :Column4 => :BARTHAG,
    :Column6 => :Wins, :Column7 => :G, :Column8 => :OEFG, :Column9 => :DEFG, :Column10 => :OFTR,
    :Column11 => :DFTR, :Column12 => :OTOR, :Column13 => :DTOR, :Column14 => :ORB, :Column15 => :DRB,
    :Column27 => :ADJTempo, :Column35 => :WAB
    )  
    df.Year .= year
    df.WinPer = df.Wins ./ df.G
    df.Win .= 0
    select!(df, :Team, :Conf, :Year, :WinPer, :ADJTempo, :WAB, :BARTHAG, :ADJOE, :ADJDE, :OEFG, :DEFG, :OFTR, :DFTR, :OTOR, :DTOR, :ORB, :DRB, :Win)
    @subset!(df, :Conf .!= "ind")
end   

function cleanrest(df)
    rename!(df, :Column1 => :Team, :Column2 => :ADJOE, :Column3 => :ADJDE, :Column4 => :BARTHAG,
    :Column6 => :Wins, :Column7 => :G, :Column8 => :OEFG, :Column9 => :DEFG, :Column10 => :OFTR,
    :Column11 => :DFTR, :Column12 => :OTOR, :Column13 => :DTOR, :Column14 => :ORB, :Column15 => :DRB,
    :Column27 => :ADJTempo, :Column35 => :WAB
    )  

    df.WinPer = df.Wins ./ df.G
    df.Win .= 0
end
#Storing the conf values in a dictionary to add them later and dropping indpendents
function addconfs(df1, df2)
    ConfDict = Dict(df1.TeamName .=> df1.Conf)
    df2.Conf = [ConfDict[x] for x in df2.Team]
    @subset!(df2, :Conf .!= "ind")
end 


cleanup2316(Tor23, 23)
cleanup2316(Tor16, 16)
cleanrest(Tor22)
cleanrest(Tor21)
cleanrest(Tor19)
cleanrest(Tor18)
cleanrest(Tor17)

Tor23.Team = replace.(Tor23.Team, "College of Charleston" => "Charleston")
Tor23.Team = replace.(Tor23.Team, "Louisiana Lafayette" => "Louisiana")

Cleaned23 = Tor23
Cleaned16 = Tor16

#Replacing team names so the datasets match so I can add conferences
Tor22.Team = replace.(Tor22.Team, "North Carolina St." => "N.C. State")
Tor22.Team = replace.(Tor22.Team, "Utah Tech" => "Dixie St.")
Tor22.Team = replace.(Tor22.Team, "Fort Wayne" => "Purdue Fort Wayne")
Tor22.Team = replace.(Tor22.Team, "College of Charleston" => "Charleston")
Tor22.Team = replace.(Tor22.Team, "Houston Christian" => "Houston Baptist")
Tor22.Team = replace.(Tor22.Team, "Louisiana Lafayette" => "Louisiana")
Tor22.Team = replace.(Tor22.Team, "LIU Brooklyn" => "LIU")
Tor22.Team = replace.(Tor22.Team, "Detroit" => "Detroit Mercy")
Tor22.Year .= 22
addconfs(Sum22, Tor22)
Cleaned22 = select(Tor22, :Team, :Conf, :Year, :WinPer, :ADJTempo, :WAB, :BARTHAG, :ADJOE, :ADJDE, :OEFG, :DEFG, :OFTR, :DFTR, :OTOR, :DTOR, :ORB, :DRB, :Win)

Tor21.Team = replace.(Tor21.Team, "North Carolina St." => "N.C. State")
Tor21.Team = replace.(Tor21.Team, "Utah Tech" => "Dixie St.")
Tor21.Team = replace.(Tor21.Team, "Fort Wayne" => "Purdue Fort Wayne")
Tor21.Team = replace.(Tor21.Team, "College of Charleston" => "Charleston")
Tor21.Team = replace.(Tor21.Team, "Houston Christian" => "Houston Baptist")
Tor21.Team = replace.(Tor21.Team, "Louisiana Lafayette" => "Louisiana")
Tor21.Team = replace.(Tor21.Team, "LIU Brooklyn" => "LIU")
Tor21.Year .= 21
addconfs(Sum21, Tor21)
Cleaned21 = select(Tor21, :Team, :Conf, :Year, :WinPer, :ADJTempo, :WAB, :BARTHAG, :ADJOE, :ADJDE, :OEFG, :DEFG, :OFTR, :DFTR, :OTOR, :DTOR, :ORB, :DRB, :Win)


Tor19.Team = replace.(Tor19.Team, "North Carolina St." => "N.C. State")
Tor19.Team = replace.(Tor19.Team, "Utah Tech" => "Dixie St.")
Tor19.Team = replace.(Tor19.Team, "Fort Wayne" => "Purdue Fort Wayne")
Tor19.Team = replace.(Tor19.Team, "College of Charleston" => "Charleston")
Tor19.Team = replace.(Tor19.Team, "Houston Christian" => "Houston Baptist")
Tor19.Team = replace.(Tor19.Team, "Louisiana Lafayette" => "Louisiana")
Tor19.Year .= 19
addconfs(Sum19, Tor19)
Cleaned19 = select(Tor19, :Team, :Conf, :Year, :WinPer, :ADJTempo, :WAB, :BARTHAG, :ADJOE, :ADJDE, :OEFG, :DEFG, :OFTR, :DFTR, :OTOR, :DTOR, :ORB, :DRB, :Win)


Tor18.Team = replace.(Tor18.Team, "Utah Tech" => "Dixie St.")
Tor18.Team = replace.(Tor18.Team, "Houston Christian" => "Houston Baptist")
Tor18.Year .= 18
addconfs(Sum18, Tor18)
Cleaned18 = select(Tor18, :Team, :Conf, :Year, :WinPer, :ADJTempo, :WAB, :BARTHAG, :ADJOE, :ADJDE, :OEFG, :DEFG, :OFTR, :DFTR, :OTOR, :DTOR, :ORB, :DRB, :Win)


Tor17.Team = replace.(Tor17.Team, "Utah Tech" => "Dixie St.")
Tor17.Team = replace.(Tor17.Team, "Houston Christian" => "Houston Baptist")
Tor17.Year .= 17
addconfs(Sum17, Tor17)
Cleaned17 = select(Tor17, :Team, :Conf, :Year, :WinPer, :ADJTempo, :WAB, :BARTHAG, :ADJOE, :ADJDE, :OEFG, :DEFG, :OFTR, :DFTR, :OTOR, :DTOR, :ORB, :DRB, :Win)
#Vectors of conference winners by year
Winners23 = ["Vermont", "Memphis", "VCU", "Duke", "Kennesaw St.", "Texas", "Marquette", "Montana St.",
"UNC Asheville", "Purdue", "UC Santa Barbara", "Charleston", "Florida Atlantic", "Northern Kentucky", 
"Princeton", "Iona", "Kent St.", "Howard", "Drake", "San Diego St.", "Merrimack", "Southeast Missouri St.",
"Arizona", "Colgate", "Alabama", "Furman", "Texas A&M Corpus Chris", "Texas Southern", "Oral Roberts",
"Louisiana", "Gonzaga", "Grand Canyon"]

Winners22 = ["Houston", "Virginia Tech", "Vermont", "Richmond", "Bellarmine", "Kansas", "Villanova",
"Montana St.", "Longwood", "Iowa", "Cal St. Fullerton", "Delaware", "UAB", "Wright St.",
"Yale", "Saint Peter's", "Akron", "Norfolk St.", "Loyola Chicago", "Boise St.", "Bryant", 
"Murray St.", "Arizona", "Colgate", "Tennessee", "Chattanooga", "Texas A&M Corpus Chris",
"South Dakota St.", "Georgia St.", "Texas Southern", "New Mexico St.", "Gonzaga"]

Winners21 = ["Houston", "Georgia Tech", "Hartford", "St. Bonaventure", "Liberty", "Texas",
"Georgetown", "Eastern Washington", "Winthrop", "Illinois", "UC Santa Barbara", "Drexel",
"North Texas", "Cleveland St.", "Iona", "Ohio", "Norfolk St.", "Loyola Chicago", 
"San Diego St.", "Mount St. Mary's", "Morehead St.", "Oregon St.", "Colgate", "Alabama",
"UNC Greensboro", "Abilene Christian", "Oral Roberts", "Appalachian St.", "Texas Southern",
"Grand Canyon", "Gonzaga"]

Winners19 = ["Cincinnati", "Duke", "Vermont", "Saint Louis", "Liberty", "Iowa St.",
"Villanova", "Montana", "Gardner Webb", "Michigan St.", "UC Irvine", "Northeastern",
"Old Dominion", "Northern Kentucky", "Yale", "Iona", "Buffalo", "North Carolina Central",
"Bradley", "Utah St.", "Fairleigh Dickinson", "Murray St.", "Oregon", "Colgate", "Auburn",
"Wofford", "Abilene Christian", "North Dakota St.", "Georgia St.", "Prairie View A&M", 
"New Mexico St.", "Saint Mary's"]

Winners18 = ["Cincinnati", "Virginia", "UMBC", "Davidson", "Lipscomb", "Kansas", "Villanova",
"Montana", "Radford", "Michigan", "Cal St. Fullerton", "College of Charleston", "Marshall", 
"Wright St.", "Penn", "Iona", "Buffalo", "North Carolina Central", "Loyola Chicago", "San Diego St.",
"LIU Brooklyn", "Murray St.", "Arizona", "Bucknell", "Kentucky", "UNC Greensboro", "Stephen F. Austin",
"South Dakota St.", "Georgia St.", "Texas Southern", "New Mexico St.", "Gonzaga"]

Winners17 = ["SMU", "Duke", "Vermont", "Rhode Island", "Florida Gulf Coast", "Iowa St.", "Villanova",
"North Dakota", "Winthrop", "Michigan", "UC Davis", "UNC Wilmington", "Middle Tennessee", "Northern Kentucky",
"Princeton", "Iona", "Kent St.", "North Carolina Central", "Wichita St.", "Nevada",
"Mount St. Mary's", "Jacksonville St.", "Arizona", "Bucknell", "Kentucky", "East Tennessee St.", 
"New Orleans", "South Dakota St.", "Troy", "Texas Southern", "New Mexico St.", "Gonzaga"]

Winners16 = ["Connecticut", "North Carolina", "Stony Brook", "Saint Joseph's", "Florida Gulf Coast", 
"Kansas", "Seton Hall", "Weber St.", "UNC Asheville", "Michigan St.", "Hawaii", "UNC Wilmington",
"Middle Tennessee", "Green Bay", "Iona", "Buffalo", "Hampton", "Northern Iowa", "Fresno St.", 
"Fairleigh Dickinson", "Austin Peay", "Oregon", "Holy Cross", "Kentucky", "Chattanooga", 
"Stephen F. Austin", "South Dakota St.", "Little Rock", "Southern", "Cal St. Bakersfield", "Gonzaga" ]
#if the team is a winner adding a 1 to their win column
function Win(df, winners)
    Winners = subset(df, :Team => ByRow(∈(winners)), skipmissing=true)
    Losers = subset(df, :Team => ByRow(∉(winners)), skipmissing=true)
    Winners.Win .= 1
    df = vcat(Winners, Losers)
    return df
end 

Cleaned23 = Win(Cleaned23, Winners23)
Cleaned22 = Win(Cleaned22, Winners22)
Cleaned21 = Win(Cleaned21, Winners21)
Cleaned19 = Win(Cleaned19, Winners19)
Cleaned18 = Win(Cleaned18, Winners18)
Cleaned17 = Win(Cleaned17, Winners17)
Cleaned16 = Win(Cleaned16, Winners16)

#Ranking teams by their stats compared to the teams in their conferences
function Ranks(df, year)
    Data = "ConfRanks$year"
    Data = groupby(df, :Conf)
    Rank = @select(Data, :Team, :Conf, :Year, :WinPer = ordinalrank(:WinPer, rev=true), :WAB = competerank(:WAB, rev=true),
    :BARTHAG = competerank(:BARTHAG, rev=true), :ADJOE = competerank(:ADJOE, rev=true), :ADJDE = competerank(:ADJDE), 
    :OEFG = competerank(:OEFG, rev=true), :DEFG = competerank(:DEFG), :OFTR = competerank(:OFTR, rev=true),
    :DFTR = competerank(:DFTR), :OTOR = competerank(:OTOR), :DTOR = competerank(:DTOR, rev=true), :ORB = competerank(:ORB, rev=true),
    :DRB = competerank(:DRB, rev=true), :Win)
    return Rank
end

ConfRanks23 = Ranks(Cleaned23, 23)
ConfRanks22 = Ranks(Cleaned22, 22)
ConfRanks21 = Ranks(Cleaned21, 21)
ConfRanks19 = Ranks(Cleaned19, 19)
ConfRanks18 = Ranks(Cleaned18, 18)
ConfRanks17 = Ranks(Cleaned17, 17)
ConfRanks16 = Ranks(Cleaned16, 16)

#Creating a whole lot of CSV files and split datasets (mostly for no reason)
ConfRanks23Winners = subset(ConfRanks23, :Team => ByRow(∈(Winners23)), skipmissing=true)
ConfRanks23Losers = subset(ConfRanks23, :Team => ByRow(∉(Winners23)), skipmissing=true)

ConfRanks22Winners = subset(ConfRanks22, :Team => ByRow(∈(Winners22)), skipmissing=true)
ConfRanks22Losers = subset(ConfRanks22, :Team => ByRow(∉(Winners22)), skipmissing=true)

ConfRanks21Winners = subset(ConfRanks21, :Team => ByRow(∈(Winners21)), skipmissing=true)
ConfRanks21Losers = subset(ConfRanks21, :Team => ByRow(∉(Winners21)), skipmissing=true)

ConfRanks19Winners = subset(ConfRanks19, :Team => ByRow(∈(Winners19)), skipmissing=true)
ConfRanks19Losers = subset(ConfRanks19, :Team => ByRow(∉(Winners19)), skipmissing=true)

ConfRanks18Winners = subset(ConfRanks18, :Team => ByRow(∈(Winners18)), skipmissing=true)
ConfRanks18Losers = subset(ConfRanks18, :Team => ByRow(∉(Winners18)), skipmissing=true)

ConfRanks17Winners = subset(ConfRanks17, :Team => ByRow(∈(Winners17)), skipmissing=true)
ConfRanks17Losers = subset(ConfRanks17, :Team => ByRow(∉(Winners17)), skipmissing=true)

ConfRanks16Winners = subset(ConfRanks16, :Team => ByRow(∈(Winners16)), skipmissing=true)
ConfRanks16Losers = subset(ConfRanks16, :Team => ByRow(∉(Winners16)), skipmissing=true)



Normalized23 = @transform(Cleaned23, :WinPer = zscore(:WinPer), :ADJTempo = zscore(:ADJTempo), :WAB = zscore(:WAB), :BARTHAG = zscore(:BARTHAG), :ADJOE = zscore(:ADJOE), :ADJDE = zscore(:ADJDE),
:OEFG = zscore(:OEFG), :DEFG = zscore(:DEFG), :OFTR = zscore(:OFTR), :DFTR = zscore(:DFTR), :OTOR = zscore(:OTOR), :DTOR = zscore(:DTOR), :ORB = zscore(:ORB), :DRB = zscore(:DRB))

Normalized22 = @transform(Cleaned22, :WinPer = zscore(:WinPer), :ADJTempo = zscore(:ADJTempo), :WAB = zscore(:WAB), :BARTHAG = zscore(:BARTHAG), :ADJOE = zscore(:ADJOE), :ADJDE = zscore(:ADJDE),
:OEFG = zscore(:OEFG), :DEFG = zscore(:DEFG), :OFTR = zscore(:OFTR), :DFTR = zscore(:DFTR), :OTOR = zscore(:OTOR), :DTOR = zscore(:DTOR), :ORB = zscore(:ORB), :DRB = zscore(:DRB))

Normalized21 = @transform(Cleaned21, :WinPer = zscore(:WinPer), :ADJTempo = zscore(:ADJTempo), :WAB = zscore(:WAB), :BARTHAG = zscore(:BARTHAG), :ADJOE = zscore(:ADJOE), :ADJDE = zscore(:ADJDE),
:OEFG = zscore(:OEFG), :DEFG = zscore(:DEFG), :OFTR = zscore(:OFTR), :DFTR = zscore(:DFTR), :OTOR = zscore(:OTOR), :DTOR = zscore(:DTOR), :ORB = zscore(:ORB), :DRB = zscore(:DRB))

Normalized19 = @transform(Cleaned19, :WinPer = zscore(:WinPer), :ADJTempo = zscore(:ADJTempo), :WAB = zscore(:WAB), :BARTHAG = zscore(:BARTHAG), :ADJOE = zscore(:ADJOE), :ADJDE = zscore(:ADJDE),
:OEFG = zscore(:OEFG), :DEFG = zscore(:DEFG), :OFTR = zscore(:OFTR), :DFTR = zscore(:DFTR), :OTOR = zscore(:OTOR), :DTOR = zscore(:DTOR), :ORB = zscore(:ORB), :DRB = zscore(:DRB))

Normalized18 = @transform(Cleaned18, :WinPer = zscore(:WinPer), :ADJTempo = zscore(:ADJTempo), :WAB = zscore(:WAB), :BARTHAG = zscore(:BARTHAG), :ADJOE = zscore(:ADJOE), :ADJDE = zscore(:ADJDE),
:OEFG = zscore(:OEFG), :DEFG = zscore(:DEFG), :OFTR = zscore(:OFTR), :DFTR = zscore(:DFTR), :OTOR = zscore(:OTOR), :DTOR = zscore(:DTOR), :ORB = zscore(:ORB), :DRB = zscore(:DRB))

Normalized17 = @transform(Cleaned17, :WinPer = zscore(:WinPer), :ADJTempo = zscore(:ADJTempo), :WAB = zscore(:WAB), :BARTHAG = zscore(:BARTHAG), :ADJOE = zscore(:ADJOE), :ADJDE = zscore(:ADJDE),
:OEFG = zscore(:OEFG), :DEFG = zscore(:DEFG), :OFTR = zscore(:OFTR), :DFTR = zscore(:DFTR), :OTOR = zscore(:OTOR), :DTOR = zscore(:DTOR), :ORB = zscore(:ORB), :DRB = zscore(:DRB))

Normalized16 = @transform(Cleaned16, :WinPer = zscore(:WinPer), :ADJTempo = zscore(:ADJTempo), :WAB = zscore(:WAB), :BARTHAG = zscore(:BARTHAG), :ADJOE = zscore(:ADJOE), :ADJDE = zscore(:ADJDE),
:OEFG = zscore(:OEFG), :DEFG = zscore(:DEFG), :OFTR = zscore(:OFTR), :DFTR = zscore(:DFTR), :OTOR = zscore(:OTOR), :DTOR = zscore(:DTOR), :ORB = zscore(:ORB), :DRB = zscore(:DRB))

Normalized23Winners = subset(Normalized23, :Team => ByRow(∈(Winners23)), skipmissing=true)
Normalized23Losers = subset(Normalized23, :Team => ByRow(∉(Winners23)), skipmissing=true)

Normalized22Winners = subset(Normalized22, :Team => ByRow(∈(Winners22)), skipmissing=true)
Normalized22Losers = subset(Normalized22, :Team => ByRow(∉(Winners22)), skipmissing=true)

Normalized21Winners = subset(Normalized21, :Team => ByRow(∈(Winners21)), skipmissing=true)
Normalized21Losers = subset(Normalized21, :Team => ByRow(∉(Winners21)), skipmissing=true)

Normalized19Winners = subset(Normalized19, :Team => ByRow(∈(Winners19)), skipmissing=true)
Normalized19Losers = subset(Normalized19, :Team => ByRow(∉(Winners19)), skipmissing=true)

Normalized18Winners = subset(Normalized18, :Team => ByRow(∈(Winners18)), skipmissing=true)
Normalized18Losers = subset(Normalized18, :Team => ByRow(∉(Winners18)), skipmissing=true)

Normalized17Winners = subset(Normalized17, :Team => ByRow(∈(Winners17)), skipmissing=true)
Normalized17Losers = subset(Normalized17, :Team => ByRow(∉(Winners17)), skipmissing=true)

Normalized16Winners = subset(Normalized16, :Team => ByRow(∈(Winners16)), skipmissing=true)
Normalized16Losers = subset(Normalized16, :Team => ByRow(∉(Winners16)), skipmissing=true)
#Choosing the power high and low confs (every one not shown is "low")/still mostly doing unnecessary splits and groupings 
Power = ["ACC", "Big East", "B10", "B12", "P12", "SEC"]
High = ["Amer", "A10", "MWC", "WCC"]



Power23Norm = subset(Normalized23, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power23Norm, :Conf)

High23Norm = subset(Normalized23, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High23Norm, :Conf)

Low23Norm = subset(Normalized23, :Conf => ByRow(∉(Power)), skipmissing=true)
Low23Norm = subset(Low23Norm, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low23Norm, :Conf)


Power22Norm = subset(Normalized22, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power22Norm, :Conf)

High22Norm = subset(Normalized22, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High22Norm, :Conf)

Low22Norm = subset(Normalized22, :Conf => ByRow(∉(Power)), skipmissing=true)
Low22Norm = subset(Low22Norm, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low22Norm, :Conf)


Power21Norm = subset(Normalized21, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power21Norm, :Conf)

High21Norm = subset(Normalized21, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High21Norm, :Conf)

Low21Norm = subset(Normalized21, :Conf => ByRow(∉(Power)), skipmissing=true)
Low21Norm = subset(Low21Norm, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low21Norm, :Conf)


Power19Norm = subset(Normalized19, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power19Norm, :Conf)

High19Norm = subset(Normalized19, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High19Norm, :Conf)

Low19Norm = subset(Normalized19, :Conf => ByRow(∉(Power)), skipmissing=true)
Low19Norm = subset(Low19Norm, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low19Norm, :Conf)


Power18Norm = subset(Normalized18, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power18Norm, :Conf)

High18Norm = subset(Normalized18, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High18Norm, :Conf)

Low18Norm = subset(Normalized18, :Conf => ByRow(∉(Power)), skipmissing=true)
Low18Norm = subset(Low18Norm, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low18Norm, :Conf)


Power17Norm = subset(Normalized17, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power17Norm, :Conf)

High17Norm = subset(Normalized17, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High17Norm, :Conf)

Low17Norm = subset(Normalized17, :Conf => ByRow(∉(Power)), skipmissing=true)
Low17Norm = subset(Low17Norm, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low17Norm, :Conf)


Power16Norm = subset(Normalized16, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power17Norm, :Conf)

High16Norm = subset(Normalized16, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High16Norm, :Conf)

Low16Norm = subset(Normalized16, :Conf => ByRow(∉(Power)), skipmissing=true)
Low16Norm = subset(Low16Norm, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low16Norm, :Conf)



Power23Conf = subset(ConfRanks23, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power23Conf, :Conf)

High23Conf = subset(ConfRanks23, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High23Conf, :Conf)

Low23Conf = subset(ConfRanks23, :Conf => ByRow(∉(Power)), skipmissing=true)
Low23Conf = subset(Low23Conf, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low23Conf, :Conf)

Power22Conf = subset(ConfRanks22, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power22Conf, :Conf)

High22Conf = subset(ConfRanks22, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High22Conf, :Conf)

Low22Conf = subset(ConfRanks22, :Conf => ByRow(∉(Power)), skipmissing=true)
Low22Conf = subset(Low22Conf, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low22Conf, :Conf)

Power21Conf = subset(ConfRanks21, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power21Conf, :Conf)

High21Conf = subset(ConfRanks21, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High21Conf, :Conf)

Low21Conf = subset(ConfRanks21, :Conf => ByRow(∉(Power)), skipmissing=true)
Low21Conf = subset(Low21Conf, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low21Conf, :Conf)

Power19Conf = subset(ConfRanks19, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power19Conf, :Conf)

High19Conf = subset(ConfRanks19, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High19Conf, :Conf)

Low19Conf = subset(ConfRanks19, :Conf => ByRow(∉(Power)), skipmissing=true)
Low19Conf = subset(Low19Conf, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low19Conf, :Conf)

Power18Conf = subset(ConfRanks18, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power18Conf, :Conf)

High18Conf = subset(ConfRanks18, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High18Conf, :Conf)

Low18Conf = subset(ConfRanks18, :Conf => ByRow(∉(Power)), skipmissing=true)
Low18Conf = subset(Low18Conf, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low18Conf, :Conf)

Power17Conf = subset(ConfRanks17, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power17Conf, :Conf)

High17Conf = subset(ConfRanks17, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High17Conf, :Conf)

Low17Conf = subset(ConfRanks17, :Conf => ByRow(∉(Power)), skipmissing=true)
Low17Conf = subset(Low17Conf, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low17Conf, :Conf)

Power16Conf = subset(ConfRanks16, :Conf => ByRow(∈(Power)), skipmissing=true)
sort!(Power16Conf, :Conf)

High16Conf = subset(ConfRanks16, :Conf => ByRow(∈(High)), skipmissing=true)
sort!(High16Conf, :Conf)

Low16Conf = subset(ConfRanks16, :Conf => ByRow(∉(Power)), skipmissing=true)
Low16Conf = subset(Low16Conf, :Conf => ByRow(∉(High)), skipmissing=true)
sort!(Low16Conf, :Conf)

PowerConfAll = vcat(Power23Conf, Power22Conf, Power21Conf, Power19Conf, Power18Conf, Power17Conf, Power16Conf)
HighConfAll = vcat(High23Conf, High22Conf, High21Conf, High19Conf, High18Conf, High17Conf, High16Conf)
LowConfAll = vcat(Low23Conf, Low22Conf, Low21Conf, Low19Conf, Low18Conf, Low17Conf, Low16Conf)

PowerConfWinners = PowerConfAll[PowerConfAll.Win .== 1, :]
HighConfWinners = HighConfAll[HighConfAll.Win .== 1, :]
LowConfWinners = LowConfAll[LowConfAll.Win .== 1, :]

PowerConfLosers = PowerConfAll[PowerConfAll.Win .== 0, :]
HighConfLosers = HighConfAll[HighConfAll.Win .== 0, :]
LowConfLosers = LowConfAll[LowConfAll.Win .== 0, :]

#Mostly the files were actually going to use 
PowerNormAll = vcat(Power23Norm, Power22Norm, Power21Norm, Power19Norm, Power18Norm, Power17Norm, Power16Norm)
HighNormAll = vcat(High23Norm, High22Norm, High21Norm, High19Norm, High18Norm, High17Norm, High16Norm)
LowNormAll = vcat(Low23Norm, Low22Norm, Low21Norm, Low19Norm, Low18Norm, Low17Norm, Low16Norm)

PowerNormWinners = PowerNormAll[PowerNormAll.Win .== 1, :]
HighNormWinners = HighNormAll[HighNormAll.Win .== 1, :]
LowNormWinners = LowNormAll[LowNormAll.Win .== 1, :]

PowerNormLosers = PowerNormAll[PowerNormAll.Win .== 0, :]
HighNormLosers = HighNormAll[HighNormAll.Win .== 0, :]
LowNormLosers = LowNormAll[LowNormAll.Win .== 0, :]
#Saving everything that was split and grouped
CSV.write("Clean23.csv", Cleaned23)
CSV.write("Clean22.csv", Cleaned22)
CSV.write("Clean21.csv", Cleaned21)
CSV.write("Clean19.csv", Cleaned19)
CSV.write("Clean18.csv", Cleaned18)
CSV.write("Clean17.csv", Cleaned17)
CSV.write("Clean16.csv", Cleaned16)

CSV.write("ConfRanks23.csv", ConfRanks23)
CSV.write("ConfRanks22.csv", ConfRanks22)
CSV.write("ConfRanks21.csv", ConfRanks21)
CSV.write("ConfRanks19.csv", ConfRanks19)
CSV.write("ConfRanks18.csv", ConfRanks18)
CSV.write("ConfRanks17.csv", ConfRanks17)
CSV.write("ConfRanks16.csv", ConfRanks16)

CSV.write("ConfRanks23Winners.csv", ConfRanks23Winners)
CSV.write("ConfRanks22Winners.csv", ConfRanks22Winners)
CSV.write("ConfRanks21Winners.csv", ConfRanks21Winners)
CSV.write("ConfRanks19Winners.csv", ConfRanks19Winners)
CSV.write("ConfRanks18Winners.csv", ConfRanks18Winners)
CSV.write("ConfRanks17Winners.csv", ConfRanks17Winners)
CSV.write("ConfRanks16Winners.csv", ConfRanks16Winners)

CSV.write("ConfRanks23Losers.csv", ConfRanks23Losers)
CSV.write("ConfRanks22Losers.csv", ConfRanks22Losers)
CSV.write("ConfRanks21Losers.csv", ConfRanks21Losers)
CSV.write("ConfRanks19Losers.csv", ConfRanks19Losers)
CSV.write("ConfRanks18Losers.csv", ConfRanks18Losers)
CSV.write("ConfRanks17Losers.csv", ConfRanks17Losers)
CSV.write("ConfRanks16Losers.csv", ConfRanks16Losers)

CSV.write("Normlized23.csv", Normalized23)
CSV.write("Normlized22.csv", Normalized22)
CSV.write("Normlized21.csv", Normalized21)
CSV.write("Normlized19.csv", Normalized19)
CSV.write("Normlized18.csv", Normalized18)
CSV.write("Normlized17.csv", Normalized17)
CSV.write("Normlized16.csv", Normalized16)

CSV.write("Normalized23Winners.csv", Normalized23Winners)
CSV.write("Normalized22Winners.csv", Normalized22Winners)
CSV.write("Normalized21Winners.csv", Normalized21Winners)
CSV.write("Normalized19Winners.csv", Normalized19Winners)
CSV.write("Normalized18Winners.csv", Normalized18Winners)
CSV.write("Normalized17Winners.csv", Normalized17Winners)
CSV.write("Normalized16Winners.csv", Normalized16Winners)

CSV.write("Normalized23Losers.csv", Normalized23Losers)
CSV.write("Normalized22Losers.csv", Normalized22Losers)
CSV.write("Normalized21Losers.csv", Normalized21Losers)
CSV.write("Normalized19Losers.csv", Normalized19Losers)
CSV.write("Normalized18Losers.csv", Normalized18Losers)
CSV.write("Normalized17Losers.csv", Normalized17Losers)
CSV.write("Normalized16Losers.csv", Normalized16Losers)

CSV.write("Power23Norm.csv", Power23Norm)
CSV.write("High23Norm.csv", High23Norm)
CSV.write("Low23Norm.csv", Low23Norm)

CSV.write("Power22Norm.csv", Power22Norm)
CSV.write("High22Norm.csv", High22Norm)
CSV.write("Low22Norm.csv", Low22Norm)

CSV.write("Power21Norm.csv", Power21Norm)
CSV.write("High21Norm.csv", High21Norm)
CSV.write("Low21Norm.csv", Low21Norm)

CSV.write("Power19Norm.csv", Power19Norm)
CSV.write("High19Norm.csv", High19Norm)
CSV.write("Low19Norm.csv", Low19Norm)

CSV.write("Power18Norm.csv", Power18Norm)
CSV.write("High18Norm.csv", High18Norm)
CSV.write("Low18Norm.csv", Low18Norm)

CSV.write("Power17Norm.csv", Power17Norm)
CSV.write("High17Norm.csv", High17Norm)
CSV.write("Low17Norm.csv", Low17Norm)

CSV.write("Power16Norm.csv", Power16Norm)
CSV.write("High16Norm.csv", High16Norm)
CSV.write("Low16Norm.csv", Low16Norm)

CSV.write("Power23Conf.csv", Power23Conf)
CSV.write("High23Conf.csv", High23Conf)
CSV.write("Low23Conf.csv", Low23Conf)

CSV.write("Power22Conf.csv", Power22Conf)
CSV.write("High22Conf.csv", High22Conf)
CSV.write("Low22Conf.csv", Low22Conf)

CSV.write("Power21Conf.csv", Power21Conf)
CSV.write("High21Conf.csv", High21Conf)
CSV.write("Low21Conf.csv", Low21Conf)

CSV.write("Power19Conf.csv", Power19Conf)
CSV.write("High19Conf.csv", High19Conf)
CSV.write("Low19Conf.csv", Low19Conf)

CSV.write("Power18Conf.csv", Power18Conf)
CSV.write("High18Conf.csv", High18Conf)
CSV.write("Low18Conf.csv", Low18Conf)

CSV.write("Power17Conf.csv", Power17Conf)
CSV.write("High17Conf.csv", High17Conf)
CSV.write("Low17Conf.csv", Low17Conf)

CSV.write("Power16Conf.csv", Power16Conf)
CSV.write("High16Conf.csv", High16Conf)
CSV.write("Low16Conf.csv", Low16Conf)

CSV.write("PowerNormAll.csv", PowerNormAll)
CSV.write("HighNormAll.csv", HighNormAll)
CSV.write("LowNormAll.csv", LowNormAll)

CSV.write("PowerConfAll.csv", PowerConfAll)
CSV.write("HighConfAll.csv", HighConfAll)
CSV.write("LowConfAll.csv", LowConfAll)

CSV.write("PowerConfWinners.csv", PowerConfWinners)
CSV.write("HighConfWinners.csv", HighConfWinners)
CSV.write("LowConfWinners.csv", LowConfWinners)

CSV.write("PowerConfLosers.csv", PowerConfLosers)
CSV.write("HighConfLosers.csv", HighConfLosers)
CSV.write("LowConfLosers.csv", LowConfLosers)

CSV.write("PowerNormWinners.csv", PowerNormWinners)
CSV.write("HighNormWinners.csv", HighNormWinners)
CSV.write("LowNormWinners.csv", LowNormWinners)

CSV.write("PowerNormLosers.csv", PowerNormLosers)
CSV.write("HighNormLosers.csv", HighNormLosers)
CSV.write("LowNormLosers.csv", LowNormLosers)


#Getting the 2024 data ready for predictions
Tor24 = CSV.read("2024RegSeason.csv", DataFrame)
Priors24 = CSV.read("Priors24.csv", DataFrame)
select!(Priors24, :TeamName, :Conf)

cleanrest(Tor24)
Tor24.Team = replace.(Tor24.Team, "North Carolina St." => "N.C. State")
Tor24.Team = replace.(Tor24.Team, "St. Francis PA" => "Saint Francis")
Tor24.Team = replace.(Tor24.Team, "Fort Wayne" => "Purdue Fort Wayne")
Tor24.Team = replace.(Tor24.Team, "College of Charleston" => "Charleston")
Tor24.Team = replace.(Tor24.Team, "Louisiana Lafayette" => "Louisiana")
Tor24.Team = replace.(Tor24.Team, "LIU Brooklyn" => "LIU")
Tor24.Team = replace.(Tor24.Team, "Detroit" => "Detroit Mercy")

addconfs(Priors24, Tor24)
Tor24.Year .= 24
Cleaned24 = select(Tor24, :Team, :Conf, :Year, :WinPer, :ADJTempo, :WAB, :BARTHAG, :ADJOE, :ADJDE, :OEFG, :DEFG, :OFTR, :DFTR, :OTOR, :DTOR, :ORB, :DRB, :Win)


function PullConf(Df, Conference, Year)
    Conf = subset(Df, :Conf => ByRow(∈([Conference])), skipmissing=true)
    ConfNorm = @transform(Conf, :WinPer = zscore(:WinPer), :ADJTempo = zscore(:ADJTempo), :WAB = zscore(:WAB), :BARTHAG = zscore(:BARTHAG), :ADJOE = zscore(:ADJOE), :ADJDE = zscore(:ADJDE),
    :OEFG = zscore(:OEFG), :DEFG = zscore(:DEFG), :OFTR = zscore(:OFTR), :DFTR = zscore(:DFTR), :OTOR = zscore(:OTOR), :DTOR = zscore(:DTOR), :ORB = zscore(:ORB), :DRB = zscore(:DRB))
    ConfRanks = Ranks(Conf, Year)

    CSV.write(Conference * "Norm.csv", ConfNorm)
    CSV.write(Conference * "Ranks.csv", ConfRanks)
end


PullConf(Cleaned24, "ASun", 24)
PullConf(Cleaned24, "Horz", 24)
PullConf(Cleaned24, "Pat", 24)
PullConf(Cleaned24, "SB", 24)
PullConf(Cleaned24, "NEC", 24)
PullConf(Cleaned24, "OVC", 24)
PullConf(Cleaned24, "MVC", 24)
PullConf(Cleaned24, "WCC", 24)



