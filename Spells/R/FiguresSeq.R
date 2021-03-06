
# Author: tim
###############################################################################

setwd("/home/tim/git/Spells/Spells")
set.seed(1)
setwd("/home/tim/git/Spells/Spells")
source("R/GenerateStationary.R")
source("R/Counting.R")
source("R/Distributions.R")
source("R/Align.R")



draw_sequence2 <- function(state_seq, states, cols, y = 0,...){
	xvals <- 1:length(state_seq) - 1 + 50
	names(cols) <- states
	col_seq     <- cols[state_seq]
	
	rect(xvals,y,xvals+1,y+1,col=col_seq,...)
}
draw_sequence3 <- function(durs, y = 0,...){
	xvals <- 1:length(durs) - 1 + 50	
	durs[is.na(durs)] <- ""
	text(xvals+.5,y+.5,durs,...)
}
# alignment
draw_sequence4 <- function(state_seq, x, states, cols, y = 0,...){
	
	names(cols) <- states
	col_seq     <- cols[state_seq]
	
	rect(x,y,x+1,y+1,col=col_seq,...)
}


cols   <- c("#74ee65", "#773129", "#41bbc5",NA)
states <- c("Employed", "Inactive","Retired","Dead")
yvals  <- 9:0 * 1.1


X <- RTraj_clean[,1:10]

pdf("Figures/Seq10.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(50,101), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence2(X[,i],states,cols,y=yvals[i], border = NA)
}
axis(1)
text(50,yvals+.5,1:10,pos=2,xpd=TRUE)
text(47,6,"Random individual i",xpd=TRUE,srt=90)
legend(60,-2,fill = cols, legend = states[-4],horiz = TRUE,xpd=TRUE,bty="n")
dev.off()


# ---------------------------------------
# figure 2
# total duration.


Ones            <- X == "Employed"
Ones[Ones]      <- 1
Ones[Ones == 0] <- NA

pdf("Figures/Seq10ones.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(50,101), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence3(Ones[,i],y=yvals[i])
	rect(50,yvals[i],(which(X[,i] == "Dead")[1]+49),yvals[i]+1,border = gray(.4),lwd=.5)
}
axis(1)
text(50,yvals+.5,1:10,pos=2,xpd=TRUE)
text(47,6,"Random individual i",xpd=TRUE,srt=90)
dev.off()




Dur <- apply(X,2,spell_durAge,state = "Inactive")

pdf("Figures/Seq10dur.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(50,101), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence3(Dur[,i],y=yvals[i])
	rect(50,yvals[i],(which(X[,i] == "Dead")[1]+49),yvals[i]+1,border = gray(.4),lwd=.5)
}
axis(1)
text(50,yvals+.5,1:10,pos=2,xpd=TRUE)
text(47,6,"Random individual i",xpd=TRUE,srt=90)
dev.off()

OrdUp   <- apply(X,2,spell_order,state = "Employed",increasing=TRUE)
OrdDown <- apply(X,2,spell_order,state = "Employed",increasing=FALSE)


pdf("Figures/Seq10ordUp.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(50,101), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence3(OrdUp[,i],y=yvals[i])
	rect(50,yvals[i],(which(X[,i] == "Dead")[1]+49),yvals[i]+1,border = gray(.4),lwd=.5)
}
axis(1)
text(50,yvals+.5,1:10,pos=2,xpd=TRUE)
text(47,6,"Random individual i",xpd=TRUE,srt=90)
dev.off()


pdf("Figures/Seq10ordDown.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(50,101), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence3(OrdDown[,i],y=yvals[i])
	rect(50,yvals[i],(which(X[,i] == "Dead")[1]+49),yvals[i]+1,border = gray(.4),lwd=.5)
}
axis(1)
text(50,yvals+.5,1:10,pos=2,xpd=TRUE)
text(47,6,"Random individual i",xpd=TRUE,srt=90)
dev.off()




# time spent


TimeSpent <- apply(X,2,spell_dur_before,state = "Inactive")

pdf("Figures/Seq10timespent.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(50,101), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence3(floor(TimeSpent)[,i],y=yvals[i])
	rect(50,yvals[i],(which(X[,i] == "Dead")[1]+49),yvals[i]+1,border = gray(.4),lwd=.5)
}
axis(1)
text(50,yvals+.5,1:10,pos=2,xpd=TRUE)
text(47,6,"Random individual i",xpd=TRUE,srt=90)
dev.off()


