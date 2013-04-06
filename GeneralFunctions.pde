//------------------------------BEGIN-PROCESS--------------------------------
void startProcess() {
  //convert chromosomes array to float values, then sort it, and returns a float array with two additional columns, one to store fitness and one empty to store pairing values
  calculate(bintoFloat(chromosomes), sortype);
  iteration++; // increment iteration counter
}

//-------BIN-TO-FLOAT FUNCTION---------
float[][] bintoFloat(Chromosome chromosomes[][]) {  //converts chromosomes bianry array to float and store it in paramresults[][] array
  int col = nbits*params;
  int row = nipop;
  int counterrow = 0;
  float result = 0; 
  float paramresults[][] = new float[nipop][params+2];  //creating paramresults array with 2 extra columns to store fitness values and pairing data

  //running trough chromosomes array
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      //checking the sign value(first digit) if it's positive or negative (0,1)
      if (chromosomes[i][j].chromoString.charAt(0) == '1') {
        //negative one 
        //converting from binary to float(negative one need to convert with custom convertion cause unbinary don't use a 1 as negative sign
        result = (unbinary(chromosomes[i][j].chromoString) - pow(2, nbits-1)) * -1; 
        chromosomes[i][j].diam = nbits*8; //setting diameter of the circle that represents that value

        if (result == -0.0) {  // taking care about minus sign in zero cases
          result = 0;
        }
      } 
      // if it is 0 is positive!
      else if (chromosomes[i][j].chromoString.charAt(0) == '0') {
        //positive
        result = unbinary(chromosomes[i][j].chromoString); //converting positive binary with simple builtin processing unbinary function
        chromosomes[i][j].diam = nbits*8;   //setting diameter of the circle that represents that value
      } 
      else if (chromosomes[i][j].chromoString.charAt(0) == ' ') {  //if aren't 0 or 1, is empty cause that space is not used by a chromosome value
        result = Float.NaN;  // set result as not a number value cause in a float array you can't assign null, so NaN was the solution
        chromosomes[i][j].diam = 0.01; // we set a really small diameter, cause the objects exist but if they are smallers, they not use the same memory as when they are nbits*8
      }
      chromosomes[i][j].chromoString = "" + result;  //setting chromoString for visualization
      displayMode = "decimal";                       // using decimal visualization mode!
      paramresults[i][(counterrow)] = result;       //store the new float value in paramresults[][] array  

      counterrow++;  // counter row var is taking care of multiple parameters, so we use counter row to do the binfloat process for each column(x,y,z....)
    } 
    if (counterrow >= paramresults[0].length-2) {
      counterrow = 0;
    }
  }
  return paramresults;  // returns paramresults[][] array
}


//-------------------------------CALCULATE FUNCTION----------------------------
void calculate(float paramresults[][], String sortype_) {  // sortype and paramresults[][] array generated by bintoFloat() method
  float result = 0;  // to store every fitness value
  float average = 0; //to calculate concurrency

  //calculating the function
  for (int i = 0; i < paramresults.length; i++) {
    float x = paramresults[i][0];  //take the float value from param results and store it in x var
    //float y = paramresults[i][1];
    //float z = paramresults[i][2];
    result =   sin(radians(sqrt(abs(x)))) * -x;  //f(x)=-xsen( √∣x∣ )  absolute value of sqrt(x)x   calculating the fitness value

        // if paramresults[i][0] is NaN we just ignore it
      if (Float.isNaN(paramresults[i][0])) {
    } 
    else {// if x has a value
      average += result; // adding results to average variable
      paramresults[i][paramresults[0].length-2] = result;  // storing fitness value in paramresults[][] array fitness column
    }
  }

  printFloat(paramresults);  //printing paramresults array
  int avgelements = paramresultsLim(paramresults); // counting how many elements have a number 
  convergence = average / avgelements;  //we get convergence value!
  println("Convergence = " + average+ "/" + avgelements + " = " + convergence);

  resultSort(paramresults, sortype_);  //sorting the results array according to sortype string and based on fitness column
  printFloat(paramresults);            //print paramresults array sorted

  // we check here if convergence equals the first value of fitness, if that is true we stop the program
  if (convergence == paramresults[0][paramresults[0].length-2]) {  
    //Adding last result to txt file
    results[iteration] = ("Iteration = " + iteration + "     x = " + chromosomes[0][0].chromoString + "     Fitness = " + paramresults[0][paramresults[0].length-2] + "     Convergence = " + convergence);
    // Saving to File
    saveStrings("salida.txt", results);
    saveFrame("proceso.jpg");
    exit();
  }

  matingPool(paramresults);    //matingPool function to define Ngood,Nbad,Npop. it's the first step to have beautiful chromosomes
  pairingChamp(paramresults);  //pairing chromosomes using championship technique
  crossing(paramresults);      //crossing function make our new chromosomes!
  printBinary();               //print chromosomes array to see our new chromosomes
}

