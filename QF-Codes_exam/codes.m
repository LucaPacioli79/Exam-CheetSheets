clc
clear
close all


%%%%%%%%% Bonds %%%%


% Duration, Modified Duration, Macaulay duration, DVBP (dollar value basis
% point)

Price = [97.10; ];
CouponRate = 0.04;
Settle   = datenum('01-Jan-2000');
Maturity = datenum('01-Jan-2003'); %need to change to year according to maturity
MaturityManual = 3 %for calc of the yield to calculate Mac duration

Period = 1;

Basis = 0;

[ModDuration, YearDuration, PerDuration] = bnddurp(Price,...
CouponRate, Settle, Maturity, Period, Basis)

yield = 1 ./ (Price) ^ (1/MaturityManual)

MacDur = (1 + yield) .* ModDuration
DVBP = ModDuration .* 0.0001


% Convexity (Bond and Dollar) 

Yield = [0.05];
CouponRate = 0.04;
Settle   = datenum('24-Jun-2000');
Maturity = datenum('24-Jun-2005'); %need to change to year according to maturity

Period = 1;  %changes how often per year interest is accrued


Basis = 0;
[YearConvexity, PerConvexity]=bndconvy(Yield, CouponRate,...
Settle, Maturity, Period, Basis)

DollarConvexity = YearConvexity .* Yield

price0 = 100;
deltaYield = 0.001;

changeInPrice = -ModDuration .* price0 * deltaYield + ( -0.5 * YearConvexity * price0 *deltaYield^2)

YearConvexity = 50;
ModDuration = 7;
changeInPrice = -ModDuration .* price0 * deltaYield + ( -0.5 * YearConvexity * price0 *deltaYield^2)

%%% Zero coupon convexity 

maturity = 5;
yield = 0.05;


T = maturity; 
zeroCouponConvexity = ((T+1)*T) ./ ((1+yield)^2),

%%%% Coupon Bonds

% Price

Yield = [0.05;]; 
CouponRate = 0.04; 

Settle   = datenum('01-Jan-2000');
Maturity = datenum('01-Jan-2003'); %need to change to year according to maturity
Period = 1; 
Basis = 0; 

[PriceCouponBond, AccruedInt] = bndprice(Yield, CouponRate, Settle,...
Maturity, Period, Basis)

% Yield - THIS SHIT DOESNT WORK FOR SOME REASON. BONDS LECTURE SLIDE 20

Price = [102.9;];

CouponRate = 0.04;

Settle   = datenum('01-Jan-2000');
Maturity = datenum('01-Jan-2001'); %need to change to year according to maturity
Period = 2;
Basis = 0;

YieldCouponBond = bndyield(Price, CouponRate, Settle,...
Maturity, Period, Basis)




%%%% Zero coupon bonds

%Yield

Settle   = datenum('24-Jun-2000');
Maturity = datenum('24-Jun-2010'); %need to change to year according to maturity
Basis    = 0;
Price    = 55.8395;
Period   = 1,

YieldZeroCoupon = zeroyield(Price, Settle, Maturity, Period, Basis)

YieldZeroCouponExp = log(1 + YieldZeroCoupon)   %set "Period" to 1 and just run it


%Price

Settle   = datenum('24-Jun-2000');
Maturity = datenum('24-Jun-2010'); %need to change to year according to maturity
Period = 2;
Basis = 0;
Yield = 0.04;

PriceZeroCoupon = zeroprice(Yield, Settle, Maturity, Period, Basis)
