#!/usr/bin/perl -w

# This script changes sql file to atomese script; there are intermediate files for each four tables and one output file containing the whole tables in atomese form together.
use DBI;

use DBD::mysql;
use strict;
use warnings;

use Text::Iconv;


## mysql user database name
my $db ="movieDB"; #change this to your database name
## mysql database user name
my $user = "yenat"; #change this to your user name
 
## mysql database password
my $pass = "pwd"; #change this to your password
 
## user hostname : This should be "localhost" but it can be diffrent too
my $host="localhost";

my $dbh = DBI->connect("DBI:mysql:$db:$host", $user, $pass);

$dbh = ConnectToMySql($db);
## SQL query
my $query = "SELECT Id, Title, ImdbLink, ReleaseDate, Rating, Synopsis FROM Movie";
my $query2 = "SELECT Id, Person_id, Movie_id, CharacterName FROM Actor ";
my $query3 = "SELECT Id, Person_id, Movie_id FROM Director ";
my $query4 = "SELECT Id, Name FROM Person ";
## for movie table
my $sqlQuery  = $dbh->prepare($query) ;
 
$sqlQuery->execute();
## for actor table
my $sqlQuery2  = $dbh->prepare($query2) ;
 
$sqlQuery2->execute();
## for director table
my $sqlQuery3  = $dbh->prepare($query3) ;
 
$sqlQuery3->execute();
##for person table
my $sqlQuery4  = $dbh->prepare($query4) ;
 
$sqlQuery4->execute();
#accessing the movie table
my $moviefile = "inputmovie.txt";
open(my $ip, ">",  $moviefile );

while (my @row= $sqlQuery->fetchrow_array()) {
my $ID = $row[0];
my $TITLE = $row[1];
my $LINK = $row[2];
my $RELEASEDATE = $row[3];
my $RATING = $row[4];
my $SYNOPSIS = $row[5];
$SYNOPSIS =~ s/"//g;
# print your data of movie table to file
print $ip "$ID--$TITLE--$LINK--$RELEASEDATE--$RATING--$SYNOPSIS-- \n";
}
close $ip;

#accessing the actor table

my $actorfile = "inputactor.txt";
open(my $ip2, ">",  $actorfile );

while (my @row= $sqlQuery2->fetchrow_array()) {
my $ID = $row[0];
my $person_id = $row[1];
my $movie_id = $row[2];
my $character_name = $row[3];
$character_name =~ s/"//g;
# print your table rows
print $ip2 "$ID--$person_id--$movie_id--$character_name-- \n";
}
close $ip2;

#accessing the director table

my $directorfile = "inputdirector.txt";
open(my $ip3, ">",  $directorfile );

while (my @row= $sqlQuery3->fetchrow_array()) {
my $ID = $row[0];
my $person_id = $row[1];
my $movie_id = $row[2];
# print your table rows
print $ip3 "$ID--$person_id--$movie_id-- \n";
}
close $ip3;

#accessing the person table

my $personfile = "inputperson.txt";
open(my $ip4, ">",  $personfile );

while (my @row= $sqlQuery4->fetchrow_array()) {
my $ID = $row[0];
my $name = $row[1];

# print your table rows
print $ip4 "$ID--$name--\n";
}
close $ip4;

#changing all the tables to atomese

open( $ip, "<",  $moviefile );
open( $ip2, "<",  $actorfile );
open( $ip3, "<",  $directorfile );
open( $ip4, "<",  $personfile );
my $scmfile = "Output.scm";