//------------------MATINGPOOL---------------
void matingPool(float paramresults[][]) {
  println("--------------MATING POOL----------------------");  // tell the user we are doing the mating pool function
  int looplim = paramresultsLim(paramresults);  // this variable tell us how many numeric values we have in paramresults array using the paramresultsLim function
  println("LOOPLIM = " + looplim );

  //Generating nPop,nGood,nBad values
  nPop = (round(random(1, looplim)));
  nGood = (round(random(1, nPop)));
  nBad = nPop-nGood;
  println("nPop = " + nPop + " nGood = " +nGood + " Nbad = " +nBad);
}

//-----------------PAIRING-------------------
void pairingChamp(float paramresults[][]) {
  // in this function we search for the best chromosomes and we make new ones with that data
  // we are just saying wich chromosome needs to cross and wich one not 
  
  for (int i = 0; i < nGood; i++) {
    //generate parents using random
    int parent1 = ceil((nGood*random(0, 1)));   //ceil function is like a round up function
    int parent2 = ceil((nGood*random(0, 1))); 
    float parentmin = min(parent1, parent2);  //the min value of parent 1 and parent 2 is the best one!
    println("p1 = " +  parent1 + " p2 = " + parent2 + " min = " + parentmin); // we print the results
    
    //cwe copy the best chromosome that is stored in parantmin var and store it in paramresults array
    paramresults[i][paramresults[0].length-1] = parentmin;
  }
  printFloat(paramresults); // print the results of the process again
}


//----------------------------- ---CROSSING------------------------------------------------
void crossing(float paramresults[][]) { 
  println("------------------CROSSING---------------------");
  //printing and running trough results array
  int limit = paramresults.length; //to know how many numeric values we have
  // Setting limit of pairs
  for (int j = 0; j < limit; j++) {
    if (paramresults[j][paramresults[0].length-1] == 0) { //if we have a 0 value in our paramresults fitness column we know our new limit
      limit = j;  
      println("limit = " + limit);
    }
  }

  cleanChromosomes(); // cleaning chromosomes array to save new ones!

  displayMode = "binary";  // we want know to see the circles with binary values
  int saveIndex = 0;     //store the index value of the current chromosome
  int auxlimit = 0;    // to cross chromosomes 2 by 2 each time
  String cad1  = "";  // to save chromosome1 to be crossed
  String cad2 = "";   // to save chromosome2 to be crossed
  
  //Generating auxiliar random chromosomeGorup for crossing
  //if are numeric values....
  while (auxlimit < limit) {
    String auxbin = "";
    //writing on auxbin
    for (int j = 0; j < nbits; j++) {
      char status;
      if (random(0, 1) < 0.5) {  
        status = '0';
      } 
      else {
        status = '1';
      }
      auxbin = auxbin + status;
    }

    //converting paramresults from float to binary values
    float index0, index1; // we need indexes to know wich chromosomes wich reproduce
    //storing indexes
    index0 = paramresults[auxlimit][paramresults[0].length-1] ;
    index1 = paramresults[auxlimit+1][paramresults[0].length-1] ;

    if (index1 == 0) {  //if is an odd number index1 take index0 to cross with itself
      index1 = index0;
    }

    //tell us what chromosomes will be crossed
    println("in0: " + index0);
    println("in1: " + index1);

    //setting cad1 
    if (paramresults[(int)index0-1][0] < 0) {  
      // if is negative number
      cad1 = "1" + binary(abs((int)paramresults[(int)index0-1][0]), nbits-1);
    } 
    else {
      // if is positive number
      cad1 = "0" + binary(abs((int)paramresults[(int)index0-1][0]), nbits-1);
    }

    //setting cad2 
    if (paramresults[(int)index1-1][0] < 0) {  // if is negative number
      cad2 = "1" + binary(abs((int)paramresults[(int)index1-1][0]), nbits-1);
    } 
    else {
      cad2 = "0" + binary(abs((int)paramresults[(int)index1-1][0]), nbits-1);
    }
    println("cad1 = " +cad1);
    println("cad2 = " +cad2);

    //Crossing with uniform cross
    //auxstrings cause we can't modifiy an already assigned string
    String auxcad1 = ""; 
    String auxcad2 = "";
    //running trough auxbin string
    for (int i = 0; i < auxbin.length(); i++) {
      if (auxbin.charAt(i) == '1') {  //if auxbin char is '1' we exchange chars between cad1 and cad2
        auxcad1 = auxcad1+cad2.charAt(i);
        auxcad2 = auxcad2+cad1.charAt(i);
      }
      else if (auxbin.charAt(i) =='0') {  //if auxbin char is '0' cad1 & cad2 stays
        auxcad1 = auxcad1+cad1.charAt(i);
        auxcad2 = auxcad2+cad2.charAt(i);
      }
    }
    //printing values
    println("auxcad1 = " + auxcad1);
    println("auxbin  = " + auxbin);
    println("auxcad2 = " + auxcad2);

    auxlimit = auxlimit+2;  //we jump to next 2 chromosomes
    
    //save the new two chromosomes in chromosomes array
    chromosomes[saveIndex][0].chromoString=auxcad1;
    chromosomeCounter ++;
    chromosomes[saveIndex+1][0].chromoString=auxcad2;
    chromosomeCounter ++;

    //mutation issue 
    if (chromosomeCounter == 100) {  //every 100 chromosomes we have a mutation
      String chromoStringaux = " ";
      for (int i = 0; i < chromosomes[saveIndex][0].chromoString.length()-1; i++) {
        chromoStringaux += chromosomes[saveIndex][0].chromoString.charAt(i);
      } 
      if (chromosomes[saveIndex][0].chromoString.charAt(chromosomes[saveIndex][0].chromoString.length()) == '1') {
        chromoStringaux += '0';
      } 
      else if (chromosomes[saveIndex][0].chromoString.charAt(chromosomes[saveIndex][0].chromoString.length()) == '0') {
        chromoStringaux += '1';
      }
      chromosomes[saveIndex][0].chromoString  = chromoStringaux;
    }


    saveIndex = saveIndex+2; // we jump to next two chromomosomes changing by 2 the current indexes
    println("auxlimit = " + auxlimit); //print how many new chromosomes we have
  }
  //if we don't have more numeric values we finish crossing process and store the new chromosomes in chromosomes array
  println("STOP CROSSING-------");
  //seeing if we have an odd or pair number of new chromosomes 
  int limit__;
  if (limit%2 == 0) {
    limit__ = limit;
  } 
  else {
    limit__ = limit+1;
  }
  infoText = (limit__ + " new Chromosomes"); //String to show messages on screen
  println(limit__ + " Chromosomes Generated by uniform Cross"); //printing how many new chromosomes we have!
  //we add a string with information to results string array, we will save all the results of the array in a txt file at the end of the program
  results[iteration] = ("Iteration = " + iteration + "     x = " + chromosomes[0][0].chromoString + "     Fitness = " + paramresults[0][paramresults[0].length-2] + "     Convergence = " + convergence);
  cleanparamresults(paramresults); //cleaning paramresults to save new values in the next iteration
}

