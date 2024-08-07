#!/bin/bash
PSQL="psql -tAX -U freecodecamp -d periodic_table -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number = $1;")
  
  echo $ELEMENT_INFO | while IFS="|" read AT_NUM NAME SYM TYPE AT_MASS M_POINT B_POINT
  do
    if [[ -z $AT_NUM ]]
    then
      echo "I could not find that element in the database."
    else
      echo "The element with atomic number $AT_NUM is $NAME ($SYM). It's a $TYPE, with a mass of $AT_MASS amu. $NAME has a melting point of $M_POINT celsius and a boiling point of $B_POINT celsius."
    fi
  done

elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
then
  ELEMENT_INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol = '$1';")

  echo $ELEMENT_INFO | while IFS="|" read AT_NUM NAME SYM TYPE AT_MASS M_POINT B_POINT
  do
    if [[ -z $AT_NUM ]]
    then
      echo "I could not find that element in the database."
    else 
      echo "The element with atomic number $AT_NUM is $NAME ($SYM). It's a $TYPE, with a mass of $AT_MASS amu. $NAME has a melting point of $M_POINT celsius and a boiling point of $B_POINT celsius."
    fi
  done

elif [[ $1 =~ ^[A-Z][a-z][a-z]+$ ]]
then
  ELEMENT_INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius  FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name = '$1';")

  echo $ELEMENT_INFO | while IFS="|" read AT_NUM NAME SYM TYPE AT_MASS M_POINT B_POINT
  do
    if [[ -z $AT_NUM ]]
    then
      echo "I could not find that element in the database."
    else
      echo "The element with atomic number $AT_NUM is $NAME ($SYM). It's a $TYPE, with a mass of $AT_MASS amu. $NAME has a melting point of $M_POINT celsius and a boiling point of $B_POINT celsius."
    fi
  done

else
  echo "I could not find that element in the database."
fi
