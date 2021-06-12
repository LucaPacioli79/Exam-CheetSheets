clc
clear all

coupon = 4;
yield = 0.05;
FV = 100;
maturity = 1;
period = 2;   %number of payments in a year. Set = 1 to get yield0 of continuos
price = 102.9;

[price0, priceC, yieldC, yield0, yield0conti] = bonds(price, yield, coupon, FV, maturity, period);