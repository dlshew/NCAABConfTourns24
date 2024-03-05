using CSV, DataFrames, DataFramesMeta, Random, MLJ, TreeRecipe, Plots, BSON

PowerRanks = CSV.read("PowerConfAll.csv", DataFrame)
HighRanks = CSV.read("HighConfAll.csv", DataFrame)
LowRanks = CSV.read("LowConfAll.csv", DataFrame)

Tree = @load DecisionTreeClassifier pkg=DecisionTree
ctree = Tree(max_depth=3)


select!(PowerRanks, Not([:WinPer, :BARTHAG]))
shuffle!(PowerRanks)

TrainPower, TestPower = partition(PowerRanks, .75)
yTrainPower, XTrainPower = unpack(TrainPower, ==(:Win))
yTestPower, XTestPower = unpack(TestPower, ==(:Win))
yTrainP = coerce(yTrainPower, Multiclass)


machPower = machine(ctree, XTrainPower[:, 4:14], yTrainP) |> fit!
yhatPower = predict(machPower, XTestPower[:, 4:14])

display([yhatPower yTestPower])
println(log_loss(yhatPower, yTestPower))
println(broadcast(pdf, yhatPower, yTestPower))
display(report(machPower))

treePower = fitted_params(machPower).tree
plot(treePower)
savefig("PowerConfTree.png")


select!(HighRanks, Not([:WinPer, :BARTHAG]))
shuffle!(HighRanks)
show(HighRanks)

TrainHigh, TestHigh = partition(HighRanks, .75)
yTrainHigh, XTrainHigh = unpack(TrainHigh, ==(:Win))
yTestHigh, XTestHigh = unpack(TestHigh, ==(:Win))
yTrainH = coerce(yTrainHigh, Multiclass)


machHigh = machine(ctree, XTrainHigh[:, 4:14], yTrainH) |> fit!
yhatHigh = predict(machHigh, XTestHigh[:, 4:14])

display([yhatHigh yTestHigh])
println(log_loss(yhatHigh, yTestHigh))
println(broadcast(pdf, yhatHigh, yTestHigh))
display(report(machHigh))

treeHigh = fitted_params(machHigh).tree
plot(treeHigh)
savefig("HighConfTree.png")



select!(LowRanks, Not([:WinPer, :BARTHAG]))
shuffle!(LowRanks)

TrainLow, TestLow = partition(LowRanks, .75)
show(TrainLow)
show(TestLow)
yTrainLow, XTrainLow = unpack(TrainLow, ==(:Win))
yTestLow, XTestLow = unpack(TestLow, ==(:Win))
yTrainL = coerce(yTrainLow, Multiclass)


machLow = machine(ctree, XTrainLow[:, 4:14], yTrainL) |> fit!
yhatLow = predict(machLow, XTestLow[:, 4:14])

display([yhatLow yTestLow])
println(log_loss(yhatLow, yTestLow))
println(broadcast(pdf, yhatLow, yTestLow))
display(report(machLow))

treeLow = fitted_params(machLow).tree
plot(treeLow, size=(1280,720))
savefig("LowConfTree.png")

MLJ.save("PowerDecTree.jlso", machPower)
MLJ.save("HighDecTree.jlso", machHigh)
MLJ.save("LowDecTree.jlso", machLow)
