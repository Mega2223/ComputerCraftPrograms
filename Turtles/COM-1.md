# COM 1 COMMUNICATION STANDARD

## ID formations:

## Turtle ID formation:

``` [FUNCTION]-[COMPUTER_ID] ```

Functions:
SN - Snow clearer
MN - Standard miner

## Computer ID formation:
``` C[COMPUTER_ID]-[FUNCTION] ```

Functions:   
IN - Intelligence decision making computer  
MN - Manual user input computer  
SNC - Snow Cleaner Coordination Center

## Message formations

```[ID]:[MESSAGE]```

## Turtle order 
In message: ```[TURTLE_NAME]=>[ORDER]```   

### Snow plowers:
#### in  
CLR->[INT] [INT] [INT] [INT]  
orders the turtle to clear the coordinates, respectively x1,z1,x2,z2

#### out
RQ->[FLOAT]
requests a task from the central computer, the argument represents the current fuel level of the turtle, it maxes at 1.