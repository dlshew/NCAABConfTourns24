using CSV, DataFrames, DataFramesMeta, Random, MLJ

PowerRanks = CSV.read("PowerConfAll.csv", DataFrame)
HighRanks = CSV.read("HighConfAll.csv", DataFrame)
LowRanks = CSV.read("LowConfAll.csv", DataFrame)
#creating the random forest of 100 decision trees with max depth 3
Forest = @load RandomForestClassifier pkg=DecisionTree
forest = Forest(max_depth=3, n_trees=100)
#Pretty similar to the decision tree training code
select!(PowerRanks, Not([:WinPer, :BARTHAG]))
shuffle!(PowerRanks)

TrainPower, TestPower = partition(PowerRanks, .75)
yTrainPower, XTrainPower = unpack(TrainPower, ==(:Win))
yTestPower, XTestPower = unpack(TestPower, ==(:Win))
yTrainP = coerce(yTrainPower, Multiclass)


machPower = machine(forest, XTrainPower[:, 4:14], yTrainP) |> fit!
yhatPower = predict(machPower, XTestPower[:, 4:14])
println(log_loss(yhatPower, yTestPower))

select!(HighRanks, Not([:WinPer, :BARTHAG]))
shuffle!(HighRanks)

TrainHigh, TestHigh = partition(HighRanks, .75)
yTrainHigh, XTrainHigh = unpack(TrainHigh, ==(:Win))
yTestHigh, XTestHigh = unpack(TestHigh, ==(:Win))
yTrainH = coerce(yTrainHigh, Multiclass)


machHigh = machine(forest, XTrainHigh[:, 4:14], yTrainH) |> fit!
yhatHigh = predict(machHigh, XTestHigh[:, 4:14])
println(log_loss(yhatHigh, yTestHigh))


select!(LowRanks, Not([:WinPer, :BARTHAG]))
shuffle!(LowRanks)


TrainLow, TestLow = partition(LowRanks, .75)
yTrainLow, XTrainLow = unpack(TrainLow, ==(:Win))
yTestLow, XTestLow = unpack(TestLow, ==(:Win))
yTrainL = coerce(yTrainLow, Multiclass)


machLow = machine(forest, XTrainLow[:, 4:14], yTrainL) |> fit!
yhatLow = predict(machLow, XTestLow[:, 4:14])

println(log_loss(yhatLow, yTestLow))

MLJ.save("PowerForest.jlso", machPower)
MLJ.save("HighForest.jlso", machHigh)
MLJ.save("LowForest.jlso", machLow)
