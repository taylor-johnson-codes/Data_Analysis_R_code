load("cdc.Rdata")
summary(cdc)

NA == NA
is.na(NA==NA)

P=c(T,T,F,F)
Q=c(T,F,T,F)
P_and_Q = P & Q
df_tt_and = data.frame(P,Q,P_and_Q)
P_or_Q = P | Q
df_tt_or = data.frame(P,Q,P_or_Q)
df_tt_and
df_tt_or

R=c(T,F)
not_R = !R
#finish code from slide 11

Exp1 = !(P&Q)
Exp2 = !P | !Q

tt_df = data.frame(P,Q,Exp1,Exp2)
tt_df

Exp1 == Exp2

sum(Exp1==Exp2)
length(Exp1==Exp2)

sum(Exp1==Exp2) == length(Exp1==Exp2)

mean(Exp1) == mean(Exp2)
