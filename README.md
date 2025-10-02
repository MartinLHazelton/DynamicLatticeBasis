# DynamicLatticeBasis

DynamicLatticeBasis is an R package for implementing dynamic lattice basis sampling for statistical linear inverse problems. The methodology is described in:

Hazelton, M.L., McVeagh, M.R. and van Brunt, B. (2020). Geometrically aware dynamic Markov bases for statistical linear inverse problems, *Biometrika*, 108(3), 609-626.. https://doi.org/10.1093/biomet/asaa083

Update 3/10/2025: corrections to code to produce efficiency plots. These changes do not result in big changes to general conclusions.  

## Install

DynamicLatticeBasis is most easily installed from GitHub using devtools:

```
install.packages("devtools")
devtools::install_github("MartinLHazelton/DynamicLatticeBasis")
```


## Code for simulation results

The code below implements the simulation results in Hazelton, McVeagh and van Brunt (2021).

```
devtools::install_github("MartinLHazelton/DynamicLatticeBasis")
library(DynamicLatticeBasis)



## Set random number generator type for R version >=3.60

RNGkind(sample.kind = "default")



## 3-way book-crossing data - no 3-way interaction model 

data(BXno3way)
A.book.3way <- BXno3way$A
lambda.book.3way <- BXno3way$lambda
MarkovBasis.book.3way <- BXno3way$MarkovBasis
x.book.3way <- BXno3way$x
y.book.3way <- BXno3way$y
ndraws <- 1000000
THIN <- 1

set.seed(2020)
book.3way.Gibbs.tune0.time <- system.time(
book.3way.Gibbs.tune0 <- XGibbs(y.book.3way,A.book.3way,lambda.book.3way,combine=T,tune.par=0,ndraws=ceiling(ndraws/(length(lambda.book.3way)-length(y.book.3way))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
book.3way.MH.tune0.time <-system.time(
book.3way.MH.tune0 <- XMH(y.book.3way,A.book.3way,lambda.book.3way,combine=T,tune.par=0,Proposal="NonUnif",ndraws=ceiling(ndraws/(length(lambda.book.3way)-length(y.book.3way))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
book.3way.MH.unif.tune0.time <-system.time(
book.3way.MH.unif.tune0 <- XMH(y.book.3way,A.book.3way,lambda.book.3way,combine=T,tune.par=0,Proposal="Unif",ndraws=ceiling(ndraws/(length(lambda.book.3way)-length(y.book.3way))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
book.3way.Gibbs.tune.5.time <- system.time(
book.3way.Gibbs.tune.5 <- XGibbs(y.book.3way,A.book.3way,lambda.book.3way,combine=T,tune.par=0.5,ndraws=ceiling(ndraws/(length(lambda.book.3way)-length(y.book.3way))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
book.3way.MH.tune.5.time <-system.time(
book.3way.MH.tune.5 <- XMH(y.book.3way,A.book.3way,lambda.book.3way,combine=T,tune.par=0.5,Proposal="NonUnif",ndraws=ceiling(ndraws/(length(lambda.book.3way)-length(y.book.3way))),burnin=0,THIN=THIN)
)[1]


set.seed(2020)
book.3way.MH.unif.tune.5.time <-system.time(
book.3way.MH.unif.tune.5 <- XMH(y.book.3way,A.book.3way,lambda.book.3way,combine=T,tune.par=0.5,Proposal="Unif",ndraws=ceiling(ndraws/(length(lambda.book.3way)-length(y.book.3way))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
book.3way.Gibbs.tune100.time <- system.time(
book.3way.Gibbs.tune100 <- XGibbs(y.book.3way,A.book.3way,lambda.book.3way,combine=T,tune.par=100,ndraws=ceiling(ndraws/(length(lambda.book.3way)-length(y.book.3way))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
book.3way.MH.tune100.time <-system.time(
book.3way.MH.tune100 <- XMH(y.book.3way,A.book.3way,lambda.book.3way,combine=T,tune.par=100,Proposal="NonUnif",ndraws=ceiling(ndraws/(length(lambda.book.3way)-length(y.book.3way))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
book.3way.MH.unif.tune100.time <-system.time(
book.3way.MH.unif.tune100 <- XMH(y.book.3way,A.book.3way,lambda.book.3way,combine=T,tune.par=100,Proposal="Unif",ndraws=ceiling(ndraws/(length(lambda.book.3way)-length(y.book.3way))),burnin=0,THIN=THIN)
)[1]


set.seed(2020)
book.3way.MB.Gibbs.time <- system.time(
book.3way.MB.Gibbs <- XMarkovBasis_Gibbs(y.book.3way,A.book.3way,lambda.book.3way,U=MarkovBasis.book.3way,ndraws=ceiling(ndraws/ncol(MarkovBasis.book.3way)),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
book.3way.MB.MH.time <- system.time(
book.3way.MB.MH <- XMarkovBasis_MH(y.book.3way,A.book.3way,lambda.book.3way,U=MarkovBasis.book.3way,Proposal="Unif",ndraws=ceiling(ndraws/ncol(MarkovBasis.book.3way)),burnin=0,THIN=THIN)
)[1]

book.3way.Gibbs.tune0$X <- book.3way.Gibbs.tune0$X[,1:ndraws]
book.3way.MH.tune0$X <- book.3way.MH.tune0$X[,1:ndraws]
book.3way.MH.unif.tune0$X <- book.3way.MH.unif.tune0$X[,1:ndraws]
book.3way.Gibbs.tune.5$X <- book.3way.Gibbs.tune.5$X[,1:ndraws]
book.3way.MH.unif.tune.5$X <- book.3way.MH.unif.tune.5$X[,1:ndraws]
book.3way.Gibbs.tune100$X <- book.3way.Gibbs.tune100$X[,1:ndraws]
book.3way.MH.tune100$X <- book.3way.MH.tune100$X[,1:ndraws]
book.3way.MH.unif.tune100$X <- book.3way.MH.unif.tune100$X[,1:ndraws]
book.3way.MB.Gibbs$X <- book.3way.MB.Gibbs$X[,1:ndraws]
book.3way.MB.MH$X <- book.3way.MB.MH$X[,1:ndraws]

book.3way.means.no.ini <- round(cbind(
rowMeans(book.3way.Gibbs.tune0$X[,-c(1:10000)/THIN]),
rowMeans(book.3way.MH.tune0$X[,-c(1:50000)/THIN]),
rowMeans(book.3way.MH.unif.tune0$X[,-c(1:10000)/THIN]),
rowMeans(book.3way.Gibbs.tune.5$X[,-c(1:10000)/THIN]),
rowMeans(book.3way.MH.tune.5$X[,-c(1:10000)/THIN]),
rowMeans(book.3way.MH.unif.tune.5$X[,-c(1:10000)/THIN]),
rowMeans(book.3way.Gibbs.tune100$X[,-c(1:10000)/THIN]),
rowMeans(book.3way.MH.tune100$X[,-c(1:10000)/THIN]),
rowMeans(book.3way.MH.unif.tune100$X[,-c(1:10000)/THIN]),
rowMeans(book.3way.MB.Gibbs$X[,-c(1:10000)/THIN]),
rowMeans(book.3way.MB.MH$X[,-c(1:10000)/THIN]),
x.book.3way
),1)

book.3way.size.no.ini <- round(cbind(
effectiveSize(t(book.3way.Gibbs.tune0$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.3way.MH.tune0$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.3way.MH.unif.tune0$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.3way.Gibbs.tune.5$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.3way.MH.tune.5$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.3way.MH.unif.tune.5$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.3way.Gibbs.tune100$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.3way.MH.tune100$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.3way.MH.unif.tune100$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.3way.MB.Gibbs$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.3way.MB.MH$X[,-c(1:10000)/THIN]))
),0)

book.3way.eff.no.ini <- round(cbind(
mean(effectiveSize(t(book.3way.Gibbs.tune0$X[,-c(1:10000)/THIN])))/book.3way.Gibbs.tune0.time,
mean(effectiveSize(t(book.3way.MH.tune0$X[,-c(1:10000)/THIN])))/book.3way.MH.tune0.time,
mean(effectiveSize(t(book.3way.MH.unif.tune0$X[,-c(1:10000)/THIN])))/book.3way.MH.unif.tune0.time,
mean(effectiveSize(t(book.3way.Gibbs.tune.5$X[,-c(1:10000)/THIN])))/book.3way.Gibbs.tune.5.time,
mean(effectiveSize(t(book.3way.MH.tune.5$X[,-c(1:10000)/THIN])))/book.3way.MH.tune.5.time,
mean(effectiveSize(t(book.3way.MH.unif.tune.5$X[,-c(1:10000)/THIN])))/book.3way.MH.unif.tune.5.time,
mean(effectiveSize(t(book.3way.Gibbs.tune100$X[,-c(1:10000)/THIN])))/book.3way.Gibbs.tune100.time,
mean(effectiveSize(t(book.3way.MH.tune100$X[,-c(1:10000)/THIN])))/book.3way.MH.tune100.time,
mean(effectiveSize(t(book.3way.MH.unif.tune100$X[,-c(1:10000)/THIN])))/book.3way.MH.unif.tune100.time,
mean(effectiveSize(t(book.3way.MB.Gibbs$X[,-c(1:10000)/THIN])))/book.3way.MB.Gibbs.time,
mean(effectiveSize(t(book.3way.MB.MH$X[,-c(1:10000)/THIN])))/book.3way.MB.MH.time
),1)

book.3way.times.no.ini <- c(
book.3way.Gibbs.tune0.time,
book.3way.MH.tune0.time,
book.3way.MH.unif.tune0.time,
book.3way.Gibbs.tune.5.time,
book.3way.MH.tune.5.time,
book.3way.MH.unif.tune.5.time,
book.3way.Gibbs.tune100.time,
book.3way.MH.tune100.time,
book.3way.MH.unif.tune100.time,
book.3way.MB.Gibbs.time,
book.3way.MB.MH.time
)

book.3way.means.no.ini
book.3way.size.no.ini
book.3way.times.no.ini
book.3way.eff.no.ini

book.3way.ns <- which(book.3way.means.no.ini[,4]>2)
# book.3way.ns.eff <- (book.3way.size.no.ini[book.3way.ns,c(1,3,4,6,7,9,10)]/book.3way.size.no.ini[book.3way.ns,11])*(book.3way.times.no.ini[11]/book.3way.times.no.ini[c(1,3,4,6,7,9,10)]) # original with error
book.3way.ns.eff <- t(t(book.3way.size.no.ini[book.3way.ns,c(1,3,4,6,7,9,10)]/book.3way.size.no.ini[book.3way.ns,11])*(book.3way.times.no.ini[11]/book.3way.times.no.ini[c(1,3,4,6,7,9,10)]))


# Relative efficiency plot 


par(mar=c(4,5,1,1))
boxplot(log10(book.3way.ns.eff),ylab="Relative efficieny (log10 scale)",names=c("DLB.G","DLB.MH","DLB.G","DLB.MH","DBL.G","DLB.MH","FMB.G"),col=gray(0.8))
mtext(text=expression((alpha==0),(alpha==0),(alpha==0.5),(alpha==0.5),(alpha==100),(alpha==100)),side = 1, line = c(2,2,2,2), at = c(1,2,3,4,5,6))


# Trace plot


par(mfrow=c(4,2),mar=c(5,5,2,1))
ii <- 59
plot(book.3way.Gibbs.tune0$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.G(alpha==0)))	
plot(book.3way.MH.unif.tune0$X[ii,seq(2,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.MH(alpha==0)))
plot(book.3way.Gibbs.tune.5$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.G(alpha==0.5)))
plot(book.3way.MH.unif.tune.5$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.MH(alpha==0.5)))
plot(book.3way.Gibbs.tune100$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.G(alpha==100)))
plot(book.3way.MH.unif.tune100$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.MH(alpha==100)))
plot(book.3way.MB.Gibbs$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(paste(FMB.G)))
plot(book.3way.MB.MH$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(paste(FMB.MH)))






## Yang network data 

data(YangNetwork)
A.yang <- YangNetwork$A
lambda.yang <- YangNetwork$lambda
MarkovBasis.yang <- YangNetwork$MarkovBasis
x.yang <- YangNetwork$x
y.yang <- YangNetwork$y
ndraws <- 1000000
THIN <- 1

set.seed(2020)
yang.Gibbs.tune0.time <- system.time(
yang.Gibbs.tune0 <- XGibbs(y.yang,A.yang,lambda.yang,combine=T,tune.par=0,ndraws=ceiling(ndraws/(length(lambda.yang)-length(y.yang))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
yang.MH.tune0.time <-system.time(
yang.MH.tune0 <- XMH(y.yang,A.yang,lambda.yang,combine=T,tune.par=0,Proposal="NonUnif",ndraws=ceiling(ndraws/(length(lambda.yang)-length(y.yang))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
yang.MH.unif.tune0.time <-system.time(
yang.MH.unif.tune0 <- XMH(y.yang,A.yang,lambda.yang,combine=T,tune.par=0,Proposal="Unif",ndraws=ceiling(ndraws/(length(lambda.yang)-length(y.yang))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
yang.Gibbs.tune.5.time <- system.time(
yang.Gibbs.tune.5 <- XGibbs(y.yang,A.yang,lambda.yang,combine=T,tune.par=0.5,ndraws=ceiling(ndraws/(length(lambda.yang)-length(y.yang))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
yang.MH.tune.5.time <-system.time(
yang.MH.tune.5 <- XMH(y.yang,A.yang,lambda.yang,combine=T,tune.par=0.5,Proposal="NonUnif",ndraws=ceiling(ndraws/(length(lambda.yang)-length(y.yang))),burnin=0,THIN=THIN)
)[1]


set.seed(2020)
yang.MH.unif.tune.5.time <-system.time(
yang.MH.unif.tune.5 <- XMH(y.yang,A.yang,lambda.yang,combine=T,tune.par=0.5,Proposal="Unif",ndraws=ceiling(ndraws/(length(lambda.yang)-length(y.yang))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
yang.Gibbs.tune100.time <- system.time(
yang.Gibbs.tune100 <- XGibbs(y.yang,A.yang,lambda.yang,combine=T,tune.par=100,ndraws=ceiling(ndraws/(length(lambda.yang)-length(y.yang))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
yang.MH.tune100.time <-system.time(
yang.MH.tune100 <- XMH(y.yang,A.yang,lambda.yang,combine=T,tune.par=100,Proposal="NonUnif",ndraws=ceiling(ndraws/(length(lambda.yang)-length(y.yang))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
yang.MH.unif.tune100.time <-system.time(
yang.MH.unif.tune100 <- XMH(y.yang,A.yang,lambda.yang,combine=T,tune.par=100,Proposal="Unif",ndraws=ceiling(ndraws/(length(lambda.yang)-length(y.yang))),burnin=0,THIN=THIN)
)[1]


set.seed(2020)
yang.MB.Gibbs.time <- system.time(
yang.MB.Gibbs <- XMarkovBasis_Gibbs(y.yang,A.yang,lambda.yang,U=MarkovBasis.yang,ndraws=ceiling(ndraws/ncol(MarkovBasis.yang)),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
yang.MB.MH.time <- system.time(
yang.MB.MH <- XMarkovBasis_MH(y.yang,A.yang,lambda.yang,U=MarkovBasis.yang,Proposal="Unif",ndraws=ceiling(ndraws/ncol(MarkovBasis.yang)),burnin=0,THIN=THIN)
)[1]

yang.Gibbs.tune0$X <- yang.Gibbs.tune0$X[,1:ndraws]
yang.MH.tune0$X <- yang.MH.tune0$X[,1:ndraws]
yang.MH.unif.tune0$X <- yang.MH.unif.tune0$X[,1:ndraws]
yang.Gibbs.tune.5$X <- yang.Gibbs.tune.5$X[,1:ndraws]
yang.MH.unif.tune.5$X <- yang.MH.unif.tune.5$X[,1:ndraws]
yang.Gibbs.tune100$X <- yang.Gibbs.tune100$X[,1:ndraws]
yang.MH.tune100$X <- yang.MH.tune100$X[,1:ndraws]
yang.MH.unif.tune100$X <- yang.MH.unif.tune100$X[,1:ndraws]
yang.MB.Gibbs$X <- yang.MB.Gibbs$X[,1:ndraws]
yang.MB.MH$X <- yang.MB.MH$X[,1:ndraws]

yang.means.no.ini <- round(cbind(
rowMeans(yang.Gibbs.tune0$X[,-c(1:10000)/THIN]),
rowMeans(yang.MH.tune0$X[,-c(1:50000)/THIN]),
rowMeans(yang.MH.unif.tune0$X[,-c(1:10000)/THIN]),
rowMeans(yang.Gibbs.tune.5$X[,-c(1:10000)/THIN]),
rowMeans(yang.MH.tune.5$X[,-c(1:10000)/THIN]),
rowMeans(yang.MH.unif.tune.5$X[,-c(1:10000)/THIN]),
rowMeans(yang.Gibbs.tune100$X[,-c(1:10000)/THIN]),
rowMeans(yang.MH.tune100$X[,-c(1:10000)/THIN]),
rowMeans(yang.MH.unif.tune100$X[,-c(1:10000)/THIN]),
rowMeans(yang.MB.Gibbs$X[,-c(1:10000)/THIN]),
rowMeans(yang.MB.MH$X[,-c(1:10000)/THIN]),
x.yang
),1)

yang.size.no.ini <- round(cbind(
effectiveSize(t(yang.Gibbs.tune0$X[,-c(1:10000)/THIN])),
effectiveSize(t(yang.MH.tune0$X[,-c(1:10000)/THIN])),
effectiveSize(t(yang.MH.unif.tune0$X[,-c(1:10000)/THIN])),
effectiveSize(t(yang.Gibbs.tune.5$X[,-c(1:10000)/THIN])),
effectiveSize(t(yang.MH.tune.5$X[,-c(1:10000)/THIN])),
effectiveSize(t(yang.MH.unif.tune.5$X[,-c(1:10000)/THIN])),
effectiveSize(t(yang.Gibbs.tune100$X[,-c(1:10000)/THIN])),
effectiveSize(t(yang.MH.tune100$X[,-c(1:10000)/THIN])),
effectiveSize(t(yang.MH.unif.tune100$X[,-c(1:10000)/THIN])),
effectiveSize(t(yang.MB.Gibbs$X[,-c(1:10000)/THIN])),
effectiveSize(t(yang.MB.MH$X[,-c(1:10000)/THIN]))
),0)

yang.eff.no.ini <- round(cbind(
mean(effectiveSize(t(yang.Gibbs.tune0$X[,-c(1:10000)/THIN])))/yang.Gibbs.tune0.time,
mean(effectiveSize(t(yang.MH.tune0$X[,-c(1:10000)/THIN])))/yang.MH.tune0.time,
mean(effectiveSize(t(yang.MH.unif.tune0$X[,-c(1:10000)/THIN])))/yang.MH.unif.tune0.time,
mean(effectiveSize(t(yang.Gibbs.tune.5$X[,-c(1:10000)/THIN])))/yang.Gibbs.tune.5.time,
mean(effectiveSize(t(yang.MH.tune.5$X[,-c(1:10000)/THIN])))/yang.MH.tune.5.time,
mean(effectiveSize(t(yang.MH.unif.tune.5$X[,-c(1:10000)/THIN])))/yang.MH.unif.tune.5.time,
mean(effectiveSize(t(yang.Gibbs.tune100$X[,-c(1:10000)/THIN])))/yang.Gibbs.tune100.time,
mean(effectiveSize(t(yang.MH.tune100$X[,-c(1:10000)/THIN])))/yang.MH.tune100.time,
mean(effectiveSize(t(yang.MH.unif.tune100$X[,-c(1:10000)/THIN])))/yang.MH.unif.tune100.time,
mean(effectiveSize(t(yang.MB.Gibbs$X[,-c(1:10000)/THIN])))/yang.MB.Gibbs.time,
mean(effectiveSize(t(yang.MB.MH$X[,-c(1:10000)/THIN])))/yang.MB.MH.time
),1)

yang.times.no.ini <- c(
yang.Gibbs.tune0.time,
yang.MH.tune0.time,
yang.MH.unif.tune0.time,
yang.Gibbs.tune.5.time,
yang.MH.tune.5.time,
yang.MH.unif.tune.5.time,
yang.Gibbs.tune100.time,
yang.MH.tune100.time,
yang.MH.unif.tune100.time,
yang.MB.Gibbs.time,
yang.MB.MH.time
)

yang.means.no.ini
yang.size.no.ini
yang.times.no.ini
yang.eff.no.ini

yang.ns <- which(yang.means.no.ini[,4]>2)
# yang.ns.eff <- (yang.size.no.ini[yang.ns,c(1,3,4,6,7,9,10)]/yang.size.no.ini[yang.ns,11])*(yang.times.no.ini[11]/yang.times.no.ini[c(1,3,4,6,7,9,10)]) # original incorrect
yang.ns.eff <- t(t(yang.size.no.ini[yang.ns,c(1,3,4,6,7,9,10)]/yang.size.no.ini[yang.ns,11])*(yang.times.no.ini[11]/yang.times.no.ini[c(1,3,4,6,7,9,10)]))


# Relative efficiency plot 


par(mar=c(4,5,1,1))
boxplot(log10(yang.ns.eff),ylab="Relative efficieny (log10 scale)",names=c("DLB.G","DLB.MH","DLB.G","DLB.MH","DBL.G","DLB.MH","FMB.G"),col=gray(0.8))
mtext(text=expression((alpha==0),(alpha==0),(alpha==0.5),(alpha==0.5),(alpha==100),(alpha==100)),side = 1, line = c(2,2,2,2), at = c(1,2,3,4,5,6))


# Trace plot


par(mfrow=c(4,2),mar=c(5,5,2,1))
ii <- 6
plot(yang.Gibbs.tune0$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.G(alpha==0)))	
plot(yang.MH.unif.tune0$X[ii,seq(2,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.MH(alpha==0)))
plot(yang.Gibbs.tune.5$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.G(alpha==0.5)))
plot(yang.MH.unif.tune.5$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.MH(alpha==0.5)))
plot(yang.Gibbs.tune100$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.G(alpha==100)))
plot(yang.MH.unif.tune100$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.MH(alpha==100)))
plot(yang.MB.Gibbs$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(paste(FMB.G)))
plot(yang.MB.MH$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(paste(FMB.MH)))





##  London road

data(LondonRoad)
A.londonrd <- LondonRoad$A
lambda.londonrd <- LondonRoad$lambda
MarkovBasis.londonrd <- LondonRoad$MarkovBasis
y.londonrd <- LondonRoad$y
ndraws <- 1000000
THIN <- 1

set.seed(2020)
londonrd.Gibbs.tune0.time <- system.time(
londonrd.Gibbs.tune0 <- XGibbs(y.londonrd,A.londonrd,lambda.londonrd,combine=F,tune.par=0,ndraws=ceiling(ndraws/(length(lambda.londonrd)-length(y.londonrd))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
londonrd.MH.tune0.time <-system.time(
londonrd.MH.tune0 <- XMH(y.londonrd,A.londonrd,lambda.londonrd,combine=F,tune.par=0,Proposal="NonUnif",ndraws=ceiling(ndraws/(length(lambda.londonrd)-length(y.londonrd))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
londonrd.MH.unif.tune0.time <-system.time(
londonrd.MH.unif.tune0 <- XMH(y.londonrd,A.londonrd,lambda.londonrd,combine=F,tune.par=0,Proposal="Unif",ndraws=ceiling(ndraws/(length(lambda.londonrd)-length(y.londonrd))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
londonrd.Gibbs.tune.5.time <- system.time(
londonrd.Gibbs.tune.5 <- XGibbs(y.londonrd,A.londonrd,lambda.londonrd,combine=F,tune.par=0.5,ndraws=ceiling(ndraws/(length(lambda.londonrd)-length(y.londonrd))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
londonrd.MH.tune.5.time <-system.time(
londonrd.MH.tune.5 <- XMH(y.londonrd,A.londonrd,lambda.londonrd,combine=F,tune.par=0.5,Proposal="NonUnif",ndraws=ceiling(ndraws/(length(lambda.londonrd)-length(y.londonrd))),burnin=0,THIN=THIN)
)[1]


set.seed(2020)
londonrd.MH.unif.tune.5.time <-system.time(
londonrd.MH.unif.tune.5 <- XMH(y.londonrd,A.londonrd,lambda.londonrd,combine=F,tune.par=0.5,Proposal="Unif",ndraws=ceiling(ndraws/(length(lambda.londonrd)-length(y.londonrd))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
londonrd.Gibbs.tune100.time <- system.time(
londonrd.Gibbs.tune100 <- XGibbs(y.londonrd,A.londonrd,lambda.londonrd,combine=F,tune.par=100,ndraws=ceiling(ndraws/(length(lambda.londonrd)-length(y.londonrd))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
londonrd.MH.tune100.time <-system.time(
londonrd.MH.tune100 <- XMH(y.londonrd,A.londonrd,lambda.londonrd,combine=F,tune.par=100,Proposal="NonUnif",ndraws=ceiling(ndraws/(length(lambda.londonrd)-length(y.londonrd))),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
londonrd.MH.unif.tune100.time <-system.time(
londonrd.MH.unif.tune100 <- XMH(y.londonrd,A.londonrd,lambda.londonrd,combine=F,tune.par=100,Proposal="Unif",ndraws=ceiling(ndraws/(length(lambda.londonrd)-length(y.londonrd))),burnin=0,THIN=THIN)
)[1]


set.seed(2020)
londonrd.MB.Gibbs.time <- system.time(
londonrd.MB.Gibbs <- XMarkovBasis_Gibbs(y.londonrd,A.londonrd,lambda.londonrd,U=MarkovBasis.londonrd,ndraws=ceiling(ndraws/ncol(MarkovBasis.londonrd)),burnin=0,THIN=THIN)
)[1]

set.seed(2020)
londonrd.MB.MH.time <- system.time(
londonrd.MB.MH <- XMarkovBasis_MH(y.londonrd,A.londonrd,lambda.londonrd,U=MarkovBasis.londonrd,Proposal="Unif",ndraws=ceiling(ndraws/ncol(MarkovBasis.londonrd)),burnin=0,THIN=THIN)
)[1]

londonrd.Gibbs.tune0$X <- londonrd.Gibbs.tune0$X[,1:ndraws]
londonrd.MH.tune0$X <- londonrd.MH.tune0$X[,1:ndraws]
londonrd.MH.unif.tune0$X <- londonrd.MH.unif.tune0$X[,1:ndraws]
londonrd.Gibbs.tune.5$X <- londonrd.Gibbs.tune.5$X[,1:ndraws]
londonrd.MH.unif.tune.5$X <- londonrd.MH.unif.tune.5$X[,1:ndraws]
londonrd.Gibbs.tune100$X <- londonrd.Gibbs.tune100$X[,1:ndraws]
londonrd.MH.tune100$X <- londonrd.MH.tune100$X[,1:ndraws]
londonrd.MH.unif.tune100$X <- londonrd.MH.unif.tune100$X[,1:ndraws]
londonrd.MB.Gibbs$X <- londonrd.MB.Gibbs$X[,1:ndraws]
londonrd.MB.MH$X <- londonrd.MB.MH$X[,1:ndraws]

londonrd.means.no.ini <- round(cbind(
rowMeans(londonrd.Gibbs.tune0$X[,-c(1:10000)/THIN]),
rowMeans(londonrd.MH.tune0$X[,-c(1:50000)/THIN]),
rowMeans(londonrd.MH.unif.tune0$X[,-c(1:10000)/THIN]),
rowMeans(londonrd.Gibbs.tune.5$X[,-c(1:10000)/THIN]),
rowMeans(londonrd.MH.tune.5$X[,-c(1:10000)/THIN]),
rowMeans(londonrd.MH.unif.tune.5$X[,-c(1:10000)/THIN]),
rowMeans(londonrd.Gibbs.tune100$X[,-c(1:10000)/THIN]),
rowMeans(londonrd.MH.tune100$X[,-c(1:10000)/THIN]),
rowMeans(londonrd.MH.unif.tune100$X[,-c(1:10000)/THIN]),
rowMeans(londonrd.MB.Gibbs$X[,-c(1:10000)/THIN]),
rowMeans(londonrd.MB.MH$X[,-c(1:10000)/THIN])
),1)

londonrd.size.no.ini <- round(cbind(
effectiveSize(t(londonrd.Gibbs.tune0$X[,-c(1:10000)/THIN])),
effectiveSize(t(londonrd.MH.tune0$X[,-c(1:10000)/THIN])),
effectiveSize(t(londonrd.MH.unif.tune0$X[,-c(1:10000)/THIN])),
effectiveSize(t(londonrd.Gibbs.tune.5$X[,-c(1:10000)/THIN])),
effectiveSize(t(londonrd.MH.tune.5$X[,-c(1:10000)/THIN])),
effectiveSize(t(londonrd.MH.unif.tune.5$X[,-c(1:10000)/THIN])),
effectiveSize(t(londonrd.Gibbs.tune100$X[,-c(1:10000)/THIN])),
effectiveSize(t(londonrd.MH.tune100$X[,-c(1:10000)/THIN])),
effectiveSize(t(londonrd.MH.unif.tune100$X[,-c(1:10000)/THIN])),
effectiveSize(t(londonrd.MB.Gibbs$X[,-c(1:10000)/THIN])),
effectiveSize(t(londonrd.MB.MH$X[,-c(1:10000)/THIN]))
),0)

londonrd.eff.no.ini <- round(cbind(
mean(effectiveSize(t(londonrd.Gibbs.tune0$X[,-c(1:10000)/THIN])))/londonrd.Gibbs.tune0.time,
mean(effectiveSize(t(londonrd.MH.tune0$X[,-c(1:10000)/THIN])))/londonrd.MH.tune0.time,
mean(effectiveSize(t(londonrd.MH.unif.tune0$X[,-c(1:10000)/THIN])))/londonrd.MH.unif.tune0.time,
mean(effectiveSize(t(londonrd.Gibbs.tune.5$X[,-c(1:10000)/THIN])))/londonrd.Gibbs.tune.5.time,
mean(effectiveSize(t(londonrd.MH.tune.5$X[,-c(1:10000)/THIN])))/londonrd.MH.tune.5.time,
mean(effectiveSize(t(londonrd.MH.unif.tune.5$X[,-c(1:10000)/THIN])))/londonrd.MH.unif.tune.5.time,
mean(effectiveSize(t(londonrd.Gibbs.tune100$X[,-c(1:10000)/THIN])))/londonrd.Gibbs.tune100.time,
mean(effectiveSize(t(londonrd.MH.tune100$X[,-c(1:10000)/THIN])))/londonrd.MH.tune100.time,
mean(effectiveSize(t(londonrd.MH.unif.tune100$X[,-c(1:10000)/THIN])))/londonrd.MH.unif.tune100.time,
mean(effectiveSize(t(londonrd.MB.Gibbs$X[,-c(1:10000)/THIN])))/londonrd.MB.Gibbs.time,
mean(effectiveSize(t(londonrd.MB.MH$X[,-c(1:10000)/THIN])))/londonrd.MB.MH.time
),1)

londonrd.times.no.ini <- c(
londonrd.Gibbs.tune0.time,
londonrd.MH.tune0.time,
londonrd.MH.unif.tune0.time,
londonrd.Gibbs.tune.5.time,
londonrd.MH.tune.5.time,
londonrd.MH.unif.tune.5.time,
londonrd.Gibbs.tune100.time,
londonrd.MH.tune100.time,
londonrd.MH.unif.tune100.time,
londonrd.MB.Gibbs.time,
londonrd.MB.MH.time
)

londonrd.means.no.ini
londonrd.size.no.ini
londonrd.times.no.ini
londonrd.eff.no.ini

londonrd.ns <- which(londonrd.means.no.ini[,4]>2)
# londonrd.ns.eff <- (londonrd.size.no.ini[londonrd.ns,c(4,6,7,9,10)]/londonrd.size.no.ini[londonrd.ns,11])*(londonrd.times.no.ini[11]/londonrd.times.no.ini[c(4,6,7,9,10)]) # original wrong
londonrd.ns.eff <- t(t(londonrd.size.no.ini[londonrd.ns,c(4,6,7,9,10)]/londonrd.size.no.ini[londonrd.ns,11])*(londonrd.times.no.ini[11]/londonrd.times.no.ini[c(4,6,7,9,10)]))



# Relative efficiency plot 


par(mar=c(4,5,1,1))
boxplot(log10(londonrd.ns.eff),ylab="Relative efficieny (log10 scale)",names=c("DLB.G","DLB.MH","DBL.G","DLB.MH","FMB.G"),col=gray(0.8))
mtext(text=expression((alpha==0.5),(alpha==0.5),(alpha==100),(alpha==100)),side = 1, line = c(2,2,2,2), at = c(1,2,3,4))



# Trace plot


par(mfrow=c(4,2),mar=c(5,5,2,1))
ii <- 6
plot(londonrd.Gibbs.tune0$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.G(alpha==0)))	
plot(londonrd.MH.unif.tune0$X[ii,seq(2,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.MH(alpha==0)))
plot(londonrd.Gibbs.tune.5$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.G(alpha==0.5)))
plot(londonrd.MH.unif.tune.5$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.MH(alpha==0.5)))
plot(londonrd.Gibbs.tune100$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.G(alpha==100)))
plot(londonrd.MH.unif.tune100$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(DLB.MH(alpha==100)))
plot(londonrd.MB.Gibbs$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(paste(FMB.G)))
plot(londonrd.MB.MH$X[ii,seq(1,10^6,by=10)],type="l",ylab=expression(x[6]),xlab="step",main=expression(paste(FMB.MH)))



## Book cross data - uniform model

data(BX2way)
A.book.2way <- BX2way$A
lambda.book.2way <- BX2way$lambda
MarkovBasis.book.2way <- BX2way$MarkovBasis
x.book.2way <- BX2way$x
y.book.2way <- BX2way$y
ndraws <- 500000
THIN <- 1



set.seed(2019)
book.2way.uniform.tune0.time <- system.time(
book.2way.uniform.tune0 <- XGibbs(y.book.2way,A.book.2way,lambda.book.2way,Model="Uniform",tune.par=0,combine=F,ndraws=ceiling(ndraws/(length(lambda.book.2way)-length(y.book.2way))),burnin=0,THIN=THIN)
)[1]

set.seed(2019)
book.2way.uniform.tune.5.time <- system.time(
book.2way.uniform.tune.5 <- XGibbs(y.book.2way,A.book.2way,lambda.book.2way,Model="Uniform",tune.par=0.5,combine=F,ndraws=ceiling(ndraws/(length(lambda.book.2way)-length(y.book.2way))),burnin=0,THIN=THIN)
)[1]

set.seed(2019)
book.2way.uniform.tune100.time <- system.time(
book.2way.uniform.tune100 <- XGibbs(y.book.2way,A.book.2way,lambda.book.2way,Model="Uniform",tune.par=100,combine=F,ndraws=ceiling(ndraws/(length(lambda.book.2way)-length(y.book.2way))),burnin=0,THIN=THIN)
)[1]

set.seed(2019)
book.2way.MB.uniform.time <- system.time(
book.2way.MB.uniform <- XMarkovBasis_Gibbs(y.book.2way,A.book.2way,lambda.book.2way,Model="Uniform",U=MarkovBasis.book.2way,ndraws=ceiling(ndraws/ncol(MarkovBasis.book.2way)),burnin=0,THIN=THIN)
)[1]

book.2way.uniform.tune0$X <- book.2way.uniform.tune0$X[,1:ndraws]
book.2way.uniform.tune.5$X <- book.2way.uniform.tune.5$X[,1:ndraws]
book.2way.uniform.tune100$X <- book.2way.uniform.tune100$X[,1:ndraws]
book.2way.MB.uniform$X <- book.2way.MB.uniform$X[,1:ndraws]

book.2way.means.uniform <- round(cbind(
rowMeans(book.2way.uniform.tune0$X[,-c(1:10000)/THIN]),
rowMeans(book.2way.uniform.tune.5$X[,-c(1:10000)/THIN]),
rowMeans(book.2way.uniform.tune100$X[,-c(1:10000)/THIN]),
rowMeans(book.2way.MB.uniform$X[,-c(1:10000)/THIN]),
x.book.2way
),1)

book.2way.size.uniform <- round(cbind(
effectiveSize(t(book.2way.uniform.tune0$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.2way.uniform.tune.5$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.2way.uniform.tune100$X[,-c(1:10000)/THIN])),
effectiveSize(t(book.2way.MB.uniform$X[,-c(1:10000)/THIN]))
),0)

book.2way.eff.uniform <- round(cbind(
mean(effectiveSize(t(book.2way.uniform.tune0$X[,-c(1:10000)/THIN])))/book.2way.uniform.tune0.time,
mean(effectiveSize(t(book.2way.uniform.tune.5$X[,-c(1:10000)/THIN])))/book.2way.uniform.tune.5.time,
mean(effectiveSize(t(book.2way.uniform.tune100$X[,-c(1:10000)/THIN])))/book.2way.uniform.tune100.time,
mean(effectiveSize(t(book.2way.MB.uniform$X[,-c(1:10000)/THIN])))/book.2way.MB.uniform.time
),1)



book.2way.means.uniform
book.2way.size.uniform
book.2way.eff.uniform

book.2way.ns <- which(book.2way.means.uniform[,1]>2)
# book.2way.ns.eff <- book.2way.size.uniform[book.2way.ns,1:3]/book.2way.size.uniform[book.2way.ns,4]  # original incorrect
book.2way.times <- c(book.2way.uniform.tune0.time,book.2way.uniform.tune.5.time,book.2way.uniform.tune100.time,book.2way.MB.uniform.time) 
book.2way.ns.eff <- t(t(book.2way.size.uniform[book.2way.ns,1:3]/book.2way.size.uniform[book.2way.ns,4])/(book.2way.times[1:3]/book.2way.times[4]) )

# relative efficiency plot

par(mar=c(4,5,1,1))
boxplot(log10(book.2way.ns.eff),ylab="Relative efficieny (log10 scale)",names=rep("Dynamic lattice basis",3),col=gray(0.8))
mtext(text=expression((alpha==0),(alpha==0.5),(alpha==100)),side = 1, line = c(2,2,2), at = c(1,2,3))


# trace plot

par(mfrow=c(4,1),mar=c(5,5,2,1))
plot(book.2way.uniform.tune0$X[45,seq(1,ndraws,by=10)],type="l",ylab=expression(x[45]),xlab="step",main=expression(DLB.G(alpha==0)))	
plot(book.2way.uniform.tune.5$X[45,seq(1,ndraws,by=10)],type="l",ylab=expression(x[45]),xlab="step",main=expression(DLB.G(alpha==0.5)))
plot(book.2way.uniform.tune100$X[45,seq(1,ndraws,by=10)],type="l",ylab=expression(x[45]),xlab="step",main=expression(DLB.G(alpha==100)))
plot(book.2way.MB.uniform$X[45,seq(1,ndraws,by=10)],type="l",ylab=expression(x[45]),xlab="step",main=expression(paste(FMB)))

```

## Reference

Hazelton, M.L., McVeagh, M.R. and van Brunt, B. (2020). Geometrically aware dynamic Markov bases for statistical linear inverse problems, *Biometrika*, in press. https://doi.org/10.1093/biomet/asaa083