//--------------------------------DISPLAY,PRINT,SORT,CLEAN & CONVERTION FUNCTIONS------------------------------------
//print chromoString param for every chromosome group
void printBinary() {
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      print("[" + chromosomes[i][j].chromoString + "]");
    }
    print("\n");
  }
}

//print paramResults Array
void printFloat(float paramresults[][]) {
  //printinr and running trough results array
  for (int i = 0; i < paramresults.length; i++) {
    for (int j = 0; j < paramresults[0].length; j++) {
      print("[" + paramresults[i][j] + "] ");
    } 
    print("\n");
  }
}

//tell us how many numeric values are in paramresults array
int paramresultsLim(float paramresults[][]) {
  int looplim = paramresults.length;
  for (int i = 0; i < looplim; i++) {
    if ( Float.isNaN(paramresults[i][0])) {
      looplim = i;
    }
  }
  return looplim;
}


//for clean chromosomes.chromoString array
void cleanChromosomes() {
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      chromosomes[i][j].chromoString = " ";
    }
  }
}

//for clean paramresults array
void cleanparamresults(float[][] paramresults) {
  for (int i = 0; i < paramresults.length; i++) {
    for (int j = 0; j < paramresults[0].length; j++) {
      paramresults[i][j] =Float.NaN;
    }
  }
}


// helps us to display chromosomes on screen
void displayChromosomes(String displayMode) {
  for (int i = 0; i < chromosomes.length; i++) {
    for (int j = 0; j < chromosomes[0].length; j++) {
      chromosomes[i][j].display(displayMode);
    }
  }
}

//this function sort param results array according to fitness column
//it uses bubble sort method
void resultSort(float paramresults[][], String sortype) {
  int row = paramresults.length;  
  int col = paramresults[0].length;
  float [] aux = new float [col];

  if (sortype == "minmax") {   //sort from min to max 
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < row-1; j++) {
        if (paramresults[j][(paramresults[0].length -2)] > paramresults[j+1][(paramresults[0].length -2)]) {
          for (int k = 0; k < col; k++) {
            aux[k] = paramresults[j][k];
            paramresults[j][k] = paramresults[j+1][k];
            paramresults[j+1][k] = aux[k];
          }
        }
      }
    }
    println("SORTING from min to max...");
  } 
  else if (sortype == "maxmin") {   //sort from max to min
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < row-1; j++) {
        if (paramresults[j][(paramresults[0].length -2)] < paramresults[j+1][(paramresults[0].length -2)]) {
          for (int k = 0; k < col; k++) {
            aux[k] = paramresults[j][k];
            paramresults[j][k] = paramresults[j+1][k];
            paramresults[j+1][k] = aux[k];
          }
        }
      }
    }
    println("SORTING from max to min...");
  }
  else {
    println("sort string needs to be 'minmax' or 'maxmin' in order to sort"); //error in the string
  }
}


