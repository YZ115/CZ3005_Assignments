company(sumsum).
company(appy).
developed(sumsum,galactica-s3).
boss(stevey).
steal(stevey,galactica-s3,sumsum).
technology(galactica-s3).
competitor(sumsum,appy).


business(X,Y):- technology(X),developed(Y,X).
rival(X):- competitor(X,appy);competitor(appy,X).
unethical(X):- boss(X),business(Y,Z),rival(Z),steal(X,Y,Z).