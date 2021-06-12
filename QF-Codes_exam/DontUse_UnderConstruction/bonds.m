function [price0,priceC, yield0, yieldC, yield0conti, dur, mDur, macDur, conv] = bonds(price, yield, coupon, FV, maturity, period)

price0 = FV ./ (1+yield/period)^(period*maturity)

priceC = (coupon ./ yield) * (1- (1/(1+yield)^maturity)) + FV / ((1+yield) ^ maturity)

yield0 = ((FV ./ price)^(1/(period*maturity)) - 1) * period
yield0conti = log(1 + yield0)

yieldC = (1 ./ (price)) ^ (1/maturity) 


end