TimeLeft <- apply(X,2,spell_dur_after,state = "Inactive")

pdf("Figures/Seq10timeleft.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(50,101), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence3(floor(TimeLeft)[,i],y=yvals[i])
	rect(50,yvals[i],(which(X[,i] == "Dead")[1]+49),yvals[i]+1,border = gray(.4),lwd=.5)
}
axis(1)
text(50,yvals+.5,1:10,pos=2,xpd=TRUE)
text(47,6,"Random individual i",xpd=TRUE,srt=90)
dev.off()



# alignment
source("R/Align.R")
draw_sequence4 <- function(state_seq, x, states, cols, y = 0,...){
    
	names(cols) <- states
	col_seq     <- cols[state_seq]
	
	rect(x,y,x+1,y+1,col=col_seq,...)
}



pdf("Figures/Seq10deathalign.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(-80,0), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence4(state_seq = X[,i],x=XdeathAlign[,i],states,cols,y=yvals[i], border = NA)
}
axis(1)
text(-80,yvals+.5,1:10,pos=2,xpd=TRUE)
text(-83,6,"Random individual i",xpd=TRUE,srt=90)
legend(-40,-2,fill = cols, legend = states[-4],horiz = TRUE,xpd=TRUE,bty="n")
dev.off()


# align on first retirement:
XdeathAlign <- apply(X,2,align,state = "Dead",type="left")
XretirefirstAlign <- apply(X,2,align,state = "Retired",type="left",spell = "first")
Xinactlongleft    <- apply(X,2,align,state = "Inactive",type="left",spell = "longest")
Xinactlongright   <- apply(X,2,align,state = "Inactive",type="right",spell = "longest")

pdf("Figures/Seq10firstretirealign.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(-30,50), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence4(state_seq = X[,i],x=XretirefirstAlign[,i],states,cols,y=yvals[i], border = NA)
}
axis(1)
text(min(XretirefirstAlign),yvals+.5,1:10,pos=2,xpd=TRUE)
text(min(XretirefirstAlign)-3,6,"Random individual i",xpd=TRUE,srt=90)
#legend(-10,-2,fill = cols, legend = states[-4],horiz = TRUE,xpd=TRUE,bty="n")
dev.off()

pdf("Figures/Seq10inactlongleft.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(-30,50), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence4(state_seq = X[,i],x=Xinactlongleft[,i],states,cols,y=yvals[i], border = NA)
}
axis(1)
text(min(XretirefirstAlign),yvals+.5,1:10,pos=2,xpd=TRUE)
text(min(XretirefirstAlign)-3,6,"Random individual i",xpd=TRUE,srt=90)
#legend(-10,-2,fill = cols, legend = states[-4],horiz = TRUE,xpd=TRUE,bty="n")
dev.off()

pdf("Figures/Seq10inactlongright.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(-30,50), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence4(state_seq = X[,i],x=Xinactlongright[,i],states,cols,y=yvals[i], border = NA)
}
axis(1)
text(min(XretirefirstAlign),yvals+.5,1:10,pos=2,xpd=TRUE)
text(min(XretirefirstAlign)-3,6,"Random individual i",xpd=TRUE,srt=90)
legend(-10,-2,fill = cols, legend = states[-4],horiz = TRUE,xpd=TRUE,bty="n")
dev.off()


# -------------------------------------
Xcenter   <- apply(X,2,align,state = c("Employed"),type="center",spell = "longest")
pdf("Figures/Seq10centerlongempl.pdf",height=4,width=9)
par(mai=c(.8,1,0,0))
plot(NULL, type = "n", xlim = c(-30,50), ylim = c(0,12), axes = FALSE, xlab = "", ylab = "")
for (i in 1:10){
	draw_sequence4(state_seq = X[,i],x=Xcenter[,i],states,cols,y=yvals[i], border = NA)
}
axis(1)
text(min(XretirefirstAlign),yvals+.5,1:10,pos=2,xpd=TRUE)
text(min(XretirefirstAlign)-3,6,"Random individual i",xpd=TRUE,srt=90)
legend(-10,-2,fill = cols, legend = states[-4],horiz = TRUE,xpd=TRUE,bty="n")
dev.off()