open (my $op, ">",$scmfile ) or die "Can't open file";

    while(<$ip>) {
    
    my @fields = split('--',$_);
    chomp;
        
    
    my $first = $fields[0];
    my $second = $fields[1];
    my $third = $fields[2];
    my $fourth = $fields[3];
    my $fifth = $fields[4];
    my $sixth = $fields[5];
    
           
    my $inherit = "";
	$inherit .=  "(InheritanceLink\n";
	$inherit .=  "      (Concept \"Movie $first\")\n";
	$inherit .=  "       (Concept \"Movie\")\n";
	$inherit .=  "   )\n";
	$inherit;
    
    
    my $title = "";
	
	$title .= "   (TitleLink\n";
	$title .=  "      (Concept \"Movie $first\")\n";
	$title .=  "      (Concept \"$second\")\n";
	$title .=  "   )\n";
	$title;
	
    
    my $imdb = "";
	
	$imdb .= "   (ImdbLink\n";
	$imdb .=  "      (Concept \"Movie $first\")\n";
	$imdb .=  "      (Concept \"$third\")\n";
	$imdb .=  "   )\n";
	$imdb;
    
    my $release = "";
	
	$release .= "   (ReleaseDateLink\n";
	$release .=  "      (Concept \"Movie $first\")\n";
	$release .=  "      (Concept \"$fourth\")\n";
	$release .=  "   )\n";
	$release;
       
    
    my $rating = "";
	
	$rating .= "   (RatingLink\n";
	$rating .=  "      (Concept \"Movie $first\")\n";
	$rating .=  "      (Number \"$fifth\")\n";
	$rating .=  "   )\n";
	$rating;
	
    my $synopsis = "";
	
	$synopsis .= "   (SynopsisLink\n";
	$synopsis .=  "      (Concept \"Movie $first\")\n";
	$synopsis .=  "      (ContentNode \"$sixth\")\n";
	$synopsis .=  "   )\n";
	$synopsis;
	
	print $op "$inherit\n $title\n $imdb\n $release\n $rating\n $synopsis ";
	
}
while(<$ip2>) {
my @fieldd = split('--',$_);
    chomp;
        
    my $firstt = $fieldd[0];
    my $secondd = $fieldd[1];
    my $thirdd = $fieldd[2];
    my $fourthh = $fieldd[3];
    
    
    my $inheri = "";
	$inheri .=  "(InheritanceLink\n";
	$inheri .=  "      (Concept \"Actor $firstt\")\n";
	$inheri .=  "       (Concept \"Person\")\n";
	$inheri .=  "   )\n";
	$inheri;
	
    my $personid = "";
	$personid .= "   (ImplicationLink\n";
	$personid .=  "      (Concept \"Actor $firstt\")\n";
	$personid .=  "      (Concept \"Person $secondd\")\n";
	$personid .=  "   )\n";
	$personid;
	
    my $movieid = "";
	$movieid .= "   (MovieIdLink\n";
	$movieid .=  "      (Concept \"Actor $firstt\")\n";
	$movieid .=  "      (Concept \"Movie $thirdd\")\n";
	$movieid .=  "   )\n";
	$movieid;
	
    my $charname = "";
	$charname .=  "(EvaluationLink\n";
	$charname .=  "   (Predicate \"Has_character_name\")\n";
	$charname .= "   (ListLink\n";
	$charname .=  "      (Concept \"Actor $firstt\")\n";
	$charname .=  "      (Concept \"Char_name $fourthh\")\n";
	$charname .=  "   ))\n";
	$charname;
	
	
    print $op "$inheri\n $personid\n $movieid\n $charname  ";
}

while(<$ip3>) {
my @fielddd = split('--',$_);
    chomp;
        
    
    my $firsttt = $fielddd[0];
    my $seconddd = $fielddd[1];
    my $thirddd = $fielddd[2];
    
       
    my $inher = "";
	$inher .=  "(InheritanceLink\n";
	$inher .=  "      (Concept \"Director $firsttt\")\n";
	$inher .=  "       (Concept \"Person\")\n";
	$inher .=  "   )\n";
	$inher;
	
               
    my $personi = "";
	$personi .= "   (ImplicationLink\n";
	$personi .=  "      (Concept \"Director $firsttt\")\n";
	$personi .=  "      (Concept \"Person $seconddd\")\n";
	$personi .=  "   )\n";
	$personi;
	
    my $moviei = "";
	$moviei .= "   (MovieIdLink\n";
	$moviei .=  "      (Concept \"Director $firsttt\")\n";
	$moviei .=  "      (Concept \"Movie $thirddd\")\n";
	$moviei .=  "   )\n";
	$moviei;
		
    print $op "$inher\n $personi\n $moviei  ";
}

while(<$ip4>) {
my @fieldddd = split('--',$_);
    chomp;
        
    
    my $firstttt = $fieldddd[0];
    my $secondddd = $fieldddd[1];
       
    my $inhe = "";
	$inhe .=  "(InheritanceLink\n";
	$inhe .=  "      (Concept \"Person $firstttt\")\n";
	$inhe .=  "       (Concept \"Person\")\n";
	$inhe .=  "   )\n";
	$inhe;
	
                
    my $person = "";
	$person .= "   (NameLink\n";
	$person .=  "      (Concept \"Person $firstttt\")\n";
	$person .=  "      (Concept \"Name $secondddd\")\n";
	$person .=  "   )\n";
	$person;

    print $op "$inhe\n $person ";
}

close $op;
close $ip;
close $ip2;
close $ip3;
close $ip4;

exit(0);

# start sub-routine
sub ConnectToMySql {

my ($db) = @_;
# assign the values to your connection variable
my $connectionInfo="dbi:mysql:$db;$host";
# make connection to database
my $l_connection = DBI->connect($connectionInfo,$user,$pass);
# the value of this connection is returned by the sub-routine
return $l_connection;
}

