#!/usr/bin/env bash
# crawler.sh

# This script will change sql file to scheme and carry out filtering on nodes for movies which are top 250 and bottom 100 movie lists and displays the result on the visualizer changing every 15 seconds showing 5 movies at a time for 350 movies total.

set -e

BASEDIR='/home/yenat/Documents/corto'
OCDIR='/home/yenat/Opencog/opencog/build' #give path of your opencog build directory
crawlDIR='/home/yenat/Desktop/IMDB/imdb-crawler' #give path of your imdb crawler directory
glimpseDIR='/home/yenat/Opencog/external-tools/glimpse' #give path of your sglimpse directory 

export NAME=crawl
if [[ $(tmux ls 2>/dev/null) == ${NAME}* ]]; then
    tmux kill-session -t $NAME
    echo "Killed session $NAME"1
fi

echo "removing new lines from sql file and loading sql file"
#--- Uncomment the following three lines for the first time in order to load the sql file into the database and comment after that---#

#cd $crawlDIR
 #sed 's/\\n//g' MovieDB.sql > testdata.sql #this is done because the new lines will create empty nodes and links later on
 #mysql -u yenat -ppwd movieDB < testdata.sql #load the sql file 
 
echo "changing sql to scheme"
cd $BASEDIR
 perl db2scm.pl 
 
echo "remove special characters"
cd $BASEDIR
  iconv -f iso-8859-1 -t ASCII//TRANSLIT Output.scm > Out.scm
  
echo "move out.scm file to build directory"  
cd $BASEDIR
 mv -f Out.scm $OCDIR/

cd $BASEDIR 
sensible-browser http://localhost:9000

echo "load out.scm file and movie-query file and the restapi" 

tmux new-session -n 'home' -d -s $NAME "cd $BASEDIR sensible-browser http://localhost:9000; $SHELL"

tmux new-window -n 'load-query' "cd $OCDIR; guile -l load.scm; $SHELL"
sleep 15
tmux new-window -n 'start-glimpse' "cd $glimpseDIR; npm start; $SHELL"
tmux new-window -n 'bash' "cd $BASEDIR; $SHELL"

tmux attach;

